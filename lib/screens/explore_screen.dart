import 'package:flutter/material.dart';
import 'course_detail_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All', 'Design', 'Development', 'Marketing', 'Finance', 'Health'
  ];

  final List<Map<String, dynamic>> _items = [
    {
      'title': 'Flutter UI Masterclass',
      'subtitle': 'Learn to build beautiful apps',
      'icon': Icons.phone_android,
      'color': Colors.blue,
      'tag': 'Development',
      'rating': '4.9',
    },
    {
      'title': 'Product Design Basics',
      'subtitle': 'From wireframes to prototypes',
      'icon': Icons.design_services,
      'color': Colors.purple,
      'tag': 'Design',
      'rating': '4.7',
    },
    {
      'title': 'Growth Marketing',
      'subtitle': 'Scale your app user base',
      'icon': Icons.trending_up,
      'color': Colors.green,
      'tag': 'Marketing',
      'rating': '4.8',
    },
    {
      'title': 'Firebase Integration',
      'subtitle': 'Backend-as-a-Service for apps',
      'icon': Icons.storage,
      'color': Colors.orange,
      'tag': 'Development',
      'rating': '4.6',
    },
    {
      'title': 'Financial Planning',
      'subtitle': 'Budget and invest smarter',
      'icon': Icons.account_balance_wallet,
      'color': Colors.teal,
      'tag': 'Finance',
      'rating': '4.5',
    },
    {
      'title': 'Mindfulness & Focus',
      'subtitle': 'Productivity through wellness',
      'icon': Icons.spa,
      'color': Colors.pink,
      'tag': 'Health',
      'rating': '4.8',
    },
  ];

  List<Map<String, dynamic>> get _filteredItems {
    final query = _searchController.text.toLowerCase();
    return _items.where((item) {
      final matchesCategory =
          _selectedCategory == 'All' || item['tag'] == _selectedCategory;
      final matchesSearch = query.isEmpty ||
          item['title'].toString().toLowerCase().contains(query) ||
          item['subtitle'].toString().toLowerCase().contains(query);
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Explore',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Discover what\'s new',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withValues(alpha: 0.6))),
                  const SizedBox(height: 16),
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Category Chips
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, i) {
                        final cat = _categories[i];
                        final isSelected = cat == _selectedCategory;
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = cat),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              cat,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.7),
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            // Results
            Expanded(
              child: _filteredItems.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search_off,
                              size: 60,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.3)),
                          const SizedBox(height: 12),
                          Text('No results found',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.4))),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      itemCount: _filteredItems.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final item = _filteredItems[i];
                        return Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CourseDetailScreen(item: item),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: (item['color'] as Color)
                                      .withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(item['icon'] as IconData,
                                    color: item['color'] as Color, size: 24),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['title'] as String,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600)),
                                    const SizedBox(height: 3),
                                    Text(item['subtitle'] as String,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withValues(alpha: 0.55))),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 14),
                                      const SizedBox(width: 2),
                                      Text(item['rating'] as String,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: (item['color'] as Color)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(item['tag'] as String,
                                        style: TextStyle(
                                          color: item['color'] as Color,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
