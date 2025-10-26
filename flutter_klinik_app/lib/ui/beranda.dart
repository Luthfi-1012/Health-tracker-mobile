import 'package:flutter/material.dart';
import 'package:flutter_klinik_app/widget/sidebar.dart';
import 'poli_page.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _moveController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<double> _moveAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // Animasi fade untuk teks/logo
    _fadeController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);

    // Animasi naik-turun untuk card info
    _moveController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat(reverse: true);
    _moveAnimation = Tween<double>(begin: -10, end: 10)
        .animate(CurvedAnimation(parent: _moveController, curve: Curves.easeInOut));

    // Animasi tombol pulse
    _pulseController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
        CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _moveController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  String _greetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) return "Selamat Pagi ☀️";
    if (hour < 17) return "Selamat Siang 🌤️";
    return "Selamat Malam 🌙";
  }

  Widget _infoCard(IconData icon, String value, String label, double offset) {
    return Transform.translate(
      offset: Offset(0, offset),
      child: Card(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 4,
        child: SizedBox(
          width: 110,
          height: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.deepPurple, size: 28),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Beranda"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade400,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade300, Colors.blue.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 30),

            // Logo Klinik
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Icon(
                Icons.local_hospital,
                size: 80,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            // Ucapan otomatis
            FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  Text(
                    _greetingMessage(),
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Selamat Datang di Sistem Klinik Sehat ✨",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Tombol Mulai Sekarang (Pulse Animation)
            Center(
              child: ScaleTransition(
                scale: _pulseAnimation,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 6,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const PoliPage()));
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text(
                    "Mulai Sekarang",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),

            // Card Info bergerak naik turun
            AnimatedBuilder(
              animation: _moveController,
              builder: (context, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _infoCard(Icons.local_hospital, "5", "Poli", _moveAnimation.value),
                    _infoCard(Icons.people, "20", "Pegawai", -_moveAnimation.value),
                    _infoCard(Icons.person, "32", "Pasien", _moveAnimation.value),
                  ],
                );
              },
            ),

            const SizedBox(height: 60),

            // Motto Klinik
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                "“Melayani dengan Hati, Menyembuhkan dengan Ilmu 💖”",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
