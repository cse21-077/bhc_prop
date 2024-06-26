import 'package:flutter/material.dart';

class EnquiryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('General Enquiries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: Text('BHC Products'),
              onTap: () {
                // Display BHC products
                _showEnquiryDetails(
                  context,
                  'BHC Products',
                  'BHC provides a variety of housing options including apartments, townhouses, and residential plots. '
                  'For more detailed information, please visit our website or contact our offices.',
                );
              },
            ),
            Divider(), // Add a divider for visual separation
            ListTile(
              title: Text('Application Procedures'),
              onTap: () {
                // Display application procedures
                _showEnquiryDetails(
                  context,
                  'Application Procedures',
                  'To apply for housing with BHC, please visit our nearest office with the required documents '
                  'including proof of income and identification. Our staff will assist you with the application process.',
                );
              },
            ),
            // Add more enquiry options here
          ],
        ),
      ),
    );
  }

  void _showEnquiryDetails(BuildContext context, String title, String details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(details),
          actions: <Widget>[
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
