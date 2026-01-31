import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final email = _email.text.trim();
    final password = _password.text;

    if (!email.contains('@')) {
      setState(() => _error = 'Please enter a valid email.');
      return;
    }
    if (password.isEmpty) {
      setState(() => _error = 'Please enter your password.');
      return;
    }

    setState(() {
      _error = null;
      _loading = true;
    });

    // TODO: hook backend /auth/login here
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => _loading = false);

    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/onboarding');
  }

  // ===== Figma specs =====
  static const double _frameWidth = 393;

  static const Color _titleColor = Color(0xFF363E44);
  static const Color _fieldBg = Color(0xFFEDFFFC);
  static const Color _buttonBg = Color(0xFF9EE3D8);

  // Title = Tilt Warp
  static const TextStyle _titleStyle = TextStyle(
    color: _titleColor,
    fontFamily: 'Tilt Warp',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.28125, // 41/32
  );

  // Everything else = Comfortaa
  static const TextStyle _body16Comfortaa = TextStyle(
    color: _titleColor,
    fontFamily: 'Comfortaa',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.33, // 21.289/16 approx
  );

  static const TextStyle _hintComfortaa = TextStyle(
    color: Color(0xFFB9B9B9),
    fontFamily: 'Comfortaa',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static const TextStyle _dividerComfortaa = TextStyle(
    color: _titleColor,
    fontFamily: 'Comfortaa',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static const TextStyle _buttonTextComfortaa = TextStyle(
    color: Colors.white,
    fontFamily: 'Comfortaa',
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.33,
  );

  static const TextStyle _createAccountComfortaa = TextStyle(
    color: _buttonBg,
    fontFamily: 'Comfortaa',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.33,
  );

  Widget _authTextField({
    required TextEditingController controller,
    required String hint,
    bool obscure = false,
  }) {
    return SizedBox(
      width: 346,
      height: 56,
      child: Container(
        decoration: BoxDecoration(
          color: _fieldBg,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.20),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: TextField(
          controller: controller,
          obscureText: obscure,
          style: _body16Comfortaa.copyWith(fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: _hintComfortaa,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          ),
        ),
      ),
    );
  }

  Widget _primaryButton() {
    return SizedBox(
      width: 346,
      height: 48,
      child: ElevatedButton(
        onPressed: _loading ? null : _onLogin,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: _buttonBg,
          disabledBackgroundColor: _buttonBg.withOpacity(0.6),
          padding: const EdgeInsets.symmetric(horizontal: 19.353, vertical: 12.58),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: _loading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text('Log in', style: _buttonTextComfortaa),
      ),
    );
  }

  Widget _dividerRow() {
    return Row(
      children: const [
        Expanded(child: Divider(thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('Or Sign in with', style: _dividerComfortaa),
        ),
        Expanded(child: Divider(thickness: 1)),
      ],
    );
  }

  static Widget _socialBox({required Widget child}) {
    return SizedBox(
      width: 88,
      height: 56,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          side: const BorderSide(color: _titleColor, width: 1),
        ),
        child: Center(child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: _frameWidth),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                              onPressed: () => Navigator.maybePop(context),
                              icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: _titleColor),
                            ),

                            const SizedBox(height: 18),

                            const SizedBox(
                              width: 344,
                              child: Text(
                                "Welcome back!\nGlad to see you, again",
                                style: _titleStyle,
                              ),
                            ),

                            const SizedBox(height: 28),

                            _authTextField(controller: _email, hint: "Enter your email"),
                            const SizedBox(height: 16),
                            _authTextField(controller: _password, hint: "Enter your password", obscure: true),

                            const SizedBox(height: 4),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text('Forgot Password?', style: _body16Comfortaa),
                              ),
                            ),

                            if (_error != null) ...[
                              const SizedBox(height: 6),
                              Text(
                                _error!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Comfortaa',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  height: 1.33,
                                ),
                              ),
                            ] else
                              const SizedBox(height: 6),

                            _primaryButton(),

                            const SizedBox(height: 64),

                            _dividerRow(),

                            const SizedBox(height: 18),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _socialBox(
                                  child: const Text(
                                    'f',
                                    style: TextStyle(
                                      color: _titleColor,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                _socialBox(
                                  child: const Text(
                                    'G',
                                    style: TextStyle(
                                      color: _titleColor,
                                      fontFamily: 'Comfortaa',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                _socialBox(
                                  child: const Icon(Icons.apple, size: 26, color: _titleColor),
                                ),
                              ],
                            ),

                            const Spacer(),

                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('Create an account', style: _createAccountComfortaa),
                              ),
                            ),

                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
