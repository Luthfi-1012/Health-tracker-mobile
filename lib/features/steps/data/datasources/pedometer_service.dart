import 'package:pedometer/pedometer.dart';

class PedometerService {
  Stream<StepCount> get stepCountStream => Pedometer.stepCountStream;
}
