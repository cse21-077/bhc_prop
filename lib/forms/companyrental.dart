import 'package:bhc_prop/payment/fee.dart';
import 'package:flutter/material.dart';
import 'package:bhc_prop/core/colors.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class CompanyApplicationForm extends StatefulWidget {
  const CompanyApplicationForm({super.key});

  @override
  _CompanyApplicationFormState createState() => _CompanyApplicationFormState();
}

class _CompanyApplicationFormState extends State<CompanyApplicationForm> {
  final _formKey = GlobalKey<FormState>();

  // Add form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _registrationNumberController = TextEditingController();
  // (Other controllers remain the same)
  
  File? applicationFormFile;
  File? affidavitFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Application Form'),
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
              _buildFileUploadButton('Upload Application Form', (file) {
                setState(() {
                  applicationFormFile = file;
                });
              }),
              const SizedBox(height: 10),
              _buildFileUploadButton('Upload Affidavit', (file) {
                setState(() {
                  affidavitFile = file;
                });
              }),
              const SizedBox(height: 20),
              Text(
                'Or, fill out the form below:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Form fields (remain the same)
              _buildTextFormField(_nameController, 'Name of Company', 'Please enter the company name'),
              _buildTextFormField(_registrationNumberController, 'Registration Number', 'Please enter the registration number'),
              // (Other form fields remain the same)
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

  Widget _buildFileUploadButton(String label, Function(File?) onFileSelected) {
    return ElevatedButton.icon(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
        if (result != null && result.files.single.path != null) {
          onFileSelected(File(result.files.single.path!));
        }
      },
      icon: Icon(Icons.upload_file),
      label: Text(label),
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

  void _validateAndSubmit() {
  if (applicationFormFile != null && affidavitFile != null) {
    // Process uploaded files
    _navigateToPaymentPage();
  } else if (_formKey.currentState!.validate()) {
    // Process form data
    _navigateToPaymentPage();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please either upload both files or fill out the form completely.')),
    );
  }
}

void _navigateToPaymentPage() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PaymentPage()),
  );
}

}
