import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/datasources/pedometer_service.dart';
import '../../data/repositories/step_repository_impl.dart';
import '../../domain/entities/step_entity.dart';
import '../widgets/step_progress_widget.dart'; // ✅ pakai widget modular

class StepsPage extends StatefulWidget {
  const StepsPage({super.key});

  @override
  State<StepsPage> createState() => _StepsPageState();
}

class _StepsPageState extends State<StepsPage> {
  final _repository = StepRepositoryImpl(PedometerService());
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    // ✅ Listen ke stream langkah dari repository
    _repository.getStepCount().listen((StepEntity data) {
      setState(() => _steps = data.steps);
    });
  }

  @override
  Widget build(BuildContext context) {
    const int goal = 8000; // target langkah harian

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Pelacak Langkah",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ✅ Gunakan widget modular
            StepProgressWidget(steps: _steps, goal: goal),
            const SizedBox(height: 30),

            // ✅ Info tambahan di bawah progress
            Text(
              "Target harian: $goal langkah",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _steps >= goal
                  ? "🎉 Selamat! Kamu mencapai target hari ini!"
                  : "Terus bergerak! 💪",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _steps >= goal ? Colors.teal : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
