import 'package:flutter/material.dart';
import 'poli_page.dart';
import 'poli_update_form.dart';
import '../model/poli.dart';

class PoliDetail extends StatefulWidget {
  final Poli poli;

  const PoliDetail({super.key, required this.poli});

  @override
  State<PoliDetail> createState() => _PoliDetailState();
}

class _PoliDetailState extends State<PoliDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Poli"),
          centerTitle: true,
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDetailCard(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: _tombolUbah()),
                  const SizedBox(width: 16),
                  Expanded(child: _tombolHapus()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Kartu detail poli
  Widget _buildDetailCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(
              Icons.local_hospital,
              color: Colors.teal,
              size: 50,
            ),
            const SizedBox(height: 16),
            const Text(
              "Nama Poli",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.poli.namaPoli,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Tombol ubah
  Widget _tombolUbah() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PoliUpdateForm(poli: widget.poli),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text("Ubah"),
    );
  }

  // 🔹 Tombol hapus dengan dialog konfirmasi dan kembali ke PoliPage
  Widget _tombolHapus() {
    return ElevatedButton(
      onPressed: () {
        AlertDialog alertDialog = AlertDialog(
          title: const Text("Hapus Poli"),
          content: const Text("Yakin ingin menghapus data ini?"),
          actions: [
            // Tombol YA
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Poli berhasil dihapus"),
                    backgroundColor: Colors.redAccent,
                  ),
                );
                // Ganti halaman ke PoliPage setelah hapus
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PoliPage()),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("YA"),
            ),
            // Tombol Tidak
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text("Tidak"),
            ),
          ],
        );

        showDialog(context: context, builder: (context) => alertDialog);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text("Hapus"),
    );
  }
}
