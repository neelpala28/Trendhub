import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trendhub/presentations/screens/address_page.dart';
import 'package:trendhub/data/providers/cart_provider.dart';

import 'package:trendhub/data/models/clothing_item.dart';
import 'package:trendhub/presentations/screens/create_address.dart';
import 'package:trendhub/presentations/screens/display_item.dart';
import 'package:trendhub/presentations/screens/email_verification_screen.dart';
import 'package:trendhub/presentations/screens/home_screen.dart';
import 'package:trendhub/presentations/screens/login_page.dart';
import 'package:trendhub/presentations/screens/payment_page.dart';
import 'package:trendhub/presentations/screens/sign_up_page.dart';
import 'package:trendhub/presentations/screens/user.dart';
import 'package:trendhub/presentations/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => UserData()),
    ],
    child: MyApp(),
  ));
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  Future<bool> isUserDeleted(User user) async {
    try {
      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;
      return refreshedUser == null;
    } catch (e) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator()); // Loading indicator
        } else if (snapshot.hasData) {
          final user = snapshot.data!;
          return FutureBuilder(
              future: isUserDeleted(user),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: const CircularProgressIndicator());
                } else if (userSnapshot.data == true) {
                  return const WelcomeScreen();
                } else {
                  return const HomeScreen();
                }
              });
        } else {
          return WelcomeScreen(); // User is not logged in
        }
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true),
        title: 'TrendHub',
        home: AuthWrapper(),
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/home': (context) => HomeScreen(),
          '/emailver': (context) => EmailVerificationScreen(),
          '/disp': (context) {
            // Retrieve the ClothingItem object passed from the HomeScreen
            final item =
                ModalRoute.of(context)!.settings.arguments as ClothingItem;
            return DisplayItem(
              item: item,
            );
          },
          '/address': (context) => AddressPage(),
          '/newaddress': (context) => CreateAddress(),
          '/payment': (context) => PaymentPage()
        },
        debugShowCheckedModeBanner: false);
  }
}
