import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/services/notification_service.dart';

class NotificationDemoPage extends StatelessWidget {
  const NotificationDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationService notificationService = NotificationService();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Demo Notifikasi',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Uji Coba Notifikasi',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Klik tombol di bawah untuk menguji berbagai jenis notifikasi',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Water Notification
            _buildNotificationButton(
              context: context,
              title: '💧 Notifikasi Minum Air',
              description: 'Pengingat untuk minum air',
              color: AppColors.accentBlue,
              icon: FontAwesomeIcons.glassWater,
              onTap: () {
                notificationService.sendNotification(
                  '💧 Waktunya Minum Air!',
                  'Anda belum minum air selama 2 jam. Tetap terhidrasi!',
                  NotificationType.water,
                );
              },
            ),
            const SizedBox(height: 12),

            // Sleep Notification
            _buildNotificationButton(
              context: context,
              title: '😴 Notifikasi Tidur',
              description: 'Pengingat jam tidur',
              color: AppColors.primary,
              icon: FontAwesomeIcons.moon,
              onTap: () {
                notificationService.sendNotification(
                  '😴 Waktunya Tidur!',
                  'Sudah jam 22:00. Saatnya istirahat untuk kesehatan optimal.',
                  NotificationType.sleep,
                );
              },
            ),
            const SizedBox(height: 12),

            // Sleep Late Notification
            _buildNotificationButton(
              context: context,
              title: '⏰ Jam Tidur Terlewat',
              description: 'Peringatan terlambat tidur',
              color: AppColors.error,
              icon: FontAwesomeIcons.clock,
              onTap: () {
                notificationService.sendNotification(
                  '⏰ Jam Tidur Terlewat!',
                  'Anda terlambat tidur 2 jam. Segera istirahat!',
                  NotificationType.sleep,
                );
              },
            ),
            const SizedBox(height: 12),

            // Calorie Warning
            _buildNotificationButton(
              context: context,
              title: '⚠️ Peringatan Kalori',
              description: 'Mendekati batas kalori',
              color: AppColors.accentYellow,
              icon: FontAwesomeIcons.triangleExclamation,
              onTap: () {
                notificationService.sendNotification(
                  '⚠️ Mendekati Batas Kalori',
                  'Anda sudah mencapai 95% dari target kalori harian.',
                  NotificationType.calories,
                );
              },
            ),
            const SizedBox(height: 12),

            // Calorie Overflow
            _buildNotificationButton(
              context: context,
              title: '🚨 Kalori Berlebih',
              description: 'Melebihi target kalori',
              color: AppColors.accent,
              icon: FontAwesomeIcons.burger,
              onTap: () {
                notificationService.sendNotification(
                  '🚨 Kalori Berlebih!',
                  'Anda melebihi target kalori sebesar 300 kcal. Pertimbangkan untuk berolahraga.',
                  NotificationType.calories,
                );
              },
            ),
            const SizedBox(height: 12),

            // Achievement
            _buildNotificationButton(
              context: context,
              title: '🏆 Pencapaian',
              description: 'Notifikasi pencapaian baru',
              color: AppColors.accentYellow,
              icon: FontAwesomeIcons.trophy,
              onTap: () {
                notificationService.sendNotification(
                  '🏆 Pencapaian Baru!',
                  'Selamat! Anda telah membuka: "Early Bird - 7 hari tidur teratur"',
                  NotificationType.achievement,
                );
              },
            ),
            const SizedBox(height: 12),

            // General Morning
            _buildNotificationButton(
              context: context,
              title: '🌅 Selamat Pagi',
              description: 'Notifikasi pagi hari',
              color: AppColors.primary,
              icon: FontAwesomeIcons.sun,
              onTap: () {
                notificationService.sendMorningReminder();
              },
            ),
            const SizedBox(height: 24),

            // Info Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Informasi',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Notifikasi otomatis akan muncul berdasarkan aktivitas Anda:',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoItem('• Pengingat minum air setiap 2 jam'),
                  _buildInfoItem('• Pengingat tidur jam 22:00'),
                  _buildInfoItem('• Peringatan saat kalori melebihi 90%'),
                  _buildInfoItem('• Notifikasi pencapaian target'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationButton({
    required BuildContext context,
    required String title,
    required String description,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FaIcon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}
