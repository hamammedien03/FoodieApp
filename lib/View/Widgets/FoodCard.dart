import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String? heroTag;

  const FoodCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFFFFF3ED),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            heroTag != null
                ? Hero(
                    tag: heroTag!,
                    child: Image.asset(
                      image,
                      width: 100,
                      height: 80,
                      fit: BoxFit.fill,
                    ),
                  )
                : Image.asset(image, width: 100, height: 80, fit: BoxFit.fill),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 6),
            Text(
              price,
              style: TextStyle(
                color: Color(0xFFF54748),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
