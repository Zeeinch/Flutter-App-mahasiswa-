import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Deklarasi Form Key dan Controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Text("Login"),
              SizedBox(height: 20),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    
                    // Input Email
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Masukkan Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Input Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'Masukkan Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    // Tombol Login
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          EasyLoading.show();
                          
                          var url = Uri.parse('http://belajar-api.unama.ac.id/api/login');
                          var data = {
                            'email': _emailController.text,
                            'password': _passwordController.text,
                          };
                          
                          var response = await http.post(url, body: data, headers: {
                            'Accept': 'application/json',
                          });
                          
                          EasyLoading.dismiss();
                          
                          // Login dinyatakan berhasil jika kode response api adalah 200
                          if (response.statusCode == 200) {
                            Navigator.pushReplacementNamed(context, '/home');
                          } else {
                            var responJson = jsonDecode(response.body);
                            EasyLoading.showError('Ops...${responJson['message']}');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 50),
                      ),
                      child: Text('LOGIN'),
                    ),
                    SizedBox(height: 10),
                    
                    // Link Navigasi ke Halaman Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('atau'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text('Klik Untuk Register'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
