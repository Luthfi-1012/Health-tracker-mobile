import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

class StepProgressWidget extends StatelessWidget {
  final int steps;
  final int goal;

  const StepProgressWidget({
    super.key,
    required this.steps,
    required this.goal,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (steps / goal).clamp(0.0, 1.0);

    return CircularPercentIndicator(
      radius: 120,
      lineWidth: 15,
      animation: true,
      percent: percent,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$steps",
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Langkah",
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      progressColor: Colors.teal,
      backgroundColor: Colors.grey.shade200,
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
