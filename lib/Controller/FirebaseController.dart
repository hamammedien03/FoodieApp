import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodie/View/Screens/CompleteSignup.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Firebasecontroller {
  static Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithCredential(credential);
    if (userCredential.user != null) {
      Navigator.pushReplacementNamed(context, '/');
    }
  }

  // login with Email and Password
  static Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        Navigator.pushReplacementNamed(context, '/');
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed')));
      return null;
    }
    return null;
  }

  // تسجيل مستخدم جديد (الخطوة الأولى: الاسم، الإيميل، كلمة السر فقط)
  static Future<User?> registerWithEmailAndPasswordStep1({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'uid': user.uid,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CompleteSignupScreen(name: name, email: email, uid: user.uid),
          ),
        );
        return user;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
      return null;
    }
    return null;
  }

  static Future<void> completeUserProfile({
    required String uid,
    required String fullName,
    required String country,
    required String phone,
    required BuildContext context,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': fullName,
        'country': country,
        'phone': phone,
      }, SetOptions(merge: true));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to complete profile')));
    }
  }

  // إعادة تعيين كلمة المرور
  static Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('A password reset link has been sent to your email.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Failed to send reset email')),
      );
    }
  }

  static Future<List<Map<String, dynamic>>> fetchFoods() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('MenuProduct')
        .get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'title': data['title']?.toString() ?? '',
        'image': data['image']?.toString() ?? '',
        'price': data['price']?.toString() ?? '',
        'description': data['description']?.toString() ?? '',
        'location': (data['location'] is List)
            ? List<String>.from(data['location'].map((e) => e.toString()))
            : <String>[],
      };
    }).toList();
  }
}
