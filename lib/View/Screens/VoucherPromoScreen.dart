import 'package:flutter/material.dart';

class VoucherPromoScreen extends StatelessWidget {
  const VoucherPromoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Voucher Promo',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 24),
            _PromoCard(
              color: Color(0xFFF54748),
              textColor: Colors.white,
              buttonColor: Colors.white,
              buttonTextColor: Color(0xFFF54748),
              image: 'assets/images/Spetialdeal.png',
            ),
            SizedBox(height: 18),
            _PromoCard(
              color: Color(0xFFF3FFD2),
              textColor: Colors.black,
              buttonColor: Colors.white,
              buttonTextColor: Color(0xFFF54748),
              image: 'assets/images/abremovebg.png',
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF54748),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Check out',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final Color color;
  final Color textColor;
  final Color buttonColor;
  final Color buttonTextColor;
  final String image;
  const _PromoCard({
    required this.color,
    required this.textColor,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Special Deal For December',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: buttonTextColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 0,
                      ),
                      minimumSize: Size(0, 36),
                    ),
                    onPressed: () {},
                    child: Text('Buy Now'),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            Image.asset(image, width: 80, height: 80),
          ],
        ),
      ),
    );
  }
}
