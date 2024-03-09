import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:zotato/admin/admin_login.dart';
import 'package:zotato/firebase_options.dart';
import 'package:zotato/pages/bottomnavbar.dart';

import 'package:zotato/pages/onboard.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
   
  );
  Stripe.publishableKey="pk_test_51Oq7VvSD1oR4oLstXAsVbCBNTLM0dR3LXcY6Dt63pnRaQCkaFkuiliyHw3WXQWajKZVt6EF3FyUenP0U5QFhExSl00zL7AGmWw";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Onboard(),
    );
  }
}