import '../entities/step_entity.dart';

abstract class StepRepository {
  Stream<StepEntity> getStepCount();
}
