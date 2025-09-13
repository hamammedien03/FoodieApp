import 'package:flutter/material.dart';
import 'package:foodie/Model/Colors.dart';

class Signupsuccessnotificationscreen extends StatelessWidget {
  const Signupsuccessnotificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),

            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: ColorsApp.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                Icon(Icons.check, color: Colors.white, size: 80),
                Positioned(
                  left: 10,
                  top: 30,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: ColorsApp.primary,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 40,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: ColorsApp.primary,
                  ),
                ),
                Positioned(
                  left: 30,
                  bottom: 20,
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: ColorsApp.primary,
                  ),
                ),
                Positioned(
                  right: 30,
                  bottom: 30,
                  child: CircleAvatar(
                    radius: 3,
                    backgroundColor: ColorsApp.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text(
              'Congrats!',
              style: TextStyle(
                color: ColorsApp.primary,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your Profile Is Ready To Use',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/signin-screen');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
