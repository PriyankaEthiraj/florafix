import 'package:flutter/material.dart';
import 'about_screen.dart'; // Import About screen
import 'help_support_screen.dart'; // Import Help & Support screen

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final Function(bool) onThemeChange;
  final Function(bool) onNotificationToggle;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.notificationsEnabled,
    required this.onThemeChange,
    required this.onNotificationToggle,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool notificationsEnabled;
  late bool darkModeEnabled;

  @override
  void initState() {
    super.initState();
    notificationsEnabled = widget.notificationsEnabled;
    darkModeEnabled = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings ⚙️"),
        backgroundColor: darkModeEnabled ? Colors.black : Colors.teal[700],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle("Preferences"),
          _buildSwitchTile(
            icon: Icons.notifications,
            title: "Enable Notifications",
            subtitle: "Get reminders and updates",
            value: notificationsEnabled,
            onChanged: (value) => _updateSettings(value, 'notifications'),
          ),
          _buildSwitchTile(
            icon: Icons.dark_mode,
            title: "Dark Mode",
            subtitle: "Reduce eye strain with dark theme",
            value: darkModeEnabled,
            onChanged: (value) => _updateSettings(value, 'darkMode'),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Account"),
          _buildListTile(
            icon: Icons.person,
            title: "Profile",
            subtitle: "Manage your account details",
            onTap: () {},
          ),
          _buildListTile(
            icon: Icons.lock,
            title: "Change Password",
            subtitle: "Update your account password",
            onTap: () {},
          ),
          const SizedBox(height: 20),
          _buildSectionTitle("Support"),
          _buildListTile(
            icon: Icons.help_outline,
            title: "Help & Support",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HelpSupportScreen()),
              );
            },
          ),
          _buildListTile(
            icon: Icons.info_outline,
            title: "About Florogenix",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _updateSettings(bool value, String settingType) {
    setState(() {
      if (settingType == 'notifications') {
        notificationsEnabled = value;
        widget.onNotificationToggle(value);
      } else if (settingType == 'darkMode') {
        darkModeEnabled = value;
        widget.onThemeChange(value);
      }
    });
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.teal[800],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      secondary: Icon(icon, color: Colors.teal[700]),
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.teal[700],
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    String? subtitle,
    required Function() onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal[700]),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
