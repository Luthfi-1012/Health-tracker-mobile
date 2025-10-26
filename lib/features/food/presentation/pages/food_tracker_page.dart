import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/app_colors.dart';
import '../../../../data/services/notification_service.dart';

class FoodTrackerPage extends StatefulWidget {
  const FoodTrackerPage({super.key});

  @override
  State<FoodTrackerPage> createState() => _FoodTrackerPageState();
}

class _FoodTrackerPageState extends State<FoodTrackerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final NotificationService _notificationService = NotificationService();

  // Data makanan per kategori
  final Map<String, List<Map<String, dynamic>>> foodData = {
    'Sarapan': [
      {'nama': 'Nasi Goreng', 'kalori': 450, 'icon': FontAwesomeIcons.bowlRice},
      {
        'nama': 'Roti Panggang + Telur',
        'kalori': 320,
        'icon': FontAwesomeIcons.breadSlice,
      },
      {
        'nama': 'Oatmeal + Buah',
        'kalori': 280,
        'icon': FontAwesomeIcons.bowlFood,
      },
    ],
    'Makan Siang': [
      {
        'nama': 'Ayam Bakar + Sayur',
        'kalori': 380,
        'icon': FontAwesomeIcons.drumstickBite,
      },
      {
        'nama': 'Nasi + Ikan + Tahu',
        'kalori': 420,
        'icon': FontAwesomeIcons.fish,
      },
    ],
    'Makan Malam': [
      {
        'nama': 'Ikan Panggang + Nasi',
        'kalori': 420,
        'icon': FontAwesomeIcons.fish,
      },
      {'nama': 'Soto Ayam', 'kalori': 350, 'icon': FontAwesomeIcons.bowlFood},
    ],
    'Snack': [
      {
        'nama': 'Salad Buah',
        'kalori': 150,
        'icon': FontAwesomeIcons.appleWhole,
      },
      {
        'nama': 'Kacang Almond',
        'kalori': 180,
        'icon': FontAwesomeIcons.seedling,
      },
      {'nama': 'Yogurt', 'kalori': 120, 'icon': FontAwesomeIcons.iceCream},
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    // Check calorie intake on init
    _checkCalorieIntake();
  }

  void _checkCalorieIntake() {
    _notificationService.checkCalorieIntake(totalCalories, targetCalories);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int get totalCalories {
    int total = 0;
    foodData.forEach((category, foods) {
      for (var food in foods) {
        total += food['kalori'] as int;
      }
    });
    return total;
  }

  final int targetCalories = 2000;

  @override
  Widget build(BuildContext context) {
    double progress = totalCalories / targetCalories;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Food Tracker',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {
              _showAddFoodDialog();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          labelStyle: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(fontSize: 13),
          tabs: const [
            Tab(text: 'Sarapan'),
            Tab(text: 'Makan Siang'),
            Tab(text: 'Makan Malam'),
            Tab(text: 'Snack'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Calorie Summary Card
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accent, AppColors.accent.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Total Kalori Hari Ini',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      '$totalCalories',
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      ' / $targetCalories',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                Text(
                  'kalori',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  targetCalories > totalCalories
                      ? 'Sisa ${targetCalories - totalCalories} kalori'
                      : 'Melebihi ${totalCalories - targetCalories} kalori',
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),

          // Macronutrients Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _buildMacroCard(
                    'Protein',
                    '65g',
                    FontAwesomeIcons.egg,
                    AppColors.accent,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMacroCard(
                    'Karbo',
                    '180g',
                    FontAwesomeIcons.breadSlice,
                    AppColors.accentYellow,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildMacroCard(
                    'Lemak',
                    '45g',
                    FontAwesomeIcons.droplet,
                    AppColors.accentBlue,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildFoodList('Sarapan'),
                _buildFoodList('Makan Siang'),
                _buildFoodList('Makan Malam'),
                _buildFoodList('Snack'),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddFoodDialog,
        backgroundColor: AppColors.accent,
        icon: const Icon(Icons.add),
        label: Text(
          'Tambah Makanan',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildMacroCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
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
          FaIcon(icon, color: color, size: 24),
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
      ),
    );
  }

  Widget _buildFoodList(String category) {
    final foods = foodData[category] ?? [];

    if (foods.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.utensils,
              size: 64,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 16),
            Text(
              'Belum ada makanan untuk $category',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: foods.length,
      itemBuilder: (context, index) {
        final food = foods[index];
        return _buildFoodItem(food['nama'], food['kalori'], food['icon']);
      },
    );
  }

  Widget _buildFoodItem(String name, int calories, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: FaIcon(icon, color: AppColors.accent, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$calories kalori',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$calories',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accent,
                ),
              ),
              Text(
                'kcal',
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddFoodDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Tambah Makanan',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            content: Text(
              'Fitur tambah makanan akan segera tersedia!',
              style: GoogleFonts.poppins(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK', style: GoogleFonts.poppins()),
              ),
            ],
          ),
    );
  }
}
