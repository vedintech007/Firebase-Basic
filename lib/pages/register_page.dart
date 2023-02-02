import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_firebase/widgets/input_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
    required this.showLoginPage,
  });

  final VoidCallback showLoginPage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  Future signUp() async {
    if (fieldsNotEmpty() && passwordConfirmed()) {
      print("siging up...");

      // create user
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("user Created");

      // add details
      addUserDetails();
    }
  }

  // add more details
  Future addUserDetails() async {
    await FirebaseFirestore.instance.collection("users").add(
      {
        'first name': _firstNameController.text.trim(),
        'last name': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'age': _ageController.text.trim(),
      },
    );
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _confirmPasswordController.text.trim()) {
      return true;
    } else {
      print("paswords do not match");
      return false;
    }
  }

  bool fieldsNotEmpty() {
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty && _confirmPasswordController.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hello There",
                  style: GoogleFonts.bebasNeue(
                    fontSize: 52,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Register below with your details!",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 30),
                InputFieldWidget(
                  hintText: "First Name",
                  controller: _firstNameController,
                ),

                const SizedBox(height: 10),
                InputFieldWidget(
                  hintText: "Last Name",
                  controller: _lastNameController,
                ),

                const SizedBox(height: 10),
                InputFieldWidget(
                  hintText: "Age",
                  controller: _ageController,
                ),

                // username / email textfield
                const SizedBox(height: 10),
                InputFieldWidget(
                  hintText: "Email",
                  controller: _emailController,
                ),

                // password textfield
                const SizedBox(height: 10),
                InputFieldWidget(
                  hintText: "Password",
                  obscureText: true,
                  controller: _passwordController,
                ),

                // password 2 textfield
                const SizedBox(height: 10),
                InputFieldWidget(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: _confirmPasswordController,
                ),

                // sign in btn
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: InkWell(
                    onTap: signUp,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                // not a member? Register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have account? ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
