import 'package:flutter/material.dart';
import 'package:flutter_klinik_app/widget/sidebar.dart';
import '../model/pasien.dart';
import 'pasien_detail.dart'; // nanti kamu buat file ini juga ya

class PasienPage extends StatefulWidget {
  const PasienPage({super.key});

  @override
  State<PasienPage> createState() => _PasienPageState();
}

class _PasienPageState extends State<PasienPage> {
  final List<Pasien> pasienList = [
    Pasien(
      id: 1,
      nomorRm: 'RM001',
      nama: 'Siti Aminah',
      tanggalLahir: '2000-04-15',
      nomorTelepon: '081234567890',
      alamat: 'Jl. Merdeka No. 45, Bandung',
    ),
    Pasien(
      id: 2,
      nomorRm: 'RM002',
      nama: 'Rizky Pratama',
      tanggalLahir: '1998-10-02',
      nomorTelepon: '081298765432',
      alamat: 'Jl. Mawar No. 12, Jakarta',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Data Pasien"),
        backgroundColor: const Color.fromARGB(255, 66, 131, 234),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // nanti diarahkan ke form tambah pasien
              // contoh: Navigator.push(context, MaterialPageRoute(builder: (context) => const PasienForm()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pasienList.length,
        itemBuilder: (context, index) {
          final pasien = pasienList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PasienDetail(pasien: pasien),
                ),
              );
            },
            child: Card(
              color: Colors.green.shade100,
              child: ListTile(
                leading: const Icon(Icons.local_hospital, color: Colors.green),
                title: Text(pasien.nama),
                subtitle: Text("No. RM: ${pasien.nomorRm}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
