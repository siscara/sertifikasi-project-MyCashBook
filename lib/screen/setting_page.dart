import 'package:crud_sisca/screen/home_page.dart';
import 'package:crud_sisca/screen/login_page.dart';
import 'package:crud_sisca/widget/card_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController passNewController = TextEditingController();
  TextEditingController passOldController = TextEditingController();
  String password = "";

  getPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? pass = prefs.getString('password');
    password = pass.toString();
  }

  save() {
    if (passNewController.text.isEmpty || passOldController.text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Password Gagal Diganti'),
          content: const Text('Harap isi data'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (passOldController.text == password) {
      savePass();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Password Gagal Ganti'),
          content: const Text('password lama salah'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  savePass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', passNewController.text);
  }

  removePass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLogin', false);
  }

  logout() {
    removePass();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    getPass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan"),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text("Ganti Password"),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CardInput(
                controller: passOldController,
                title: "Password lama",
                hint: "Masukkan Password Lama",
                isObsecure: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CardInput(
                controller: passNewController,
                title: "Password Baru",
                hint: "Masukkan Password Baru",
                isObsecure: false,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, foregroundColor: Colors.black),
              onPressed: () {
                save();
              },
              child: const Text("Simpan"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, foregroundColor: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("<< Kembali"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, foregroundColor: Colors.black),
              onPressed: () {
                logout();
              },
              child: const Text("Log out"),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/images/profile.png'),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About This App"),
                    Text("Aplikasi ini dibuat oleh:"),
                    Text("Nama: Sisca Dwi Rahayu"),
                    Text("NIM: 2141764003"),
                    Text("Tanggal: 27 September 2023"),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
