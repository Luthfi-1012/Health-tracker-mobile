import 'package:flutter/material.dart';
import 'features/dashboard/presentation/pages/main_navigation_page.dart';
import 'core/theme/app_theme.dart';
import 'core/widgets/notification_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tracker',
      theme: AppTheme.lightTheme,
      home: const NotificationWidget(child: MainNavigationPage()),
    );
  }
}
