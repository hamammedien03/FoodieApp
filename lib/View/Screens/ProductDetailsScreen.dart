import 'package:flutter/material.dart';
import 'package:foodie/Model/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProductDetailsScreen extends StatefulWidget {
  final Map<String, String> food;
  const ProductDetailsScreen({required this.food, super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;

  Future<void> _addToCart() async {
    final prefs = await SharedPreferences.getInstance();
    final food = widget.food;

    List<String> cartList = prefs.getStringList('cartItems') ?? [];
    List<Map<String, dynamic>> cartItems = cartList
        .map((item) => Map<String, dynamic>.from(json.decode(item)))
        .toList();

    int existingIndex = cartItems.indexWhere(
      (item) =>
          item['title'] == food['title'] &&
          item['image'] == food['image'] &&
          item['price'] == food['price'],
    );

    if (existingIndex != -1) {
      cartItems[existingIndex]['quantity'] += quantity;
    } else {
      cartItems.add({
        'title': food['title'],
        'image': food['image'],
        'price': food['price'],
        'location': food['location'],
        'quantity': quantity,
      });
    }

    List<String> updatedCart = cartItems
        .map((item) => json.encode(item))
        .toList();
    await prefs.setStringList('cartItems', updatedCart);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Added to cart!')));
  }

  @override
  Widget build(BuildContext context) {
    final food = widget.food;
    return Scaffold(
      appBar: AppBar(
        title: Text(food['title'] ?? ''),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: food['title']!,
                child: Image.asset(
                  food['image']!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              food['title'] ?? '',

              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Text(
                  'Price: ',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                Text(
                  '${food['price']}\$',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFFF54748),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'This is a delicious ${food['title'] ?? ''} from ${food['location'] ?? ''}.',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[700],
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            SizedBox(
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (quantity > 1) setState(() => quantity--);
                    },
                    icon: Icon(Icons.remove_circle_outline),
                    iconSize: 35,
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() => quantity++);
                    },
                    icon: Icon(Icons.add_circle_outline),
                    iconSize: 35,
                  ),
                  SizedBox(width: 20),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF54748),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _addToCart,
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      size: 24,
                      color: ColorsApp.white,
                    ),
                    label: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 20,
                        color: ColorsApp.white,
                        fontWeight: FontWeight.bold,
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
