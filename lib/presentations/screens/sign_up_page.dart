import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendhub/presentations/screens/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  var isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    setState(() {
      isLoading = true;
    });

    // Navigate to another page or show a success message

    if (_formKey.currentState!.validate()) {
      try {
        // Register the user
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (userCredential.user != null) {
          await userCredential.user!.sendEmailVerification();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Verification email sent to ${_emailController.text}')),
          );
        }
        Navigator.of(context).pushReplacementNamed('/emailver');
        // Navigate to the home screen or login screen
      } on FirebaseAuthException catch (e) {
        // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Registration failed.')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> storeUserDetails(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userName', name);
    prefs.setString('userEmail', email);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey, // Form key is used here
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 20, top: MediaQuery.of(context).size.height * 0.01),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: IconButton.styleFrom(
                        foregroundColor: Colors.grey, iconSize: 25),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  child: Text(
                    'SignUp',
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 30),
                  ),
                ),
                const SizedBox(height: 50),
                // Name Field
                const Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Name',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 64, 62, 62)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        hintText: 'Enter your Name',
                        hintStyle: TextStyle(color: Colors.grey)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ),
                // Email Field
                const Padding(
                  padding: EdgeInsets.only(left: 30, top: 30),
                  child: Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 64, 62, 62)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        hintText: 'Enter your Email',
                        hintStyle: TextStyle(color: Colors.grey)),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      // Move focus to the next field
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                // Password Field
                const Padding(
                  padding: EdgeInsets.only(left: 30, top: 30),
                  child: Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 64, 62, 62)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.grey)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      _submit(); // Submit the form when "Done" is pressed
                    },
                  ),
                ),
                // Sign Up Button
                Padding(
                  padding: EdgeInsets.only(
                      top: 40, left: MediaQuery.of(context).size.width * 0.1),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _submit();
                        }
                        user.updateUser(
                            _nameController.text, _emailController.text);
                        storeUserDetails(
                            _nameController.text, _emailController.text);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.8, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blueAccent),
                      child: const Text('Sign Up')),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
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
