import 'package:bhc_prop/payment/fee.dart';
import 'package:flutter/material.dart';
import 'package:bhc_prop/core/colors.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IndividualApplicationForm extends StatefulWidget {
  @override
  _IndividualApplicationFormState createState() =>
      _IndividualApplicationFormState();
}

class _IndividualApplicationFormState
    extends State<IndividualApplicationForm> {
  final _formKey = GlobalKey<FormState>();

  // Form fields controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _occupationController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cellphoneController =
      TextEditingController();

  // File variables for uploaded PDFs
  File? applicationFormFile;
  File? affidavitFile;

  // Flag to track if PDFs are uploaded
  bool _pdfsUploaded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Individual Application Form'),
        backgroundColor: bhcyelow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'If you already have a filled application form and affidavit in PDF format, please upload them below. Otherwise, fill out the form.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // File upload buttons
              _buildFileUploadButton('Upload Application Form', (file) {
                setState(() {
                  applicationFormFile = file;
                  _pdfsUploaded = true; // Set flag to true when PDFs are uploaded
                });
              }),
              const SizedBox(height: 10),
              _buildFileUploadButton('Upload Affidavit', (file) {
                setState(() {
                  affidavitFile = file;
                  _pdfsUploaded = true; // Set flag to true when PDFs are uploaded
                });
              }),
              const SizedBox(height: 20),
              // Form fields for manual input
              Text(
                'Or, fill out the form below:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTextFormField(
                _nameController,
                'Full Name',
                'Please enter your full name',
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                _occupationController,
                'Occupation',
                null,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                _emailController,
                'Email',
                'Please enter your email',
                TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              _buildTextFormField(
                _cellphoneController,
                'Cellphone',
                'Please enter your cellphone number',
                TextInputType.phone,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndSubmit,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileUploadButton(
      String label, Function(File?) onFileSelected) {
    return ElevatedButton.icon(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
        if (result != null && result.files.single.path != null) {
          onFileSelected(File(result.files.single.path!));
        }
      },
      icon: Icon(Icons.upload_file),
      label: Text(label),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      String? errorMessage, [TextInputType? keyboardType]) {
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
      enabled: !_pdfsUploaded, // Disable fields if PDFs are uploaded
    );
  }

  void _validateAndSubmit() {
    if (_pdfsUploaded || _formKey.currentState!.validate()) {
      // If PDFs are uploaded or form fields are valid, proceed
      _uploadToFirestore();
      _navigateToPaymentPage();
      _clearForm();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Please either upload both files or fill out the form completely.'),
        ),
      );
    }
  }

  void _uploadToFirestore() async {
    try {
      // Example code to upload files and form data to Firestore
      print('Uploading files and form data to Firestore...');

      // Assuming you have Firebase Storage set up for file uploads
      // Replace with your actual Firestore collection and fields
      await FirebaseFirestore.instance.collection('applications').add({
        'name': _nameController.text,
        'occupation': _occupationController.text,
        'email': _emailController.text,
        'cellphone': _cellphoneController.text,
        'applicationFormUrl': applicationFormFile != null
            ? await _uploadFileToStorage(applicationFormFile!)
            : null, // Upload application form if exists
        'affidavitUrl': affidavitFile != null
            ? await _uploadFileToStorage(affidavitFile!)
            : null, // Upload affidavit if exists
        'timestamp': Timestamp.now(),
      });

      // Show success message after upload
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Files uploaded successfully!'),
          duration: Duration(seconds: 2), // Adjust duration as needed
        ),
      );

      print('Data uploaded successfully!');
    } catch (e) {
      print('Error uploading to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error uploading to Firestore. Please try again later.'),
        ),
      );
    }
  }

  Future<String> _uploadFileToStorage(File file) async {
    // Simulated function to upload file to Firebase Storage
    // Replace with your actual file upload logic
    await Future.delayed(Duration(seconds: 2)); // Simulating upload delay
    return 'https://your-file-url'; // Replace with actual download URL
  }

  void _navigateToPaymentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaymentPage()),
    );
  }

  void _clearForm() {
    _nameController.clear();
    _occupationController.clear();
    _emailController.clear();
    _cellphoneController.clear();
    setState(() {
      applicationFormFile = null;
      affidavitFile = null;
      _pdfsUploaded = false; // Reset PDFs uploaded flag
    });
  }
}
