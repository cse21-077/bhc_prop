import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FaultReportingPage extends StatefulWidget {
  @override
  _FaultReportingPageState createState() => _FaultReportingPageState();
}

class _FaultReportingPageState extends State<FaultReportingPage> {
  String? selectedCategory;
  String? selectedFault;
  TextEditingController plotNumberController = TextEditingController();
  
  final Map<String, List<String>> faultOptions = {
    'Electrical': [
      'Electricity tripping',
      'No power',
      'Electric shock',
      // Add more fault incidents here
    ],
    'Carpentry': [
      'Garage',
      'Windows & frames',
      // Add more fault incidents here
    ],
    // Add more categories and their respective faults here
  };

  void _logFaultIncident(String fault, String plotNumber) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String uid = currentUser.uid;
      try {
        await FirebaseFirestore.instance.collection('fault_reports').add({
          'user_id': uid,
          'category': selectedCategory,
          'fault': fault,
          'plot_number': plotNumber,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Clear form fields and reset state
        setState(() {
          selectedCategory = null;
          selectedFault = null;
          plotNumberController.clear();
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your case has been logged with BHC. You will be assisted within xx days.'),
        ));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error logging incident: $e'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fault Reporting',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Report a Fault',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedCategory,
                hint: Text('Select Fault Category'),
                items: faultOptions.keys.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                    selectedFault = null; // Reset fault selection when category changes
                  });
                },
              ),
              if (selectedCategory != null)
                DropdownButton<String>(
                  value: selectedFault,
                  hint: Text('Select Fault Incident'),
                  items: faultOptions[selectedCategory!]!.map((String fault) {
                    return DropdownMenuItem<String>(
                      value: fault,
                      child: Text(fault),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFault = value;
                    });
                  },
                ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: plotNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Plot Number',
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedFault == null
                    ? null
                    : () {
                        if (plotNumberController.text.isNotEmpty) {
                          _logFaultIncident(selectedFault!, plotNumberController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please enter your plot number.'),
                          ));
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: Size(200, 50), // Set fixed width
                ),
                child: Text(
                  'Log Incident',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
