class MakananService {
  Future<List<Map<String, dynamic>>> ambilMakananHariIni() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [
      {'nama': 'Nasi Goreng', 'kalori': 450},
      {'nama': 'Susu', 'kalori': 150},
      {'nama': 'Ayam Bakar', 'kalori': 300},
    ];
  }
}
