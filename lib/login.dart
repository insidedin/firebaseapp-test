import 'package:fire_app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Pastikan widget masih mounted sebelum menggunakan BuildContext
      if (mounted) {
        // Login successful, navigate to the next screen and pass user information
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      // Handle login error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Login failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                height: 60,
                child: TextField(
                  controller: usernameController,
                  textInputAction: TextInputAction.search,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 142, 142, 142),
                        size: 22,
                      ),
                      labelText: 'Username',
                      fillColor: const Color.fromARGB(255, 232, 232, 232),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
              ),
              const SizedBox(height: 20), // Add space between the text fields
              SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                height: 60,
                child: TextField(
                  controller: passwordController,
                  obscureText: !passwordVisible,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 142, 142, 142),
                        size: 22,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color.fromARGB(255, 142, 142, 142),
                          size: 22,
                        ),
                        onPressed: () {
                          setState(() {
                            passwordVisible = !passwordVisible;
                          });
                        },
                      ),
                      labelText: 'Password',
                      fillColor: const Color.fromARGB(255, 232, 232, 232),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
              ),
              const SizedBox(height: 30), // Add space before the button
              ElevatedButton(
                onPressed: () {
                  // Handle login action
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width - 90, 50),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
