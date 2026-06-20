import 'package:flutter/material.dart';
import 'home_page.dart';
import 'mahasiswa_form_page.dart';
import 'mahasiswa_list_page.dart';
import 'mahasiswa_detail_page.dart';
import 'mahasiswa_edit_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'register_page.dart';
import 'login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
        '/home': (context) => HomePage(),
        '/mahasiswa-list': (context) => MahasiswaListPage(),
        '/mahasiswa-form': (context) => MahasiswaFormPage(),
        '/mahasiswa-detail': (context) => MahasiswaDetailPage(),
        '/mahasiswa-edit': (context) => MahasiswaEditPage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
      },
      builder: EasyLoading.init(),
    );
  }
}
