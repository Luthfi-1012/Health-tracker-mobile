import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/services/notification_service.dart';
import '../../../steps/presentation/pages/langkah_page.dart';
import '../../../sleep/presentation/pages/tidur_page.dart';
import '../../../water/presentation/pages/air_page.dart';
import 'notification_demo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? _selectedMood;
  final NotificationService _notificationService = NotificationService();

  // Streak data
  final Map<String, int> streaks = {'Sleep': 12, 'Water': 8, 'Steps': 5};

  // Heart rate data
  final int heartRate = 72;
  final String heartRateStatus = 'Resting';

  // Steps data
  final int currentSteps = 7842;
  final int targetSteps = 10000;

  // Calories data
  final int caloriesBurned = 450;
  final int dailyCalorieGoal = 2000;

  // Sleep data
  final double sleepHours = 7.5;
  final double targetSleepHours = 8.0;

  // Weekly goal data
  final int weeklyProgress = 75; // percentage
  final String currentWeek = 'Minggu ke-3';

  @override
  void initState() {
    super.initState();
    // Check sleep time reminder
    _checkSleepTimeReminder();
  }

  void _checkSleepTimeReminder() {
    final now = DateTime.now();
    // Set target sleep time to 22:00 (10 PM)
    _notificationService.checkSleepTime(now, 22);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 24),

                // Stats Card (FADN)
                _buildStatsCard(),
                const SizedBox(height: 24),

                // Streak Section (NEW FEATURE)
                _buildStreakSection(),
                const SizedBox(height: 24),

                // Mood Tracker (NEW FEATURE)
                _buildMoodTracker(),
                const SizedBox(height: 24),

                // Menu Icons (Sleep counter, Thirst control, Volatility)
                _buildMenuIcons(),
                const SizedBox(height: 24),

                // Activity Metrics (Steps & Heart Rate)
                _buildActivityMetrics(),
                const SizedBox(height: 24),

                // Sleep Section
                _buildSleepSection(),
                const SizedBox(height: 24),

                // Achievements (NEW FEATURE - Enhanced)
                _buildAchievementsSection(),
                const SizedBox(height: 24),

                // Additional Info Card
                _buildInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationDemoPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.notifications_outlined,
            color: AppColors.textSecondary,
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'Luthfi',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Text(
              'Health Tracker',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.settings_outlined,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCard() {
    return Container(
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
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                  'Kalori Terbakar',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$caloriesBurned',
                      style: GoogleFonts.poppins(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'kcal',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Hari ini',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_fire_department,
              color: Colors.white,
              size: 40,
            ),
          ),
        ],
      ),
    );
  }

  // NEW FEATURE: Streak Section
  Widget _buildStreakSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Streaks',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text('🔥', style: TextStyle(fontSize: 28)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStreakItem(
                FontAwesomeIcons.moon,
                'Sleep',
                streaks['Sleep']!,
                AppColors.accentBlue,
              ),
              _buildStreakItem(
                FontAwesomeIcons.droplet,
                'Water',
                streaks['Water']!,
                AppColors.primary,
              ),
              _buildStreakItem(
                FontAwesomeIcons.shoePrints,
                'Steps',
                streaks['Steps']!,
                AppColors.accent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStreakItem(IconData icon, String label, int days, Color color) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.2), color.withOpacity(0.1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(child: FaIcon(icon, color: color, size: 32)),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          '$days days',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  // NEW FEATURE: Mood Tracker
  Widget _buildMoodTracker() {
    final moods = [
      {'emoji': '😢', 'label': 'Sad', 'value': 1},
      {'emoji': '😕', 'label': 'Down', 'value': 2},
      {'emoji': '😐', 'label': 'Okay', 'value': 3},
      {'emoji': '😊', 'label': 'Good', 'value': 4},
      {'emoji': '😄', 'label': 'Great', 'value': 5},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.faceSmile,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'How are you feeling?',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                moods.map((mood) {
                  final isSelected = _selectedMood == mood['value'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMood = mood['value'] as int;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      transform:
                          Matrix4.identity()..scale(isSelected ? 1.1 : 1.0),
                      child: Container(
                        width: 60,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          gradient:
                              isSelected
                                  ? LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.primaryDark,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                  : null,
                          color: isSelected ? null : AppColors.background,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              mood['emoji'] as String,
                              style: const TextStyle(fontSize: 28),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              mood['label'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color:
                                    isSelected
                                        ? Colors.white
                                        : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildMenuIcon(
          'Sleep counter',
          FontAwesomeIcons.moon,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TidurPage()),
          ),
        ),
        _buildMenuIcon(
          'Thirst contrée',
          FontAwesomeIcons.droplet,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AirPage()),
          ),
        ),
        _buildMenuIcon(
          'Volatility',
          FontAwesomeIcons.chartLine,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LangkahPage()),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuIcon(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
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
            child: Center(
              child: FaIcon(icon, size: 28, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // NEW FEATURE: Activity Metrics (Steps & Heart Rate)
  Widget _buildActivityMetrics() {
    double stepsProgress = currentSteps / targetSteps;

    return Row(
      children: [
        // Steps Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accent, AppColors.accent.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FaIcon(
                  FontAwesomeIcons.shoePrints,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(height: 12),
                Text(
                  'Steps Today',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentSteps.toString(),
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: stepsProgress.clamp(0.0, 1.0),
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Goal: ${targetSteps.toString()}',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Heart Rate Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accentBlue,
                  AppColors.accentBlue.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentBlue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FaIcon(
                  FontAwesomeIcons.heartPulse,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(height: 12),
                Text(
                  'Heart Rate',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      heartRate.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'bpm',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  heartRateStatus,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSleepSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sleep',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Background wave pattern
              Positioned.fill(child: CustomPaint(painter: WavePainter())),
              // Circular Progress
              Center(
                child: CircularPercentIndicator(
                  radius: 100,
                  lineWidth: 18,
                  percent: 0.65,
                  progressColor: AppColors.primary,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${sleepHours.toStringAsFixed(1)}h',
                            style: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text('😴', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // NEW FEATURE: Enhanced Achievements Section
  Widget _buildAchievementsSection() {
    final achievements = [
      {
        'title': 'Early Bird',
        'desc': '7 days of good sleep',
        'unlocked': true,
        'emoji': '🏆',
      },
      {
        'title': 'Hydration Hero',
        'desc': '30 days water goal',
        'unlocked': true,
        'emoji': '🏆',
      },
      {
        'title': 'Step Master',
        'desc': '10k steps in a day',
        'unlocked': false,
        'emoji': '🔒',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const FaIcon(
                FontAwesomeIcons.award,
                color: AppColors.accentYellow,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Achievements',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...achievements.map((achievement) {
            final unlocked = achievement['unlocked'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient:
                    unlocked
                        ? LinearGradient(
                          colors: [
                            AppColors.accentYellow.withOpacity(0.1),
                            AppColors.accent.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                        : null,
                color: unlocked ? null : AppColors.background,
                borderRadius: BorderRadius.circular(16),
                border:
                    unlocked
                        ? Border.all(
                          color: AppColors.accentYellow.withOpacity(0.3),
                          width: 2,
                        )
                        : null,
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          unlocked
                              ? AppColors.accentYellow.withOpacity(0.2)
                              : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      achievement['emoji'] as String,
                      style: TextStyle(
                        fontSize: 24,
                        color: unlocked ? null : Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement['title'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color:
                                unlocked
                                    ? AppColors.textPrimary
                                    : AppColors.textLight,
                          ),
                        ),
                        Text(
                          achievement['desc'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color:
                                unlocked
                                    ? AppColors.textSecondary
                                    : AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withOpacity(0.15),
            AppColors.accentYellow.withOpacity(0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Target Mingguan',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currentWeek,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$weeklyProgress%',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Tercapai',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // Mini circular indicator
          SizedBox(
            width: 70,
            height: 70,
            child: CircularPercentIndicator(
              radius: 35,
              lineWidth: 7,
              percent: weeklyProgress / 100,
              progressColor: AppColors.accentYellow,
              backgroundColor: AppColors.accent.withOpacity(0.3),
              circularStrokeCap: CircularStrokeCap.round,
              center: const Icon(
                Icons.emoji_events,
                color: AppColors.accentYellow,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Wave Background
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.primary.withOpacity(0.08)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final path = Path();

    // Draw multiple wave lines
    for (int i = 0; i < 3; i++) {
      path.reset();
      final yOffset = size.height * 0.4 + (i * 30);
      path.moveTo(0, yOffset);

      for (double x = 0; x <= size.width; x += 20) {
        final y =
            yOffset +
            15 * (i % 2 == 0 ? 1 : -1) * (0.5 + 0.5 * (x / size.width));
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
