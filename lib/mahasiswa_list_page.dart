import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MahasiswaListPage extends StatefulWidget {
  const MahasiswaListPage({super.key});

  @override
  _MahasiswaListPageState createState() => _MahasiswaListPageState();
}

class _MahasiswaListPageState extends State<MahasiswaListPage> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  List listData = [];

  void getData() async {
    EasyLoading.show();
    var Url = Uri.parse('https://belajar-api.unama.ac.id/api/mahasiswa');
    var respon = await http.get(Url);
    var responJSON = jsonDecode(respon.body);
    setState(() {
      listData = responJSON['data'];
    });
    EasyLoading.dismiss();
  }

  // Method deleteData untuk menghapus data mahasiswa
  void deleteData(id) {
    EasyLoading.show();
    var url = Uri.parse('https://belajar-api.unama.ac.id/api/mahasiswa/$id');
    http.delete(url).then((response) {
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        EasyLoading.showSuccess('Data berhasil dihapus');
        getData();
      } else {
        var responJson = jsonDecode(response.body);
        EasyLoading.showError('Ops..' + responJson['message']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Mahasiswa'),
      ),
      body: ListView.builder(
        itemCount: listData.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: SizedBox(
              width: 80,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/mahasiswa-edit',
                        arguments: listData[index],
                      );
                    },
                    icon: Icon(Icons.edit),
                  ), // IconButton Edit
                  IconButton(
                    onPressed: () {
                      deleteData(listData[index]['id']);
                    },
                    icon: Icon(Icons.delete),
                  ), // IconButton Delete
                ],
              ), // Row
            ), // SizedBox
            onTap: () {
              Navigator.pushNamed(
                context,
                '/mahasiswa-detail',
                arguments: listData[index],
              );
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(listData[index]['foto']),
            ),
            title: Text('Nama: ' + listData[index]['nama']),
            subtitle: Text('NIM: ' + listData[index]['nim']),
          );
        },
      ),
    );
  }
}