import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wendakoon/features/profile/models/github_repository.dart';
import 'package:wendakoon/features/profile/providers/profile_provider.dart';
import 'package:wendakoon/features/profile/widgets/animated_stats_card.dart';
import 'package:wendakoon/features/profile/widgets/profile_avatar.dart';
import 'package:wendakoon/features/profile/widgets/project_card.dart';
import 'package:wendakoon/features/profile/widgets/social_link_card.dart';
import 'package:wendakoon/core/providers/theme_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);
    final repositoriesAsync = ref.watch(repositoriesProvider);
    final statsAsync = ref.watch(statsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode : Icons.dark_mode,
              color: Colors.white,
            ),
            onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade900,
              Colors.black,
            ],
          ),
        ),
        child: SafeArea(
          child: profileAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error: $error',
                  style: const TextStyle(color: Colors.white)),
            ),
            data: (profile) => SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  ProfileAvatar(
                    imageUrl: profile.avatarUrl,
                    size: 120,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    profile.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '@${profile.username}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '01.10.1996',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.school,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PhD Student',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        profile.location,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    profile.bio,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 32),
                  statsAsync.when(
                    loading: () => const CircularProgressIndicator(),
                    error: (error, stack) => Text(
                      'Error loading stats',
                      style: TextStyle(color: Colors.white.withOpacity(0.7)),
                    ),
                    data: (stats) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedStatsCard(
                          icon: FontAwesomeIcons.github,
                          count: stats['repositories'].toString(),
                          iconColor: Colors.white,
                        ),
                        AnimatedStatsCard(
                          icon: FontAwesomeIcons.code,
                          count: stats['projects'].toString(),
                          iconColor: Colors.green,
                        ),
                        AnimatedStatsCard(
                          icon: FontAwesomeIcons.star,
                          count: stats['stars'].toString(),
                          iconColor: Colors.amber,
                        ),
                        AnimatedStatsCard(
                          icon: FontAwesomeIcons.users,
                          count: stats['followers'].toString(),
                          iconColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  SocialLinkCard(
                    title: 'Email',
                    subtitle: profile.email.isNotEmpty
                        ? profile.email
                        : 'kaveebhashiofficial@gmail.com',
                    icon: Icons.email,
                    backgroundColor: Colors.blue.shade800,
                    url:
                        'mailto:${profile.email.isNotEmpty ? profile.email : 'kaveebhashiofficial@gmail.com'}',
                  ),
                  const SizedBox(height: 16),
                  SocialLinkCard(
                    title: 'GitHub',
                    subtitle: '@${profile.username}',
                    icon: FontAwesomeIcons.github,
                    backgroundColor:
                        isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    url: 'https://github.com/${profile.username}',
                  ),
                  const SizedBox(height: 16),
                  SocialLinkCard(
                    title: 'LinkedIn',
                    subtitle: 'in/kavishwa-wendakoon',
                    icon: FontAwesomeIcons.linkedin,
                    backgroundColor: Colors.blue.shade700,
                    url: 'https://www.linkedin.com/in/kavishwa-wendakoon/',
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      const Text(
                        'Projects',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => launchUrl(
                          Uri.parse(
                              'https://github.com/${profile.username}?tab=repositories'),
                        ),
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  repositoriesAsync.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => Center(
                      child: Text(
                        'Error loading repositories',
                        style: TextStyle(color: Colors.white.withOpacity(0.7)),
                      ),
                    ),
                    data: (repositories) => GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: repositories.length,
                      itemBuilder: (context, index) {
                        final repo = repositories[index];
                        return ProjectCard(
                          name: repo.name,
                          description: repo.description,
                          language: repo.language,
                          languageColor: Color(repo.languageColor),
                          stars: repo.stars,
                          url: repo.url,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
