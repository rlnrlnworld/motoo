import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:motoo/page/login_screen.dart';
import 'package:motoo/page/onboarding_screen.dart';
import 'package:motoo/page/termsAgreement_screen.dart';

void main() {
  KakaoSdk.init(nativeAppKey: "299d4fe5bdf8a39a1004a57e25b95394");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Motoo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginScreen(),
        '/terms': (context) => TermsagreementScreen(),
      },
    );
  }
}
