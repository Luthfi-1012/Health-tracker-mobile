import 'package:flutter/material.dart';
import '../model/pegawai.dart';

class PegawaiForm extends StatefulWidget {
  final Pegawai? pegawai;
  const PegawaiForm({super.key, this.pegawai});

  @override
  State<PegawaiForm> createState() => _PegawaiFormState();
}

class _PegawaiFormState extends State<PegawaiForm> {
  final _formKey = GlobalKey<FormState>();
  final _nipController = TextEditingController();
  final _namaController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _teleponController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.pegawai != null) {
      _nipController.text = widget.pegawai!.nip;
      _namaController.text = widget.pegawai!.nama;
      _tanggalLahirController.text = widget.pegawai!.tanggalLahir;
      _teleponController.text = widget.pegawai!.nomorTelepon;
      _emailController.text = widget.pegawai!.email;
      _passwordController.text = widget.pegawai!.password;
    }
  }

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data pegawai berhasil disimpan')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pegawai == null ? "Tambah Pegawai" : "Ubah Pegawai"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nipController,
                decoration: const InputDecoration(labelText: "NIP"),
                validator: (value) => value!.isEmpty ? "NIP tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: "Nama"),
                validator: (value) => value!.isEmpty ? "Nama tidak boleh kosong" : null,
              ),
              TextFormField(
                controller: _tanggalLahirController,
                decoration: const InputDecoration(labelText: "Tanggal Lahir"),
              ),
              TextFormField(
                controller: _teleponController,
                decoration: const InputDecoration(labelText: "Nomor Telepon"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _simpanData,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text("Simpan"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
