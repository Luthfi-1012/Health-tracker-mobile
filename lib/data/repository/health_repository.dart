import '../services/langkah_service.dart';
import '../services/tidur_service.dart';
import '../services/makanan_service.dart';

class HealthRepository {
  final LangkahService langkahService;
  final TidurService tidurService;
  final MakananService makananService;

  HealthRepository({
    required this.langkahService,
    required this.tidurService,
    required this.makananService,
  });

  Future<Map<String, dynamic>> getDashboardData() async {
    final langkah = await langkahService.ambilLangkahHariIni();
    final durasiTidur = await tidurService.ambilDurasiTidur();
    final kualitasTidur = await tidurService.ambilKualitasTidur();
    final makanan = await makananService.ambilMakananHariIni();

    return {
      'langkah': langkah,
      'tidurDurasi': durasiTidur,
      'tidurKualitas': kualitasTidur,
      'makanan': makanan,
    };
  }
}
