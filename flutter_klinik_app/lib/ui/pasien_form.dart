import 'package:flutter/material.dart';
import 'package:flutter_klinik_app/model/pasien.dart';

class PasienForm extends StatefulWidget {
  const PasienForm({super.key, required Pasien pasien});

  @override
  State<PasienForm> createState() => _PasienFormState();
}

class _PasienFormState extends State<PasienForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nomorRmController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _nomorTeleponController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _nomorRmController.dispose();
    _tanggalLahirController.dispose();
    _nomorTeleponController.dispose();
    _alamatController.dispose();
    super.dispose();
  }

  void _simpanForm() {
    if (_formKey.currentState!.validate()) {
      final nama = _namaController.text;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pasien '$nama' berhasil disimpan")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Pasien"),
        backgroundColor: const Color.fromARGB(255, 66, 131, 234),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: "Nama Pasien",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Nama pasien tidak boleh kosong" : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nomorRmController,
                decoration: const InputDecoration(
                  labelText: "Nomor Rekam Medis",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _tanggalLahirController,
                decoration: const InputDecoration(
                  labelText: "Tanggal Lahir",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _nomorTeleponController,
                decoration: const InputDecoration(
                  labelText: "Nomor Telepon",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _alamatController,
                decoration: const InputDecoration(
                  labelText: "Alamat",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _simpanForm,
                icon: const Icon(Icons.save),
                label: const Text("Simpan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 66, 131, 234),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
