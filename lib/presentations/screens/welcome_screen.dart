import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70.0),
                  child: Text(
                    'Welcome to TrendHub',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 107, 102, 102)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Explore Us',
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 136, 127, 127),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Lottie.network(
                  "https://lottie.host/8137ea25-1a63-4c73-bbfd-94d78f0c1aee/TDlxSHo2Fm.json",
                  height: 260,
                  repeat: true,
                  animate: true,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 120.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                            MediaQuery.of(context).size.width * 0.65,
                            MediaQuery.of(context).size.height * 0.07),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 28, 145, 241)),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  style: TextButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.65,
                        MediaQuery.of(context).size.height * 0.07),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      color: Color.fromARGB(255, 107, 102, 102),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
