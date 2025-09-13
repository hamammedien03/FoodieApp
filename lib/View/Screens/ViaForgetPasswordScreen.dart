import 'package:flutter/material.dart';
import 'package:foodie/Model/Colors.dart';
import 'package:foodie/View/Widgets/BottomFullCurveClipper.dart'
    show BottomFullCurveClipper;
import 'package:foodie/View/Widgets/ViaForgetPasswordWidget.dart';

class Viaforgetpasswordscreen extends StatefulWidget {
  const Viaforgetpasswordscreen({super.key});

  @override
  State<Viaforgetpasswordscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Viaforgetpasswordscreen> {
  @override
  Widget build(BuildContext context) {
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
               ViaForgetPasswordWidget(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
