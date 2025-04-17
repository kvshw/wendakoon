import 'package:flutter/material.dart';
import '../../profile/screens/profile_screen.dart';
import '../../projects/screens/projects_screen.dart';
import '../../skills/screens/skills_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ProfileScreen(),
    const ProjectsScreen(),
    const SkillsScreen(),
  ];

  final List<String> _titles = [
    'Profile',
    'Projects',
    'Skills',
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex]),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        height: 56,
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.grey.shade900 : Colors.white,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(0, Icons.person_outline_rounded,
                  Icons.person_rounded, 'Profile'),
              _buildNavItem(1, Icons.work_outline_rounded, Icons.work_rounded,
                  'Projects'),
              _buildNavItem(
                  2, Icons.code_rounded, Icons.code_rounded, 'Skills'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      int index, IconData icon, IconData selectedIcon, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              size: 20,
              color: isSelected
                  ? isDark
                      ? Colors.white
                      : Colors.black87
                  : isDark
                      ? Colors.white60
                      : Colors.black54,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? isDark
                        ? Colors.white
                        : Colors.black87
                    : isDark
                        ? Colors.white60
                        : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
