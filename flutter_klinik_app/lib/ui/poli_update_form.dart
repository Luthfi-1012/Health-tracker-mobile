import 'package:flutter/material.dart';
import '../model/poli.dart';
import 'poli_detail.dart';

class PoliUpdateForm extends StatefulWidget {
  final Poli poli;

  const PoliUpdateForm({super.key, required this.poli});

  @override
  State<PoliUpdateForm> createState() => _PoliUpdateFormState();
}

class _PoliUpdateFormState extends State<PoliUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPoliCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _namaPoliCtrl.text = widget.poli.namaPoli;
  }

  @override
  void dispose() {
    _namaPoliCtrl.dispose();
    super.dispose();
  }

  Widget _fieldNamaPoli() {
    return TextField(
      controller: _namaPoliCtrl,
      decoration: const InputDecoration(
        labelText: "Nama Poli",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        final poli = Poli(namaPoli: _namaPoliCtrl.text);

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PoliDetail(poli: poli),
          ),
        );
      },
      child: const Text("Simpan Perubahan"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ubah Poli")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
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
