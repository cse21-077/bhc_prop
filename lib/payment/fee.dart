import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();

  // Card details fields
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Colors.yellow[800], // Adjust to your brand color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextFormField(_cardNumberController, 'Card Number', 'Enter your card number', TextInputType.number),
              const SizedBox(height: 20),
              _buildTextFormField(_expiryDateController, 'Expiry Date (MM/YY)', 'Enter expiry date', TextInputType.datetime),
              const SizedBox(height: 20),
              _buildTextFormField(_cvvController, 'CVV', 'Enter CVV', TextInputType.number),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _processPayment,
                child: Text('Pay'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label, String? errorMessage, [TextInputType? keyboardType]) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: keyboardType,
      validator: (value) {
        if (errorMessage != null && (value == null || value.isEmpty)) {
          return errorMessage;
        }
        return null;
      },
    );
  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      // Simulate a successful payment
      _showPaymentSuccessDialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
    }
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Your payment has been processed successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                _showApplicationReceivedDialog();
              },
            ),
          ],
        );
      },
    );
  }

  void _showApplicationReceivedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Application Received'),
          content: Text('Your application has been received. You will be contacted shortly.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Pop the payment page
                Navigator.of(context).pop(); // Pop the application form page
              },
            ),
          ],
        );
      },
    );
  }
}
