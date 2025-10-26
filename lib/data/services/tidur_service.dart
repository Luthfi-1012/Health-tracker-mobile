class TidurService {
  Future<double> ambilDurasiTidur() async {
    await Future.delayed(Duration(milliseconds: 500));
    return 7.5; // contoh: 7 jam 30 menit
  }

  Future<double> ambilKualitasTidur() async {
    await Future.delayed(Duration(milliseconds: 500));
    return 82.0; // contoh skor kualitas tidur
  }
}
