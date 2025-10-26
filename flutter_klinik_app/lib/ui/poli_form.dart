import 'package:flutter/material.dart';
// ignore: unused_import
import '../model/poli.dart'; 
// ignore: unused_import
import 'poli_detail.dart'; 

class PoliForm extends StatefulWidget {
  const PoliForm({super.key});

  @override
  State<PoliForm> createState() => _PoliFormState();
}

class _PoliFormState extends State<PoliForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPoliController = TextEditingController();

  @override
  void dispose() {
    _namaPoliController.dispose();
    super.dispose();
  }

  void _simpanForm() {
    if (_formKey.currentState!.validate()) {
      final namaPoli = _namaPoliController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Poli '$namaPoli' berhasil disimpan"),
          backgroundColor: Colors.teal,
        ),
      );
      Navigator.pop(context);
    }
  }

  // 🔹 Pemisahan widget ke dalam fungsi
  Widget _fieldNamaPoli() {
    return TextFormField(
      controller: _namaPoliController,
      decoration: InputDecoration(
        labelText: "Nama Poli",
        filled: true,
        fillColor: Colors.teal.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: const Icon(Icons.local_hospital, color: Colors.teal),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Nama Poli tidak boleh kosong";
        }
        return null;
      },
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: _simpanForm,
      child: const Text(
        "Simpan",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Poli"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _fieldNamaPoli(),
              const SizedBox(height: 20),
              _tombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }
}
