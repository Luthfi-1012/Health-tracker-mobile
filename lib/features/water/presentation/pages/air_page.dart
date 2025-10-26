import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/services/notification_service.dart';

class AirPage extends StatefulWidget {
  const AirPage({super.key});

  @override
  State<AirPage> createState() => _AirPageState();
}

class _AirPageState extends State<AirPage> {
  int currentGlasses = 5; // Current glasses consumed
  int targetGlasses = 8; // Target glasses per day
  final int mlPerGlass = 250; // ml per glass
  DateTime lastDrink = DateTime.now();
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    // Check water intake on init
    _checkWaterReminder();
  }

  void _checkWaterReminder() {
    _notificationService.checkWaterIntake(
      currentGlasses,
      targetGlasses,
      lastDrink,
    );
  }

  void _addGlass() {
    if (currentGlasses < targetGlasses) {
      setState(() {
        currentGlasses++;
        lastDrink = DateTime.now();
      });
      _checkWaterReminder();

      // Achievement notification when target reached
      if (currentGlasses == targetGlasses) {
        _notificationService.sendNotification(
          '🎉 Target Tercapai!',
          'Selamat! Anda telah mencapai target minum air hari ini!',
          NotificationType.achievement,
        );
      }
    }
  }

  void _removeGlass() {
    if (currentGlasses > 0) {
      setState(() {
        currentGlasses--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double progress = currentGlasses / targetGlasses;
    int totalMl = currentGlasses * mlPerGlass;
    int targetMl = targetGlasses * mlPerGlass;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Pemantauan Air Minum',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),

            // Circular Progress
            CircularPercentIndicator(
              radius: 120,
              lineWidth: 20,
              percent: progress.clamp(0.0, 1.0),
              progressColor: AppColors.accentBlue,
              backgroundColor: AppColors.accentBlue.withOpacity(0.1),
              circularStrokeCap: CircularStrokeCap.round,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.glassWater,
                    color: AppColors.accentBlue,
                    size: 48,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$currentGlasses/$targetGlasses',
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    'gelas',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Text(
              '$totalMl ml / $targetMl ml',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 32),

            // Add/Remove Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildControlButton(
                  icon: Icons.remove,
                  onPressed: _removeGlass,
                  color: AppColors.error,
                ),
                const SizedBox(width: 40),
                _buildControlButton(
                  icon: Icons.add,
                  onPressed: _addGlass,
                  color: AppColors.success,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Quick Add Buttons
            Text(
              'Tambah Cepat',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildQuickAddButton('1 Gelas\n250ml', 1),
                _buildQuickAddButton('2 Gelas\n500ml', 2),
                _buildQuickAddButton('1 Botol\n600ml', 2),
              ],
            ),
            const SizedBox(height: 32),

            // Statistics
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accentBlue.withOpacity(0.2),
                    AppColors.primary.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Statistik Hari Ini',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        'Diminum',
                        '$totalMl ml',
                        Icons.water_drop,
                      ),
                      _buildStatItem(
                        'Tersisa',
                        '${targetMl - totalMl} ml',
                        Icons.flag,
                      ),
                      _buildStatItem(
                        'Progress',
                        '${(progress * 100).toInt()}%',
                        Icons.show_chart,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Tips
            _buildTipsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 32),
        onPressed: onPressed,
        padding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildQuickAddButton(String label, int glasses) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentGlasses = (currentGlasses + glasses).clamp(0, targetGlasses);
        });
      },
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16),
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
          children: [
            const FaIcon(
              FontAwesomeIcons.glassWaterDroplet,
              color: AppColors.accentBlue,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.accentBlue, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTipsSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
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
          Text(
            '💡 Tips Hidrasi',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          _buildTipItem('Minum air saat bangun tidur'),
          _buildTipItem('Bawa botol air ke mana-mana'),
          _buildTipItem('Minum sebelum merasa haus'),
          _buildTipItem('Target 8 gelas per hari'),
        ],
      ),
    );
  }

  Widget _buildTipItem(String tip) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.success, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              tip,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
