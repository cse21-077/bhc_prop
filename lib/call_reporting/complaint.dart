import 'package:flutter/material.dart';

class ComplaintFormPage extends StatefulWidget {
  @override
  _ComplaintFormPageState createState() => _ComplaintFormPageState();
}

class _ComplaintFormPageState extends State<ComplaintFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _complaintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _complaintController,
                decoration: InputDecoration(
                  labelText: 'Enter your complaint',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a complaint';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitComplaint(_complaintController.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: Text('Submit Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitComplaint(String complaint) {
    // You can replace this with actual complaint submission logic or backend call
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Your complaint has been submitted. You will be contacted soon.'),
    ));
  }
}
