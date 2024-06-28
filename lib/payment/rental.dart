import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bhc_prop/core/colors.dart';

class RentalPaymentPage extends StatefulWidget {
  @override
  _RentalPaymentPageState createState() => _RentalPaymentPageState();
}

class _RentalPaymentPageState extends State<RentalPaymentPage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String name = user.displayName ?? '';
      String email = user.email ?? '';
      String username = name.isNotEmpty ? name : email.split('@')[0];

      setState(() {
        userName = username;
      });
    } else {
      setState(() {
        userName = 'User';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rental Payment'),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              _showHistoryDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildUserInfoCard(),
            SizedBox(height: 20),
            _buildCreditCardDetailsCard(),
            SizedBox(height: 20),
            _buildRentInfo(),
            SizedBox(height: 20),
            _buildPayButtons(context),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name: $userName',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Plot Number: 18795',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              Text(
                'Location: BHC Extension 7',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreditCardDetailsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Credit Card Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.credit_card),
                Text(
                  'Card Number: **** **** **** 1234',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.calendar_today),
                Text(
                  'Expiry: 12/24',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRentInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Rent:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          '3400',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildPayButtons(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: () {
            _showPaymentDialog(context, 'Pay for 1 month');
          },
          child: Text(
            'Pay for 1 month',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 7, 196, 117),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            _showPaymentDialog(context, 'Pay for 3 months');
          },
          child: Text(
            'Pay for 3 months',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            _showPaymentDialog(context, 'Pay for 6 months');
          },
          child: Text(
            'Pay for 6 months',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
        SizedBox(height: 12),
        ElevatedButton(
          onPressed: () {
            _showPaymentDialog(context, 'Pay for 12 months');
          },
          child: Text(
            'Pay for 12 months',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            padding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ],
    );
  }

  void _showPaymentDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Procedure'),
          content: Text('Payment procedure for $message is being processed.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showHistoryDialog(BuildContext context) {
    List<String> historyItems = [
      'Paid rent of 3400 on 2023-01-01',
      'Paid rent of 3400 on 2023-02-01',
      'Paid rent of 3400 on 2023-03-01',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: historyItems.map((item) => Text(item)).toList(),
          ),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
