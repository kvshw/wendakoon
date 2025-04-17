import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/projects_provider.dart';
import '../widgets/project_card.dart';

class ProjectsScreen extends ConsumerWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final categories = ref.watch(projectCategoriesProvider);
    final projects = ref.watch(filteredProjectsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF0C4A6E), // Dark Blue
              const Color(0xFF0F172A), // Dark Navy
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Top Spacing for AppBar
            const SliverToBoxAdapter(
              child: SizedBox(height: kToolbarHeight + 56),
            ),

            // Categories Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isDark ? Colors.white70 : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    categories.when(
                      data: (categories) => SizedBox(
                        height: 36,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 8),
                          itemBuilder: (context, index) {
                            final category = categories[index];
                            final isSelected = category == selectedCategory;
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
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              checkmarkColor: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
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
                              onSelected: (_) {
                                ref
                                    .read(selectedCategoryProvider.notifier)
                                    .state = category;
                              },
                            );
                          },
                        ),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => Text(
                        'Error loading categories: $error',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),

            // Projects Grid
            projects.when(
              data: (projects) => SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => ProjectCard(project: projects[index]),
                    childCount: projects.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.8,
                  ),
                ),
              ),
              loading: () => const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: Center(
                  child: Text(
                    'Error loading projects: $error',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 24),
            ),
          ],
        ),
      ),
    );
  }
}
