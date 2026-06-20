import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MahasiswaFormPage extends StatefulWidget {
  const MahasiswaFormPage({super.key});

  @override
  _MahasiswaFormPageState createState() => _MahasiswaFormPageState();
}

class _MahasiswaFormPageState extends State<MahasiswaFormPage> {
  // 1. Membuat GlobalKey untuk Form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 2. Membuat controller untuk setiap TextFormField
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _programStudiController = TextEditingController();

  // 3. Membuat method untuk simpan data ke API
  void _simpanForm(context) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show();

      var url = Uri.parse('https://belajar-api.unama.ac.id/api/mahasiswa');
      var data = {
        'nama': _namaController.text,
        'nim': _nimController.text,
        'tanggal_lahir': _tanggalLahirController.text,
        'program_studi': _programStudiController.text,
      };

      var response = await http.post(url, body: data, headers: {
        'Accept': 'application/json',
      });

      EasyLoading.dismiss();

      if (response.statusCode == 201) {
        EasyLoading.showSuccess('Data berhasil disimpan');
        Navigator.of(context).pushNamed('/mahasiswa-list');
      } else {
        var responJson = jsonDecode(response.body);
        EasyLoading.showError('Ops.. ' + responJson['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mhs'),
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
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  
                  if (pickedDate != null) {
                    String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    setState(() {
                      _tanggalLahirController.text = formattedDate;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Tanggal Lahir',
                  suffixIcon: Icon(Icons.calendar_today),
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
                onPressed: () => _simpanForm(context),
                child: Text('Simpan'),
              ), // ElevatedButton
            ],
          ), // Column
        ), // Form
      ), // Padding
    ); // Scaffold
  }
}