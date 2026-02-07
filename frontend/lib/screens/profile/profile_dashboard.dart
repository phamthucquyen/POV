import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileDashboard extends StatelessWidget {
  const ProfileDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;
    
    // Mock values for now (replace with Supabase later)
    const int placesVisited = 12;
    const int scansThisWeek = 3;
    const int streakDays = 2;

    final recent = const [
      _RecentScan(title: 'Fushimi Inari', subtitle: 'Kyoto • Yesterday'),
      _RecentScan(title: 'Kinkaku-ji', subtitle: 'Kyoto • 3 days ago'),
      _RecentScan(title: 'Tokyo Tower', subtitle: 'Tokyo • Last week'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon')),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  child: Text(
                    user?.email?.substring(0, 1).toUpperCase() ?? 'U',
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  user?.email ?? 'User',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Member since ${DateTime.now().year - 1}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stats row
          Row(
            children: [
              _StatCard(
                  icon: Icons.place, label: 'Places', value: '$placesVisited'),
              const SizedBox(width: 12),
              _StatCard(
                  icon: Icons.calendar_month,
                  label: 'This week',
                  value: '$scansThisWeek'),
              const SizedBox(width: 12),
              _StatCard(
                  icon: Icons.local_fire_department,
                  label: 'Streak',
                  value: '${streakDays}d'),
            ],
          ),

          const SizedBox(height: 24),

          // Recent Activity
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activity',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('View full history coming soon')),
                  );
                },
                child: const Text('See all'),
              ),
            ],
          ),

          const SizedBox(height: 8),

          ...recent.map((r) => _RecentScanTile(scan: r)),

          const SizedBox(height: 24),

          // Account Actions
          const Text(
            'Account',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),

          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Edit profile coming soon')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  title: const Text('Notifications'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notifications coming soon')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Privacy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Privacy settings coming soon')),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Sign Out', style: TextStyle(color: Colors.red)),
                  onTap: () async {
                    await supabase.auth.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacementNamed('/login');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),
              const SizedBox(height: 10),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 2),
              Text(label, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentScan {
  final String title;
  final String subtitle;
  const _RecentScan({required this.title, required this.subtitle});
}

class _RecentScanTile extends StatelessWidget {
  final _RecentScan scan;
  const _RecentScanTile({required this.scan});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.image)),
        title: Text(scan.title,
            style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(scan.subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Scan details coming soon')),
          );
        },
      ),
    );
  }
}
