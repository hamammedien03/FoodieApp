import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
        title: Text(
          'Chat',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _ChatItem(
            name: 'Naxient',
            message: 'Your order just arrived!',
            time: '18:00',
            image: 'assets/images/user1.png',
          ),
          _ChatItem(
            name: 'hawkins',
            message: 'Your order just arrived!',
            time: '16:00',
            image: 'assets/images/user2.png',
          ),
          _ChatItem(
            name: 'leslie Alexander',
            message: 'Your order just arrived!',
            time: '20:01',
            image: 'assets/images/user3.png',
          ),
        ],
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String image;
  const _ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 28, backgroundImage: AssetImage(image)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(message, style: TextStyle(color: Colors.grey[700])),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}
