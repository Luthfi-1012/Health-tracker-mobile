import 'package:flutter/material.dart';
import 'package:flutter_klinik_app/ui/pages/makanan_page.dart';
import '../pages/home_page.dart';
import '../pages/dashboard_page.dart';
import '../poli_page.dart';
import '../pages/pencapaian_page.dart'; // pastikan ini sudah ada

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Admin", style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text("admin@admin.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.blue,
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF64B5F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // 📌 Menu Beranda
          _menuItem(
            context,
            icon: Icons.home,
            title: "Beranda",
            page: const Beranda(),
          ),

          // 📌 Menu Poli
          _menuItem(
            context,
            icon: Icons.accessible,
            title: "Poli",
            page: const PoliPage(),
          ),

          // 📌 Menu Pegawai (✅ sudah aktif)
          _menuItem(
            context,
            icon: Icons.people,
            title: "Pegawai",
            page: const PegawaiPage(),
          ),

          // 📌 Menu Pasien (belum aktif)
          _menuItem(
            context,
            icon: Icons.people,
            title: "Pasien",
            page: const PasienPage(),
          ),

          const Divider(),

          // 📌 Logout
          _menuItem(
            context,
            icon: Icons.logout_rounded,
            title: "Keluar",
            color: Colors.redAccent,
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 Fungsi pembuat ListTile menu
  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? page,
    VoidCallback? onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.blueAccent),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap ??
          () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page!),
            );
          },
    );
  }
}
