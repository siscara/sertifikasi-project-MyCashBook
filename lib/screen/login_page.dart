import 'package:crud_sisca/screen/home_page.dart';
import 'package:crud_sisca/widget/card_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String password = "";
  bool isLogin = false;

  getPass() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? pass = prefs.getString('password');
    password = pass.toString();
    final bool? loginDetection = prefs.getBool('isLogin');
    if (loginDetection != null) {
      isLogin = loginDetection;
    }
    final String? action = prefs.getString('password');
    print(action);
  }

  login() {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Login Gagal'),
          content: const Text('Harap isi username dan password'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (usernameController.text == "sisca" &&
        passwordController.text == password &&
        isLogin == false) {
      savePass();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else if (usernameController.text == "sisca" &&
        passwordController.text == 'sisca123' &&
        password.toString().contains("null")) {
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
          title: const Text('Login Gagal'),
          content: const Text('username atau password salah'),
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
    await prefs.setBool('isLogin', true);
    await prefs.setString('password', passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPass(),
        builder: (context, snapshot) {
          if (!isLogin) {
            return Scaffold(
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset(
                          'assets/images/applogo.png',
                        ),
                      ),
                      const Text("MyCashBook V 1.0"),
                      Column(
                        children: [
                          CardInput(
                            controller: usernameController,
                            hint: "Masukkan username",
                            isObsecure: false,
                            title: "Username",
                          ),
                          CardInput(
                            controller: passwordController,
                            hint: "Masukkan password",
                            isObsecure: true,
                            title: "Password",
                          ),
                        ],
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            login();
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 25),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: const Text("Login"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return const HomePage();
          }
        });
  }
}
