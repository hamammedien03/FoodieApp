import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credit_card_validator/credit_card_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_expiration_input_formatter.dart';
import 'package:flutter_multi_formatter/formatters/credit_card_number_input_formatter.dart';
import 'package:foodie/Model/Colors.dart';
import 'package:foodie/View/Screens/PaymentsAndAdress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VisaPaymentScreen extends StatefulWidget {
  const VisaPaymentScreen({super.key});

  @override
  State<VisaPaymentScreen> createState() => _VisaPaymentScreenState();
}

class _VisaPaymentScreenState extends State<VisaPaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool isLoading = false;

  Future<void> _submitOrder() async {
    setState(() {
      isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList('cartItems') ?? [];
    List<Map<String, dynamic>> cartItems = cartList
        .map((item) => Map<String, dynamic>.from(json.decode(item)))
        .toList();
    final uid = prefs.getString('uid') ?? 'guest';

    if (cartItems.isEmpty) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Cart is empty!')));
      return;
    }

    await FirebaseFirestore.instance.collection('payments').add({
      'uid': uid,
      'method': 'visa',
      'cardNumber': _cardNumberController.text,
      'expiry': _expiryController.text,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await FirebaseFirestore.instance.collection('orders').add({
      'uid': uid,
      'items': cartItems,
      'payment': 'visa',
      'createdAt': FieldValue.serverTimestamp(),
      'cardNumber': _cardNumberController.text,
      'expiry': _expiryController.text,
    });

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Order placed successfully!')));
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PaymentsAndAdressScreen()));
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Payment'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _cardNumberController,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [CreditCardNumberInputFormatter()],
                onChanged: (_) => setState(() {}),
                validator: (val) {
                  final result = CreditCardValidator().validateCCNum(val ?? '');
                  if (!result.isValid) return 'Enter valid card number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _expiryController,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  hintText: 'MM/YY',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [CreditCardExpirationDateFormatter()],
                onChanged: (_) => setState(() {}),
                validator: (val) => (val != null && val.length == 5)
                    ? null
                    : 'Enter valid expiry',
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cvvController,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 4,
                onChanged: (_) => setState(() {}),
                validator: (val) =>
                    (val != null && val.length >= 3) ? null : 'Enter valid CVV',
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      !isLoading && (_formKey.currentState?.validate() ?? false)
                      ? () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _submitOrder();
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsApp.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Pay',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
