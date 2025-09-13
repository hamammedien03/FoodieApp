import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodie/Model/Colors.dart';
import 'package:foodie/View/Screens/CartProfileScreen.dart';
import 'package:foodie/View/Screens/ChatDetailsScreen.dart';
import 'package:foodie/View/Screens/EditLocation.dart';
import 'package:foodie/View/Screens/HomeScreen.dart';
import 'package:foodie/View/Screens/NotificationScreen.dart';
import 'package:foodie/View/Screens/OnboardingScreen.dart';
import 'package:foodie/View/Screens/PaymentsAndAdress.dart';
import 'package:foodie/View/Screens/SetLocationScreen.dart';
import 'package:foodie/View/Screens/SigninScreen.dart';
import 'package:foodie/View/Screens/SignupScreen.dart';
import 'package:foodie/View/Screens/SignupSuccessNotificationScreen.dart';
import 'package:foodie/View/Screens/SuccessResetPasswordPassword.dart';
import 'package:foodie/View/Screens/VerificationCodeScreen.dart';
import 'package:foodie/View/Screens/ViaForgetPasswordScreen.dart';
import 'package:foodie/View/Screens/VoucherPromoScreen.dart';
import 'package:foodie/View/Screens/callRinginScreen.dart';
import 'package:foodie/View/Screens/callScreen.dart';
import 'package:foodie/View/Screens/paymentMethodScreen.dart';
import 'package:foodie/View/Screens/uploadphotoScreen.dart';
import 'package:foodie/View/Screens/yourOrderScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isFirstTime: isFirstTime, isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final bool isLoggedIn;
  const MyApp({super.key, required this.isFirstTime, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Foodie App',
      theme: ThemeData(primarySwatch: ColorsApp.primary, fontFamily: 'Roboto'),
      home: isFirstTime
          ? OnBoardingScreens()
          : (isLoggedIn ? HomeScreen() : SigninScreen()),
      routes: {
        '/home': (context) => HomeScreen(),
        '/on-boarding-screen': (context) => OnBoardingScreens(),
        '/set-location': (context) => SetLocationScreen(),
        '/notification': (context) => NotificationScreen(),
        '/verificationcodeScreen': (context) => VerificationcodeScreen(),
        '/viaforgetpasswordscreen': (context) => Viaforgetpasswordscreen(),
        '/successresetpasswordScreen': (context) =>
            SuccessresetpasswordScreen(),
        '/voucher-promo': (context) => VoucherPromoScreen(),
        '/chat-details': (context) => ChatDetailsScreen(),
        '/call-ringing': (context) => CallRingingScreen(),
        '/call-screen': (context) => CallScreen(),
        '/upload-photo': (context) => Uploadphotoscreen(),
        '/payment-method': (context) => PaymentMethodScreen(),
        '/signin-screen': (context) => SigninScreen(),
        '/Signupscreen': (context) => Signupscreen(),
        '/signupsuccessnotificationscreen': (context) =>
            Signupsuccessnotificationscreen(),
        '/paymentmethodscreen': (context) => PaymentMethodScreen(),
        '/PaymentsAndAdressScreen': (context) => PaymentsAndAdressScreen(),
        '/editlocation': (context) => EditLocationScreen(),
        '/setlocation': (context) => SetLocationScreen(),
        '/cartprofilescreen': (context) => CartProfileScreen(),
        '/YourOrderScreen': (context) => YourOrderScreen(),
      },
    );
  }
}
