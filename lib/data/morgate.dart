import 'package:flutter/material.dart';
import 'dart:math';

class MortgageCalculatorPage extends StatefulWidget {
  @override
  _MortgageCalculatorPageState createState() => _MortgageCalculatorPageState();
}

class _MortgageCalculatorPageState extends State<MortgageCalculatorPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers to get the user input
  final TextEditingController _propertyPriceController = TextEditingController();
  final TextEditingController _downPaymentController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _loanTermController = TextEditingController();

  double _monthlyPayment = 0.0;

  // Method to calculate mortgage
  void _calculateMortgage() {
    final double propertyPrice = double.tryParse(_propertyPriceController.text) ?? 0.0;
    final double downPayment = double.tryParse(_downPaymentController.text) ?? 0.0;
    final double interestRate = double.tryParse(_interestRateController.text) ?? 0.0;
    final int loanTerm = int.tryParse(_loanTermController.text) ?? 0;

    if (propertyPrice > 0 && downPayment >= 0 && interestRate > 0 && loanTerm > 0) {
      final double principal = propertyPrice - downPayment;
      final double monthlyInterestRate = interestRate / 100 / 12;
      final int numberOfPayments = loanTerm * 12;

      _monthlyPayment = principal *
          (monthlyInterestRate * pow((1 + monthlyInterestRate), numberOfPayments)) /
          (pow((1 + monthlyInterestRate), numberOfPayments) - 1);

      setState(() {});
    } else {
      // Invalid input handling
      _showErrorDialog(context, 'Please enter valid values for all fields.');
    }
  }

  // Method to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Input Error'),
          content: Text(message),
          actions: <Widget>[
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mortgage Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _propertyPriceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Property Price',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the property price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _downPaymentController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Down Payment',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the down payment';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _interestRateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Interest Rate (%)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the interest rate';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _loanTermController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Loan Term (years)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the loan term';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _calculateMortgage();
                  }
                },
                child: Text('Calculate'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                'Monthly Payment: \P${_monthlyPayment.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

