import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/experience.dart';
import '../providers/experience_provider.dart';

class ExperienceTimeline extends ConsumerWidget {
  const ExperienceTimeline({super.key});

  void _showExperienceDetails(BuildContext context, Experience experience) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade900 : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? Colors.white24 : Colors.black12,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company Logo and Name
                    Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color:
                                isDark ? Colors.white12 : Colors.grey.shade200,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark
                                  ? Colors.white24
                                  : Colors.grey.shade300,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Image.asset(
                              experience.companyLogo,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(
                                Icons.business,
                                size: 24,
                                color: isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                experience.company,
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                              Text(
                                experience.position,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Duration and Location
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                _formatDuration(
                                    experience.startDate, experience.endDate),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 20,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                experience.location,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Description
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      experience.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? Colors.white70 : Colors.black54,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Technologies
                    Text(
                      'Technologies',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: experience.technologies.map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark
                                  ? Colors.white24
                                  : Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tech,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white70 : Colors.black54,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final experiencesAsync = ref.watch(experiencesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return experiencesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text(
          'Error loading experience',
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
      ),
      data: (experiences) {
        // Sort experiences by start date (most recent first)
        final sortedExperiences = List<Experience>.from(experiences)
          ..sort((a, b) => b.startDate.compareTo(a.startDate));

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sortedExperiences.length,
          itemBuilder: (context, index) {
            final experience = sortedExperiences[index];
            final isFirst = index == 0;
            final isLast = index == sortedExperiences.length - 1;

            return InkWell(
              onTap: () => _showExperienceDetails(context, experience),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline
                      SizedBox(
                        width: 40,
                        child: Column(
                          children: [
                            // Company Logo
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: isDark
                                    ? Colors.white12
                                    : Colors.grey.shade200,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isDark
                                      ? Colors.white24
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  experience.companyLogo,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                    Icons.business,
                                    size: 16,
                                    color: isDark
                                        ? Colors.white54
                                        : Colors.black45,
                                  ),
                                ),
                              ),
                            ),
                            // Timeline line
                            if (!isLast)
                              Expanded(
                                child: Container(
                                  width: 2,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  color: isDark
                                      ? Colors.white24
                                      : Colors.grey.shade300,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Company and Duration
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  experience.company,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDuration(
                                      experience.startDate, experience.endDate),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Position
                            Text(
                              experience.position,
                              style: TextStyle(
                                fontSize: 16,
                                color: isDark
                                    ? Colors.white.withOpacity(0.9)
                                    : Colors.black87,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Location
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color:
                                      isDark ? Colors.white54 : Colors.black45,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  experience.location,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: isDark
                                        ? Colors.white54
                                        : Colors.black45,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            // Description
                            Text(
                              experience.description,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.white70 : Colors.black54,
                                height: 1.5,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 12),
                            // Technologies
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: experience.technologies.map((tech) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.1)
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: isDark
                                          ? Colors.white24
                                          : Colors.grey.shade300,
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: isDark
                                          ? Colors.white70
                                          : Colors.black54,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            if (!isLast) const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  String _formatDuration(DateTime startDate, DateTime? endDate) {
    final dateFormat = DateFormat('MMM yyyy');
    final start = dateFormat.format(startDate);
    final end = endDate != null ? dateFormat.format(endDate) : 'Present';
    return '$start - $end';
  }
}
