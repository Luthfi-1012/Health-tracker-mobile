import 'package:flutter/material.dart';
import 'package:flutter_klinik_app/widget/sidebar.dart';
// ignore: unused_import
import '../model/pegawai.dart'; // pastikan file ini sudah dibuat
import 'pegawai_detail.dart'; // nanti buat file ini juga ya

class PegawaiPage extends StatefulWidget {
  const PegawaiPage({super.key});

  @override
  State<PegawaiPage> createState() => _PegawaiPageState();
}

class _PegawaiPageState extends State<PegawaiPage> {
  final List<Pegawai> pegawaiList = [
    Pegawai(
      id: 1,
      nip: 'PG001',
      nama: 'Ayu Lestari',
      tanggalLahir: '1998-03-21',
      nomorTelepon: '081234567890',
      email: 'ayu@klinik.com',
      password: '12345',
    ),
    Pegawai(
      id: 2,
      nip: 'PG002',
      nama: 'Budi Santoso',
      tanggalLahir: '1995-08-12',
      nomorTelepon: '081298765432',
      email: 'budi@klinik.com',
      password: '54321',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Pegawai"),
        backgroundColor: const Color.fromARGB(255, 66, 131, 234),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // nanti diarahkan ke form tambah pegawai
              // contoh: Navigator.push(context, MaterialPageRoute(builder: (context) => const PegawaiForm()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pegawaiList.length,
        itemBuilder: (context, index) {
          final pegawai = pegawaiList[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PegawaiDetail(pegawai: pegawai),
                ),
              );
            },
            child: Card(
              color: Colors.blue.shade100,
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.blue),
                title: Text(pegawai.nama),
                subtitle: Text("NIP: ${pegawai.nip}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
