import 'package:flutter/material.dart';
import 'package:flutter_klinik_app/ui/poli_form.dart';
import 'package:flutter_klinik_app/widget/sidebar.dart';
import '../model/poli.dart';
import 'poli_detail.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Sidebar(),
      appBar: AppBar(
        title: const Text("Data Poli"),
        backgroundColor: const Color.fromARGB(255, 66, 131, 234), // warna navbar
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PoliForm(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12), // jarak dari tepi layar
        children: [
          GestureDetector(
            onTap: () {
              final poli = Poli(namaPoli: "Poli Anak");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoliDetail(poli: poli),
                ),
              );
            },
            child: Card(
              color: Colors.blue.shade100,
              child: const ListTile(
                leading: Icon(Icons.child_care, color: Colors.blue),
                title: Text("Poli Anak"),
              ),
            ),
          ),
          const SizedBox(height: 10), // jarak antar card
          GestureDetector(
            onTap: () {
              final poli = Poli(namaPoli: "Poli Kandungan");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoliDetail(poli: poli),
                ),
              );
            },
            child: Card(
              color: Colors.pink.shade100,
              child: const ListTile(
                leading: Icon(Icons.pregnant_woman, color: Colors.pink),
                title: Text("Poli Kandungan"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              final poli = Poli(namaPoli: "Poli Gigi");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoliDetail(poli: poli),
                ),
              );
            },
            child: Card(
              color: Colors.orange.shade100,
              child: const ListTile(
                leading: Icon(Icons.medical_services, color: Colors.orange),
                title: Text("Poli Gigi"),
              ),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              final poli = Poli(namaPoli: "Poli THT");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PoliDetail(poli: poli),
                ),
              );
            },
            child: Card(
              color: Colors.green.shade100,
              child: const ListTile(
                leading: Icon(Icons.hearing, color: Colors.green),
                title: Text("Poli THT"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
