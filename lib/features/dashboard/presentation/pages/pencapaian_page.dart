import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/app_colors.dart';

class PencapaianPage extends StatefulWidget {
  const PencapaianPage({super.key});

  @override
  State<PencapaianPage> createState() => _PencapaianPageState();
}

class _PencapaianPageState extends State<PencapaianPage> {
  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'Langkah Pertama',
      'description': 'Mencapai 5,000 langkah pertama kali',
      'icon': FontAwesomeIcons.shoePrints,
      'color': AppColors.primary,
      'date': '20 Okt 2024',
      'unlocked': true,
    },
    {
      'title': 'Pelari 10K',
      'description': 'Mencapai 10,000 langkah dalam sehari',
      'icon': FontAwesomeIcons.personRunning,
      'color': AppColors.success,
      'date': '22 Okt 2024',
      'unlocked': true,
    },
    {
      'title': 'Tidur Berkualitas',
      'description': 'Tidur 8 jam selama 7 hari berturut-turut',
      'icon': FontAwesomeIcons.bed,
      'color': AppColors.accentBlue,
      'date': '23 Okt 2024',
      'unlocked': true,
    },
    {
      'title': 'Hidrasi Sempurna',
      'description': 'Minum 8 gelas air selama 5 hari',
      'icon': FontAwesomeIcons.glassWater,
      'color': AppColors.info,
      'date': '',
      'unlocked': false,
    },
    {
      'title': 'Sehat Sebulan',
      'description': 'Mencapai semua target selama 30 hari',
      'icon': FontAwesomeIcons.trophy,
      'color': AppColors.accentYellow,
      'date': '',
      'unlocked': false,
    },
    {
      'title': 'Streak Master',
      'description': 'Aktif 100 hari berturut-turut',
      'icon': FontAwesomeIcons.fire,
      'color': AppColors.accent,
      'date': '',
      'unlocked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    int unlockedCount = achievements.where((a) => a['unlocked'] == true).length;
    int totalCount = achievements.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Pencapaian',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Summary Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accentYellow,
                    AppColors.accentYellow.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentYellow.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(Icons.emoji_events, color: Colors.white, size: 56),
                  const SizedBox(height: 16),
                  Text(
                    '$unlockedCount / $totalCount',
                    style: GoogleFonts.poppins(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Pencapaian Terbuka',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: unlockedCount / totalCount,
                      minHeight: 8,
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Unlocked Section
            if (achievements.any((a) => a['unlocked'] == true)) ...[
              Text(
                'Terbuka 🎉',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...achievements
                  .where((a) => a['unlocked'] == true)
                  .map(
                    (achievement) => _buildAchievementCard(achievement, true),
                  ),
              const SizedBox(height: 24),
            ],

            // Locked Section
            if (achievements.any((a) => a['unlocked'] == false)) ...[
              Text(
                'Terkunci 🔒',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ...achievements
                  .where((a) => a['unlocked'] == false)
                  .map(
                    (achievement) => _buildAchievementCard(achievement, false),
                  ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(
    Map<String, dynamic> achievement,
    bool unlocked,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: unlocked ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border:
            unlocked
                ? Border.all(
                  color: achievement['color'].withOpacity(0.3),
                  width: 2,
                )
                : Border.all(color: Colors.grey.shade300),
        boxShadow:
            unlocked
                ? [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
                : [],
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color:
                  unlocked
                      ? achievement['color'].withOpacity(0.1)
                      : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(
              achievement['icon'],
              color: unlocked ? achievement['color'] : Colors.grey.shade400,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color:
                        unlocked ? AppColors.textPrimary : Colors.grey.shade500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement['description'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color:
                        unlocked
                            ? AppColors.textSecondary
                            : Colors.grey.shade400,
                  ),
                ),
                if (unlocked && achievement['date'].isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: AppColors.textLight,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        achievement['date'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.textLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),

          // Lock/Check Icon
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color:
                  unlocked
                      ? achievement['color'].withOpacity(0.1)
                      : Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: Icon(
              unlocked ? Icons.check : Icons.lock,
              color: unlocked ? achievement['color'] : Colors.grey.shade400,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
