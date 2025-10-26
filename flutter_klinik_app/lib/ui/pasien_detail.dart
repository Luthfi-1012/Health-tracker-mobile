import 'package:flutter/material.dart';
import '../model/pasien.dart';
import 'pasien_form.dart'; // pastikan file ini sudah ada ya

class PasienDetail extends StatelessWidget {
  final Pasien pasien;

  const PasienDetail({super.key, required this.pasien});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pasien"),
        backgroundColor: const Color.fromARGB(255, 66, 131, 234),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          color: Colors.blue.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama: ${pasien.nama}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text("Nomor RM: ${pasien.nomorRm}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Tanggal Lahir: ${pasien.tanggalLahir}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Nomor Telepon: ${pasien.nomorTelepon}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Text("Alamat: ${pasien.alamat}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // 🔹 Tombol Ubah — sudah bisa digunakan
                    ElevatedButton.icon(
                      onPressed: () async {
                        final updatedPasien = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PasienForm(pasien: pasien),
                          ),
                        );

                        if (updatedPasien != null) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Data pasien berhasil diubah!")),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, updatedPasien);
                        }
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text("Ubah"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                    ),

                    // 🔹 Tombol Hapus — nanti bisa kamu sambungkan ke backend
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Data pasien dihapus (simulasi)")),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text("Hapus"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
