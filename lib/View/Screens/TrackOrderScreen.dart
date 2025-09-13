import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timelines_plus/timelines_plus.dart';

class TrackOrderScreen extends StatefulWidget {
  final Map<String, dynamic> order;
  final String docId;
  const TrackOrderScreen({super.key, required this.order, required this.docId});

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  String status = '';

  @override
  void initState() {
    super.initState();
    _listenOrderStatus();
  }

  void _listenOrderStatus() {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.docId)
        .snapshots()
        .listen((doc) {
          if (doc.exists && doc.data() != null) {
            setState(() {
              status = doc.data()!['status'] ?? 'Confirmed';
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Track order', style: TextStyle(color: Colors.black)),
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order ID : ${order['orderId'] ?? ''}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text('Today', style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 24),
                FixedTimeline.tileBuilder(
                  theme: TimelineThemeData(
                    nodePosition: 0.2,
                    indicatorTheme: IndicatorThemeData(size: 24),
                    connectorTheme: ConnectorThemeData(
                      thickness: 2,
                      color: Colors.pinkAccent,
                    ),
                  ),
                  builder: TimelineTileBuilder.connected(
                    connectionDirection: ConnectionDirection.before,
                    itemCount: 4,
                    contentsBuilder: (context, index) {
                      final times = [
                        '04:30pm',
                        '04:38pm',
                        '04:42pm',
                        '04:46pm',
                      ];
                      final labels = [
                        'Confirmed',
                        'Precessing',
                        'On the way',
                        'Deliverred',
                      ];
                      final isActive = _isActive(labels[index]);
                      final isCurrent = status == labels[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Text(
                              times[index],
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              labels[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isCurrent
                                    ? Colors.black
                                    : (isActive ? Colors.black : Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    indicatorBuilder: (context, index) {
                      final labels = [
                        'Confirmed',
                        'Precessing',
                        'On the way',
                        'Deliverred',
                      ];
                      final isActive = _isActive(labels[index]);
                      return DotIndicator(
                        color: isActive ? Colors.pinkAccent : Colors.grey[300],
                      );
                    },
                    connectorBuilder: (context, index, type) {
                      final labels = [
                        'Confirmed',
                        'Precessing',
                        'On the way',
                        'Deliverred',
                      ];
                      final isActive =
                          index < 3 && _isActive(labels[index + 1]);
                      return SolidLineConnector(
                        color: isActive ? Colors.pinkAccent : Colors.grey[300],
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                const Center(
                  child: Text(
                    'Order Track',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.pink,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.yellow[700],
                      radius: 28,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/deliveryman.png',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: const Text(
                      'Mr Kemplas',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('25 minutes on the way'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/call-ringing');
                    },
                    child: const Text(
                      'Call',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _isActive(String label) {
    final order = ['Confirmed', 'Precessing', 'On the way', 'Deliverred'];
    final currentIndex = order.indexOf(status);
    final labelIndex = order.indexOf(label);
    return labelIndex <= currentIndex;
  }
}
