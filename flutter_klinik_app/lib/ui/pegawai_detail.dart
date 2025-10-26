import 'package:flutter/material.dart';
import '../model/pegawai.dart';
import 'pegawai.form.dart';

class PegawaiDetail extends StatelessWidget {
  final Pegawai pegawai;

  const PegawaiDetail({super.key, required this.pegawai});

  void _konfirmasiHapus(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: Text("Yakin ingin menghapus ${pegawai.nama}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${pegawai.nama} berhasil dihapus")),
              );
              Navigator.pop(context);
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pegawai"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("NIP: ${pegawai.nip}", style: const TextStyle(fontSize: 18)),
            Text("Nama: ${pegawai.nama}", style: const TextStyle(fontSize: 18)),
            Text("Tanggal Lahir: ${pegawai.tanggalLahir}", style: const TextStyle(fontSize: 18)),
            Text("Telepon: ${pegawai.nomorTelepon}", style: const TextStyle(fontSize: 18)),
            Text("Email: ${pegawai.email}", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PegawaiForm(pegawai: pegawai),
                      ),
                    );
                  },
                  child: const Text("Ubah"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => _konfirmasiHapus(context),
                  child: const Text("Hapus"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
