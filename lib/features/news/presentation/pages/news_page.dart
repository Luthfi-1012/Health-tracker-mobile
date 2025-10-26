import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../../core/app_colors.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  // Data berita kesehatan
  final List<Map<String, dynamic>> healthNews = [
    {
      'title': '10 Manfaat Olahraga Rutin untuk Kesehatan Mental',
      'summary':
          'Penelitian terbaru menunjukkan bahwa olahraga rutin tidak hanya baik untuk tubuh, tetapi juga sangat bermanfaat untuk kesehatan mental.',
      'category': 'Kesehatan Mental',
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'image': FontAwesomeIcons.brain,
      'color': AppColors.primary,
    },
    {
      'title': 'Pentingnya Tidur Berkualitas untuk Produktivitas',
      'summary':
          'Tidur yang cukup dan berkualitas dapat meningkatkan produktivitas hingga 40%. Berikut tips untuk tidur lebih baik.',
      'category': 'Tidur',
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'image': FontAwesomeIcons.moon,
      'color': AppColors.accentBlue,
    },
    {
      'title': 'Diet Seimbang: Kunci Hidup Sehat dan Bugar',
      'summary':
          'Mengonsumsi makanan bergizi seimbang adalah fondasi utama untuk menjaga kesehatan tubuh dan pikiran.',
      'category': 'Nutrisi',
      'date': DateTime.now().subtract(const Duration(hours: 8)),
      'image': FontAwesomeIcons.appleWhole,
      'color': AppColors.accent,
    },
    {
      'title': 'Pentingnya Hidrasi: Minum Air Putih 8 Gelas Sehari',
      'summary':
          'Air putih memiliki banyak manfaat untuk tubuh, dari menjaga suhu tubuh hingga membantu pencernaan yang baik.',
      'category': 'Hidrasi',
      'date': DateTime.now().subtract(const Duration(hours: 12)),
      'image': FontAwesomeIcons.droplet,
      'color': AppColors.primary,
    },
    {
      'title': 'Langkah-Langkah Mencapai Target 10.000 Steps Per Hari',
      'summary':
          'Berjalan 10.000 langkah sehari dapat membantu menurunkan risiko penyakit jantung dan diabetes.',
      'category': 'Aktivitas Fisik',
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'image': FontAwesomeIcons.shoePrints,
      'color': AppColors.accentYellow,
    },
    {
      'title': 'Meditasi 10 Menit untuk Mengurangi Stres',
      'summary':
          'Meditasi singkat setiap hari dapat membantu mengurangi tingkat stres dan meningkatkan fokus.',
      'category': 'Kesehatan Mental',
      'date': DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      'image': FontAwesomeIcons.spa,
      'color': AppColors.primary,
    },
    {
      'title': 'Bahaya Begadang: Dampak Kurang Tidur pada Tubuh',
      'summary':
          'Kurang tidur dapat menyebabkan berbagai masalah kesehatan, mulai dari obesitas hingga penyakit jantung.',
      'category': 'Tidur',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'image': FontAwesomeIcons.bedPulse,
      'color': AppColors.accentBlue,
    },
    {
      'title': 'Superfood yang Wajib Dikonsumsi Setiap Hari',
      'summary':
          'Temukan daftar superfood yang kaya nutrisi dan mudah ditemukan untuk meningkatkan kesehatan Anda.',
      'category': 'Nutrisi',
      'date': DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      'image': FontAwesomeIcons.leaf,
      'color': AppColors.accent,
    },
  ];

  String? selectedCategory;
  List<String> get categories {
    final cats =
        healthNews.map((news) => news['category'] as String).toSet().toList();
    cats.sort();
    return cats;
  }

  List<Map<String, dynamic>> get filteredNews {
    if (selectedCategory == null) return healthNews;
    return healthNews
        .where((news) => news['category'] == selectedCategory)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Health News',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: Column(
        children: [
          // Category Filter
          Container(
            height: 60,
            color: Colors.white,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                _buildCategoryChip('Semua', null),
                ...categories.map(
                  (category) => _buildCategoryChip(category, category),
                ),
              ],
            ),
          ),

          // Header Section
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tetap Update',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Berita kesehatan terkini untuk Anda',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const FaIcon(
                    FontAwesomeIcons.newspaper,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ],
            ),
          ),

          // News List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredNews.length,
              itemBuilder: (context, index) {
                final news = filteredNews[index];
                return _buildNewsCard(
                  news['title'],
                  news['summary'],
                  news['category'],
                  news['date'],
                  news['image'],
                  news['color'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, String? category) {
    final isSelected = selectedCategory == category;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedCategory = selected ? category : null;
          });
        },
        labelStyle: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isSelected ? Colors.white : AppColors.textSecondary,
        ),
        backgroundColor: Colors.white,
        selectedColor: AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.primary : AppColors.textLight,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildNewsCard(
    String title,
    String summary,
    String category,
    DateTime date,
    IconData icon,
    Color color,
  ) {
    return GestureDetector(
      onTap: () => _showNewsDetail(title, summary, category, date),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Category Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FaIcon(icon, color: color, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                        Text(
                          _formatDate(date),
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.bookmark_border, color: color, size: 20),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    summary,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Baca selengkapnya',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 14, color: color),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inHours < 24) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} menit yang lalu';
      }
      return '${difference.inHours} jam yang lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari yang lalu';
    } else {
      return DateFormat('dd MMM yyyy').format(date);
    }
  }

  void _showNewsDetail(
    String title,
    String summary,
    String category,
    DateTime date,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder:
                (context, scrollController) => Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: AppColors.textLight,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              category,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _formatDate(date),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            summary,
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                              height: 1.6,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              height: 1.6,
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
