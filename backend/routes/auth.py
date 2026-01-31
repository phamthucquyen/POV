from fastapi import APIRouter, HTTPException, Depends, Header
from pydantic import BaseModel
from typing import Optional

router = APIRouter(prefix="/auth", tags=["auth"])

# mock store
USERS = {}   # email -> {"email":..., "password":..., "username":...}
TOKENS = {}  # token -> email

class SignupIn(BaseModel):
    username: str
    email: str
    password: str

class LoginIn(BaseModel):
    email: str
    password: str

class TokenOut(BaseModel):
    access_token: str

class UserOut(BaseModel):
    email: str
    username: str

def get_current_user(authorization: Optional[str] = Header(default=None)) -> dict:
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing token")
    token = authorization.split(" ", 1)[1]
    email = TOKENS.get(token)
    if not email or email not in USERS:
        raise HTTPException(status_code=401, detail="Invalid token")
    return USERS[email]

@router.post("/signup", response_model=TokenOut)
def signup(payload: SignupIn):
    if payload.email in USERS:
        raise HTTPException(status_code=400, detail="Email already exists")
    USERS[payload.email] = {
        "email": payload.email,
        "password": payload.password,
        "username": payload.username,
    }
    token = f"mocktoken-{payload.email}"
    TOKENS[token] = payload.email
    return {"access_token": token}

@router.post("/login", response_model=TokenOut)
def login(payload: LoginIn):
    user = USERS.get(payload.email)
    if not user or user["password"] != payload.password:
        raise HTTPException(status_code=401, detail="Invalid credentials")
    token = f"mocktoken-{payload.email}"
    TOKENS[token] = payload.email
    return {"access_token": token}

@router.get("/me", response_model=UserOut)
def me(user=Depends(get_current_user)):
    return {"email": user["email"], "username": user["username"]}
