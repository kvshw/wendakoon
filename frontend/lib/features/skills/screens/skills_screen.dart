import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/skills_provider.dart';
import '../models/skill.dart';

class SkillsScreen extends ConsumerWidget {
  const SkillsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selectedCategory = ref.watch(selectedSkillCategoryProvider);
    final skillsAsync = ref.watch(filteredSkillsProvider);
    final categories = ref.watch(skillCategoriesProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6B2FD9),
              const Color(0xFF1E1B4B),
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 0,
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Categories
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white70 : Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 36,
                  child: categories.when(
                    data: (categories) => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        final isSelected = selectedCategory == category;
                        return FilterChip(
                          selected: isSelected,
                          label: Text(category),
                          labelStyle: TextStyle(
                            fontSize: 13,
                            color: isSelected
                                ? Colors.white
                                : isDark
                                    ? Colors.white70
                                    : Colors.white.withOpacity(0.7),
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          backgroundColor: isDark
                              ? Colors.white.withOpacity(0.1)
                              : Colors.white.withOpacity(0.15),
                          selectedColor: Theme.of(context).colorScheme.primary,
                          checkmarkColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? Colors.transparent
                                  : isDark
                                      ? Colors.white24
                                      : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          onSelected: (selected) {
                            ref
                                .read(selectedSkillCategoryProvider.notifier)
                                .state = category;
                          },
                        );
                      },
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Text(
                      'Error loading categories',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Skills Grid
                skillsAsync.when(
                  data: (skills) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: skills.length,
                      itemBuilder: (context, index) {
                        final skill = skills[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.white.withOpacity(0.2),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: SkillCard(skill: skill),
                        );
                      },
                    ),
                  ),
                  error: (error, stack) => Center(
                    child: Text(
                      'Error: $error',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  final Skill skill;

  const SkillCard({
    super.key,
    required this.skill,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skill Name
            Text(
              skill.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              skill.description,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),

            // Proficiency Bar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Proficiency',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white60,
                      ),
                    ),
                    Text(
                      '${skill.proficiency}/5',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: skill.proficiency / 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Category Tag
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white24,
                  width: 1,
                ),
              ),
              child: Text(
                skill.category,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
