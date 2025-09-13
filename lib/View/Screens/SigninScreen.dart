import 'package:flutter/material.dart';
import 'package:foodie/Model/Colors.dart';
import 'package:foodie/View/Widgets/BottomFullCurveClipper.dart';
import 'package:foodie/View/Widgets/Loginwedgit.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWedth = MediaQuery.of(context).size.width * 0.88;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ClipPath(
            clipper: BottomFullCurveClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: double.infinity,
              color: ColorsApp.primary,
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 60),
                Center(
                  child: Image(
                    image: AssetImage('assets/images/logoWhite.png'),
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Deliver Favourite Food',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                ///-------------------
                ///-------------------
                ///-------------------
                // Boooox تسجيل الدخول
                ///-------------------
                ///-------------------
                ///-------------------
                LoginWidget( context , width: screenWedth,),
                const SizedBox(height: 24),
                Text(
                  "Don't have an account?",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/Signupscreen');
                  },
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      color: ColorsApp.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
