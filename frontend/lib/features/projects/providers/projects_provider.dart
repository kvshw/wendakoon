import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/project.dart';

// Selected category state
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

// Projects data provider
final projectsProvider = FutureProvider<List<Project>>((ref) async {
  // TODO: Replace with actual API call
  await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
  return [
    Project(
      id: '1',
      title: 'WendaKoon Portfolio',
      description:
          'A modern portfolio website built with Flutter Web, featuring a beautiful UI and seamless animations',
      imageUrl: 'https://picsum.photos/seed/portfolio/400/300',
      technologies: ['Flutter', 'Dart', 'Firebase', 'GitHub API'],
      categories: ['Web', 'Frontend'],
      githubUrl: 'https://github.com/kvshw/wendakoon',
      liveUrl: 'https://wendakoon.dev',
      createdAt: DateTime.now(),
      isFeatured: true,
    ),
    Project(
      id: '2',
      title: 'Task Master AI',
      description:
          'An AI-powered task management system that helps break down complex projects into manageable tasks',
      imageUrl: 'https://picsum.photos/seed/taskmaster/400/300',
      technologies: ['Python', 'FastAPI', 'OpenAI', 'SQLite'],
      categories: ['Backend', 'AI'],
      githubUrl: 'https://github.com/kvshw/taskmaster-ai',
      createdAt: DateTime.now(),
      isFeatured: true,
    ),
    Project(
      id: '3',
      title: 'DevFlow',
      description:
          'A developer productivity tool that streamlines the workflow between different development tools',
      imageUrl: 'https://picsum.photos/seed/devflow/400/300',
      technologies: ['TypeScript', 'Node.js', 'Express', 'MongoDB'],
      categories: ['Backend', 'Tools'],
      githubUrl: 'https://github.com/kvshw/devflow',
      createdAt: DateTime.now(),
      isFeatured: false,
    ),
    Project(
      id: '4',
      title: 'Code Mentor',
      description:
          'An AI-powered code review and mentoring platform for developers',
      imageUrl: 'https://picsum.photos/seed/codementor/400/300',
      technologies: ['React', 'Next.js', 'GPT-4', 'PostgreSQL'],
      categories: ['Web', 'AI'],
      githubUrl: 'https://github.com/kvshw/code-mentor',
      liveUrl: 'https://code-mentor.dev',
      createdAt: DateTime.now(),
      isFeatured: true,
    ),
    Project(
      id: '5',
      title: 'EcoTrack',
      description:
          'A mobile app for tracking personal carbon footprint with ML-powered recommendations',
      imageUrl: 'https://picsum.photos/seed/ecotrack/400/300',
      technologies: ['Flutter', 'TensorFlow Lite', 'Firebase', 'Node.js'],
      categories: ['Mobile', 'AI'],
      githubUrl: 'https://github.com/kvshw/ecotrack',
      liveUrl: 'https://ecotrack.app',
      createdAt: DateTime.now(),
      isFeatured: true,
    ),
    Project(
      id: '6',
      title: 'CryptoVault',
      description:
          'A secure cryptocurrency wallet with multi-signature support and real-time market analytics',
      imageUrl: 'https://picsum.photos/seed/cryptovault/400/300',
      technologies: ['React Native', 'Solidity', 'Web3.js', 'AWS'],
      categories: ['Mobile', 'Blockchain'],
      githubUrl: 'https://github.com/kvshw/cryptovault',
      createdAt: DateTime.now(),
      isFeatured: false,
    ),
    Project(
      id: '7',
      title: 'HealthSync',
      description:
          'An IoT-based health monitoring system with real-time alerts and doctor consultation',
      imageUrl: 'https://picsum.photos/seed/healthsync/400/300',
      technologies: ['Flutter', 'Arduino', 'MQTT', 'MongoDB'],
      categories: ['Mobile', 'IoT'],
      githubUrl: 'https://github.com/kvshw/healthsync',
      liveUrl: 'https://healthsync.io',
      createdAt: DateTime.now(),
      isFeatured: true,
    ),
    Project(
      id: '8',
      title: 'SmartHome Hub',
      description:
          'A centralized home automation system with voice control and energy optimization',
      imageUrl: 'https://picsum.photos/seed/smarthome/400/300',
      technologies: ['Python', 'Raspberry Pi', 'TensorFlow', 'MQTT'],
      categories: ['IoT', 'AI'],
      githubUrl: 'https://github.com/kvshw/smarthome-hub',
      createdAt: DateTime.now(),
      isFeatured: false,
    ),
    Project(
      id: '9',
      title: 'GameCraft',
      description:
          'A 3D game engine built from scratch with modern graphics and physics capabilities',
      imageUrl: 'https://picsum.photos/seed/gamecraft/400/300',
      technologies: ['C++', 'OpenGL', 'Vulkan', 'CMake'],
      categories: ['Systems', 'Graphics'],
      githubUrl: 'https://github.com/kvshw/gamecraft',
      createdAt: DateTime.now(),
      isFeatured: true,
    ),
    Project(
      id: '10',
      title: 'CloudScale',
      description:
          'A serverless deployment platform with automatic scaling and monitoring',
      imageUrl: 'https://picsum.photos/seed/cloudscale/400/300',
      technologies: ['Go', 'Kubernetes', 'Terraform', 'Prometheus'],
      categories: ['DevOps', 'Backend'],
      githubUrl: 'https://github.com/kvshw/cloudscale',
      liveUrl: 'https://cloudscale.dev',
      createdAt: DateTime.now(),
      isFeatured: true,
    ),
  ];
});

// Available categories provider
final projectCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final projects = await ref.watch(projectsProvider.future);
  final categories = projects.expand((p) => p.categories).toSet().toList();
  return ['All', ...categories];
});

// Filtered projects based on selected category
final filteredProjectsProvider = FutureProvider<List<Project>>((ref) async {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final projects = await ref.watch(projectsProvider.future);

  if (selectedCategory == 'All') {
    return projects;
  }

  return projects
      .where((p) => p.categories.contains(selectedCategory))
      .toList();
});
