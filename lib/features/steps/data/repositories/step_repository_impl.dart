import '../../domain/entities/step_entity.dart';
import '../../domain/repositories/step_repository.dart';
import '../datasources/pedometer_service.dart';

class StepRepositoryImpl implements StepRepository {
  final PedometerService pedometerService;

  StepRepositoryImpl(this.pedometerService);

  @override
  Stream<StepEntity> getStepCount() {
    return pedometerService.stepCountStream.map((event) {
      return StepEntity(steps: event.steps, date: DateTime.now());
    });
  }
}
