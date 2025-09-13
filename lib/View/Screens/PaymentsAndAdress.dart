import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PaymentsAndAdressScreen extends StatefulWidget {
  const PaymentsAndAdressScreen({super.key});

  @override
  State<PaymentsAndAdressScreen> createState() =>
      _PaymentsAndAdressScreenState();
}

class _PaymentsAndAdressScreenState extends State<PaymentsAndAdressScreen> {
  String? address;
  String? paymentMethod;
  String? cardNumber;

  double subtotal = 0.0;
  double delivery = 2.0;

  @override
  void initState() {
    super.initState();
    _loadAddress();
    _loadPayment();
    _loadCartSubtotal();
  }

  Future<void> _loadCartSubtotal() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartList = prefs.getStringList('cartItems') ?? [];
    double sum = 0.0;
    for (var item in cartList) {
      final map = Map<String, dynamic>.from(json.decode(item));
      final price = map['price'] is num
          ? map['price']
          : double.tryParse(map['price'].toString()) ?? 0;
      final quantity = map['quantity'] ?? 1;
      sum += price * quantity;
    }
    setState(() {
      subtotal = sum;
    });
  }

  Future<void> _loadAddress() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('addresses')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      address =
          '${data['city'] ?? ''}, ${data['country'] ?? ''} ${data['postalCode'] ?? ''}';
    } else {
      address = null;
    }
    setState(() {});
  }

  Future<void> _loadPayment() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('payments')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      final data = snapshot.docs.first.data();
      paymentMethod = data['method'] ?? 'PayPal';
      cardNumber = data['cardNumber'];
    } else {
      paymentMethod = null;
      cardNumber = null;
    }
    setState(() {});
  }

  String getMaskedCardNumber(String? cardNumber) {
    if (cardNumber == null) return '';
    String digits = cardNumber.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 4) return '';
    String last4 = digits.substring(digits.length - 4);
    return '**** **** **** $last4';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Confirm Order',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Deliver to',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/editlocation');
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Color(0xFFFF2D55)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2E5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          title: Text(address ?? 'No address added'),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          dense: true,
                          minLeadingWidth: 0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment Method',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                '/paymentmethodscreen',
                              );
                            },
                            child: const Text(
                              'Edit',
                              style: TextStyle(color: Color(0xFFFF2D55)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2E5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: paymentMethod == 'PayPal'
                              ? Image.asset(
                                  'assets/images/paypal.png',
                                  width: 32,
                                )
                              : Image.asset(
                                  'assets/images/visa.png',
                                  width: 32,
                                ),
                          title: paymentMethod == null
                              ? const Text('No payment method added')
                              : paymentMethod == 'PayPal'
                              ? const Text('PayPal')
                              : Text(getMaskedCardNumber(cardNumber)),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          dense: true,
                          minLeadingWidth: 0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFF2E5),
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal', style: TextStyle(fontSize: 16)),
                      Text(
                        '\$${subtotal.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery', style: TextStyle(fontSize: 16)),
                      Text(
                        '\$${delivery.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(height: 32, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '\$${(subtotal + delivery).toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Color(0xFFF54748),
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF2D55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () async {
                        String orderId =
                            (100000 +
                                    (DateTime.now().millisecondsSinceEpoch %
                                        900000))
                                .toString();

                        final prefs = await SharedPreferences.getInstance();
                        List<String> cartList =
                            prefs.getStringList('cartItems') ?? [];
                        List<Map<String, dynamic>> cartItems = cartList
                            .map(
                              (item) =>
                                  Map<String, dynamic>.from(json.decode(item)),
                            )
                            .toList();

                        await FirebaseFirestore.instance
                            .collection('orders')
                            .add({
                              'orderId': orderId,
                              'items': cartItems,
                              'address': address ?? '',
                              'paymentMethod': paymentMethod ?? '',
                              'cardNumber': cardNumber ?? '',
                              'subtotal': subtotal,
                              'delivery': delivery,
                              'total': subtotal + delivery,
                              'createdAt': FieldValue.serverTimestamp(),
                            });

                        await prefs.setStringList('cartItems', []);
                        Navigator.pushReplacementNamed(
                          context,
                          '/YourOrderScreen',
                        );
                      },
                      child: const Text(
                        'Place Order',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
