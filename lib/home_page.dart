import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ 
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mahasiswa-list');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(140, 100),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.switch_account_rounded, size: 40),
                      Text('Data Mahasiswa'),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/mahasiswa-form');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(140, 100),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.my_library_add, size: 40),
                      Text('Tambah Data'), 
                    ],
                  ),
                ),
              ], 
            ),
          ],
        ),
      ),
    );
  } // <--- Penutup Method build
} // <--- Penutup Class _HomePageState