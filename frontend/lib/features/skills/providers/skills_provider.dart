import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/skill.dart';

// Selected skill category state
final selectedSkillCategoryProvider = StateProvider<String>((ref) => 'All');

// Skills data provider
final skillsProvider = FutureProvider<List<Skill>>((ref) async {
  // TODO: Replace with actual API call
  await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
  return [
    // Languages
    Skill(
      name: 'Dart',
      category: 'Languages',
      iconUrl: 'assets/icons/dart.svg',
      proficiency: 5,
      description: 'Primary language for Flutter development',
    ),
    Skill(
      name: 'Python',
      category: 'Languages',
      iconUrl: 'assets/icons/python.svg',
      proficiency: 4,
      description: 'Used for backend development and AI/ML projects',
    ),
    Skill(
      name: 'TypeScript',
      category: 'Languages',
      iconUrl: 'assets/icons/typescript.svg',
      proficiency: 4,
      description: 'Modern JavaScript development with type safety',
    ),

    // Frameworks
    Skill(
      name: 'Flutter',
      category: 'Frameworks',
      iconUrl: 'assets/icons/flutter.svg',
      proficiency: 5,
      description: 'Cross-platform app development framework',
    ),
    Skill(
      name: 'React',
      category: 'Frameworks',
      iconUrl: 'assets/icons/react.svg',
      proficiency: 4,
      description: 'Web application development with React ecosystem',
    ),
    Skill(
      name: 'Node.js',
      category: 'Frameworks',
      iconUrl: 'assets/icons/nodejs.svg',
      proficiency: 4,
      description: 'Server-side JavaScript runtime',
    ),

    // Databases
    Skill(
      name: 'PostgreSQL',
      category: 'Databases',
      iconUrl: 'assets/icons/postgresql.svg',
      proficiency: 4,
      description: 'Relational database for scalable applications',
    ),
    Skill(
      name: 'MongoDB',
      category: 'Databases',
      iconUrl: 'assets/icons/mongodb.svg',
      proficiency: 3,
      description: 'NoSQL database for flexible data structures',
    ),
    Skill(
      name: 'Firebase',
      category: 'Databases',
      iconUrl: 'assets/icons/firebase.svg',
      proficiency: 4,
      description: 'Real-time database and backend services',
    ),

    // Cloud & DevOps
    Skill(
      name: 'AWS',
      category: 'Cloud & DevOps',
      iconUrl: 'assets/icons/aws.svg',
      proficiency: 3,
      description: 'Cloud infrastructure and services',
    ),
    Skill(
      name: 'Docker',
      category: 'Cloud & DevOps',
      iconUrl: 'assets/icons/docker.svg',
      proficiency: 4,
      description: 'Containerization for consistent deployments',
    ),
    Skill(
      name: 'GitHub Actions',
      category: 'Cloud & DevOps',
      iconUrl: 'assets/icons/github.svg',
      proficiency: 4,
      description: 'CI/CD automation and workflows',
    ),

    // AI & ML
    Skill(
      name: 'TensorFlow',
      category: 'AI & ML',
      iconUrl: 'assets/icons/tensorflow.svg',
      proficiency: 3,
      description: 'Machine learning and neural networks',
    ),
    Skill(
      name: 'OpenAI',
      category: 'AI & ML',
      iconUrl: 'assets/icons/openai.svg',
      proficiency: 4,
      description: 'AI integration and language models',
    ),
  ];
});

// Available skill categories provider
final skillCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final skills = await ref.watch(skillsProvider.future);
  final categories = skills.map((s) => s.category).toSet().toList();
  return ['All', ...categories];
});

// Filtered skills based on selected category
final filteredSkillsProvider = FutureProvider<List<Skill>>((ref) async {
  final selectedCategory = ref.watch(selectedSkillCategoryProvider);
  final skills = await ref.watch(skillsProvider.future);

  if (selectedCategory == 'All') {
    return skills;
  }

  return skills.where((s) => s.category == selectedCategory).toList();
});
