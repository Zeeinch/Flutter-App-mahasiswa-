import 'package:flutter/material.dart';

class MahasiswaDetailPage extends StatefulWidget {
  const MahasiswaDetailPage({super.key});

  @override
  _MahasiswaDetailPageState createState() => _MahasiswaDetailPageState();
}

class _MahasiswaDetailPageState extends State<MahasiswaDetailPage> {
  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(data['foto']),
              ),
            ),
            SizedBox(height: 20),
            Text('Nama: ' + data['nama'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('NIM: ' + data['nim'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Tanggal Lahir: ' + data['tanggal_lahir'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Program Studi: ' + data['program_studi'], style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
