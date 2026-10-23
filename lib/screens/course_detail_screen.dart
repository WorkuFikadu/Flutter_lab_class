import 'package:flutter/material.dart';

class CourseDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const CourseDetailScreen({super.key, required this.item});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isBookmarked = false;
  bool _isEnrolled = false;

  final List<Map<String, dynamic>> _lessons = [
    {
      'title': '1. Course Overview & Introduction',
      'duration': '12 mins',
      'isCompleted': true,
      'isLocked': false,
    },
    {
      'title': '2. Core Principles & Design System',
      'duration': '25 mins',
      'isCompleted': false,
      'isLocked': false,
    },
    {
      'title': '3. Building Responsive Layouts',
      'duration': '38 mins',
      'isCompleted': false,
      'isLocked': false,
    },
    {
      'title': '4. State Management with Provider',
      'duration': '45 mins',
      'isCompleted': false,
      'isLocked': true,
    },
    {
      'title': '5. API & Backend Integration',
      'duration': '50 mins',
      'isCompleted': false,
      'isLocked': true,
    },
    {
      'title': '6. Testing, CI/CD & Deployment',
      'duration': '30 mins',
      'isCompleted': false,
      'isLocked': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = widget.item['color'] as Color? ?? colorScheme.primary;
    final title = widget.item['title'] as String? ?? 'Course Details';
    final subtitle = widget.item['subtitle'] as String? ?? 'Comprehensive Guide';
    final tag = widget.item['tag'] as String? ?? 'Development';
    final rating = widget.item['rating'] as String? ?? '4.8';
    final icon = widget.item['icon'] as IconData? ?? Icons.school;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Hero Cover
          SliverAppBar(
            expandedHeight: 240,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.scaffoldBackgroundColor.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    color: _isBookmarked ? color : null,
                    size: 20,
                  ),
                ),
                onPressed: () {
                  setState(() => _isBookmarked = !_isBookmarked);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isBookmarked
                          ? 'Saved to Bookmarks'
                          : 'Removed from Bookmarks'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color.withValues(alpha: 0.85),
                      color.withValues(alpha: 0.35),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, size: 54, color: Colors.white),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            tag.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Course Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              subtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              rating,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Highlights Stats Row
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildHighlight(context, Icons.schedule, '2.5 Hours', 'Duration'),
                        _buildDivider(),
                        _buildHighlight(context, Icons.menu_book, '6 Lessons', 'Content'),
                        _buildDivider(),
                        _buildHighlight(context, Icons.workspace_premium, 'Certificate', 'Completion'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Instructor Section
                  Text(
                    'Instructor',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 24,
                      backgroundColor: colorScheme.primaryContainer,
                      child: Text(
                        'WF',
                        style: TextStyle(
                          color: colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: const Text(
                      'Worku Fikadu',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: const Text('Full-Stack & Mobile Developer • Jimma University'),
                    trailing: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Follow'),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Curriculum Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Curriculum (${_lessons.length} Lessons)',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'All Sections',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Lessons List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _lessons.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final lesson = _lessons[index];
                      final isCompleted = lesson['isCompleted'] as bool;
                      final isLocked = lesson['isLocked'] as bool;

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: colorScheme.outlineVariant.withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundColor: isCompleted
                                  ? Colors.green.withValues(alpha: 0.15)
                                  : (isLocked
                                      ? colorScheme.surfaceContainerHighest
                                      : colorScheme.primary.withValues(alpha: 0.15)),
                              child: Icon(
                                isCompleted
                                    ? Icons.check
                                    : (isLocked ? Icons.lock_outline : Icons.play_arrow),
                                size: 16,
                                color: isCompleted
                                    ? Colors.green
                                    : (isLocked
                                        ? colorScheme.onSurface.withValues(alpha: 0.4)
                                        : colorScheme.primary),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                lesson['title'] as String,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isLocked
                                      ? colorScheme.onSurface.withValues(alpha: 0.5)
                                      : colorScheme.onSurface,
                                ),
                              ),
                            ),
                            Text(
                              lesson['duration'] as String,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.45),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 100), // Space for sticky bottom bar
                ],
              ),
            ),
          ),
        ],
      ),

      // Sticky Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const Text(
                    'Free',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() => _isEnrolled = !_isEnrolled);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(_isEnrolled
                              ? '🎉 Successfully enrolled in $title!'
                              : 'Enrollment canceled.'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isEnrolled ? Colors.green : colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      _isEnrolled ? 'Enrolled ✓' : 'Enroll Now',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHighlight(
      BuildContext context, IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                fontSize: 11,
              ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 28,
      width: 1,
      color: Colors.grey.withValues(alpha: 0.3),
    );
  }
}
