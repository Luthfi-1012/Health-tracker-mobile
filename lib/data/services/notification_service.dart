import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Storage untuk callbacks notifikasi
  final List<Function(String, String, NotificationType)> _listeners = [];

  // Tipe notifikasi
  void addListener(Function(String, String, NotificationType) listener) {
    _listeners.add(listener);
  }

  void removeListener(Function(String, String, NotificationType) listener) {
    _listeners.remove(listener);
  }

  // Method untuk mengirim notifikasi
  void sendNotification(String title, String message, NotificationType type) {
    for (var listener in _listeners) {
      listener(title, message, type);
    }
  }

  // Check water intake reminder
  void checkWaterIntake(
    int currentGlasses,
    int targetGlasses,
    DateTime lastDrink,
  ) {
    final now = DateTime.now();
    final difference = now.difference(lastDrink);

    // Jika sudah 2 jam sejak minum terakhir dan belum mencapai target
    if (difference.inHours >= 2 && currentGlasses < targetGlasses) {
      sendNotification(
        '💧 Waktunya Minum Air!',
        'Anda belum minum air selama ${difference.inHours} jam. Tetap terhidrasi!',
        NotificationType.water,
      );
    }

    // Jika hampir mencapai target tapi belum selesai
    if (currentGlasses >= targetGlasses - 2 && currentGlasses < targetGlasses) {
      sendNotification(
        '💧 Hampir Selesai!',
        'Tinggal ${targetGlasses - currentGlasses} gelas lagi untuk mencapai target harian!',
        NotificationType.water,
      );
    }
  }

  // Check sleep time reminder
  void checkSleepTime(DateTime now, int targetSleepHour) {
    final currentHour = now.hour;

    // Reminder jam tidur (misalnya jam 22:00)
    if (currentHour == targetSleepHour) {
      sendNotification(
        '😴 Waktunya Tidur!',
        'Sudah jam $targetSleepHour:00. Saatnya istirahat untuk kesehatan optimal.',
        NotificationType.sleep,
      );
    }

    // Warning jika sudah lewat jam tidur
    if (currentHour > targetSleepHour && currentHour < 24) {
      final hoursLate = currentHour - targetSleepHour;
      sendNotification(
        '⏰ Jam Tidur Terlewat!',
        'Anda terlambat tidur $hoursLate jam. Segera istirahat!',
        NotificationType.sleep,
      );
    }
  }

  // Check calorie overflow
  void checkCalorieIntake(int currentCalories, int targetCalories) {
    final percentage = (currentCalories / targetCalories * 100).round();

    // Warning saat 90% target
    if (percentage >= 90 && percentage < 100) {
      sendNotification(
        '⚠️ Mendekati Batas Kalori',
        'Anda sudah mencapai $percentage% dari target kalori harian.',
        NotificationType.calories,
      );
    }

    // Alert saat melebihi target
    if (currentCalories > targetCalories) {
      final excess = currentCalories - targetCalories;
      sendNotification(
        '🚨 Kalori Berlebih!',
        'Anda melebihi target kalori sebesar $excess kcal. Pertimbangkan untuk berolahraga.',
        NotificationType.calories,
      );
    }
  }

  // Reminder harian di pagi hari
  void sendMorningReminder() {
    sendNotification(
      '🌅 Selamat Pagi!',
      'Jangan lupa untuk melacak aktivitas kesehatan Anda hari ini!',
      NotificationType.general,
    );
  }

  // Achievement notification
  void sendAchievementNotification(String achievementName) {
    sendNotification(
      '🏆 Pencapaian Baru!',
      'Selamat! Anda telah membuka: $achievementName',
      NotificationType.achievement,
    );
  }
}

enum NotificationType { water, sleep, calories, general, achievement }

// Helper untuk mendapatkan warna berdasarkan tipe notifikasi
extension NotificationTypeExtension on NotificationType {
  Color get color {
    switch (this) {
      case NotificationType.water:
        return const Color(0xFF6B9EFF);
      case NotificationType.sleep:
        return const Color(0xFF9B59B6);
      case NotificationType.calories:
        return const Color(0xFFFF6B9D);
      case NotificationType.achievement:
        return const Color(0xFFFFC75F);
      case NotificationType.general:
        return const Color(0xFF4ECDC4);
    }
  }

  IconData get icon {
    switch (this) {
      case NotificationType.water:
        return Icons.water_drop;
      case NotificationType.sleep:
        return Icons.bedtime;
      case NotificationType.calories:
        return Icons.restaurant;
      case NotificationType.achievement:
        return Icons.emoji_events;
      case NotificationType.general:
        return Icons.notifications;
    }
  }
}
