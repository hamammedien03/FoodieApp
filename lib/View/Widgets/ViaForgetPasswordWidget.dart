import 'package:flutter/material.dart';
import 'package:foodie/Controller/FirebaseController.dart';
import 'package:foodie/Model/Colors.dart';

class ViaForgetPasswordWidget extends StatefulWidget {
  const ViaForgetPasswordWidget({super.key});

  @override
  State<ViaForgetPasswordWidget> createState() =>
      _ViaForgetPasswordWidgetState();
}

class _ViaForgetPasswordWidgetState extends State<ViaForgetPasswordWidget> {
  int? selectedOption;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  bool get _isContinueEnabled {
    if (selectedOption == 0) {
      return _phoneController.text.trim().isNotEmpty;
    } else if (selectedOption == 1) {
      return _emailController.text.trim().isNotEmpty;
    }
    return false;
  }

  void _onChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.88,
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Forget Password?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'Select which contact details should we use to reset your password',
              style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // خيار SMS
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 0;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: selectedOption == 0
                      ? ColorsApp.primary
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.sms,
                    color: selectedOption == 0 ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    'Via sms',
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedOption == 0 ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedOption = 0;
                    });
                  },
                ),
              ),
            ),
            // خيار Email
            GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = 1;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: selectedOption == 1
                      ? ColorsApp.primary
                      : Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: selectedOption == 1 ? Colors.white : Colors.black,
                  ),
                  title: Text(
                    'Via Email',
                    style: TextStyle(
                      fontSize: 16,
                      color: selectedOption == 1 ? Colors.white : Colors.black,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      selectedOption = 1;
                    });
                  },
                ),
              ),
            ),
            Visibility(
              visible: selectedOption != null,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: selectedOption == 0
                    ? TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (_) => _onChanged(),
                      )
                    : selectedOption == 1
                    ? TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (_) => _onChanged(),
                      )
                    : SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _isContinueEnabled
                  ? () async {
                      if (selectedOption == 1) {
                        await Firebasecontroller.resetPassword(
                          email: _emailController.text.trim(),
                          context: context,
                        );
                        // الانتقال مباشرة إلى صفحة النجاح
                        Navigator.pushReplacementNamed(
                          context,
                          '/successresetpasswordScreen',
                        );
                      } else if (selectedOption == 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Resetting your password via phone is currently not supported.',
                            ),
                          ),
                        );
                      }
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _isContinueEnabled
                    ? ColorsApp.primary
                    : Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
