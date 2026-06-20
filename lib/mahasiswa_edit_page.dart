import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MahasiswaEditPage extends StatefulWidget {
  const MahasiswaEditPage({super.key});

  @override
  _MahasiswaEditPageState createState() => _MahasiswaEditPageState();
}

class _MahasiswaEditPageState extends State<MahasiswaEditPage> {
  // 1. Membuat GlobalKey untuk Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 2. Membuat controller untuk setiap TextFormField
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _programStudiController = TextEditingController();

  // 3. Membuat method untuk simpan data (PUT) ke API
  void _simpanForm(context, id) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();

      var url = Uri.parse('https://belajar-api.unama.ac.id/api/mahasiswa/$id');
      var data = {
        'nama': _namaController.text,
        'nim': _nimController.text,
        'tanggal_lahir': _tanggalLahirController.text,
        'program_studi': _programStudiController.text,
      };

      var response = await http.put(url, body: data, headers: {
        'Accept': 'application/json',
      });

      EasyLoading.dismiss();

      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Data berhasil disimpan');
        Navigator.pop(context);
      } else {
        var responJson = jsonDecode(response.body);
        EasyLoading.showError('Ops.. ' + responJson['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dataMhs = ModalRoute.of(context)!.settings.arguments as Map;
    _namaController.text = dataMhs['nama'];
    _nimController.text = dataMhs['nim'];
    _tanggalLahirController.text = dataMhs['tanggal_lahir'];
    _programStudiController.text = dataMhs['program_studi'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Form Edit Mahasiswa'),
      ), // AppBar
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TextFormField untuk Nama
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                ), // InputDecoration
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ), // TextFormField

              // TextFormField untuk NIM
              TextFormField(
                controller: _nimController,
                decoration: InputDecoration(
                  labelText: 'NIM',
                ), // InputDecoration
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'NIM tidak boleh kosong';
                  }
                  return null;
                },
              ), // TextFormField

              // TextFormField untuk Tanggal Lahir
              TextFormField(
                controller: _tanggalLahirController,
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                ), // InputDecoration
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Tanggal Lahir tidak boleh kosong';
                  }
                  return null;
                },
              ), // TextFormField

              // TextFormField untuk Program Studi
              TextFormField(
                controller: _programStudiController,
                decoration: InputDecoration(
                  labelText: 'Program Studi',
                ), // InputDecoration
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Program Studi tidak boleh kosong';
                  }
                  return null;
                },
              ), // TextFormField

              SizedBox(height: 16.0),

              ElevatedButton(
                onPressed: () => _simpanForm(context, dataMhs['id']),
                child: Text('Simpan'),
              ), // ElevatedButton
            ],
          ), // Column
        ), // Form
      ), // Padding
    ); // Scaffold
  }
}
