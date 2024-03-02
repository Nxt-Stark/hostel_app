import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  @override
  _AddStudentState createState() => _AddStudentState();
}

class _AddStudentState extends State<AddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _parentNameController = TextEditingController();
  final TextEditingController _parentMobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();

  late File _imageFile = File(''); // Modified line

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<String?> _uploadImageToTelegraph(File imageFile) async {
    final url = Uri.parse('https://telegra.ph/upload');
    final request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final body = await response.stream.bytesToString();
    final imageUrl = 'https://telegra.ph${body.substring(body.indexOf('<img src="') + 10, body.indexOf('"', body.indexOf('<img src="') + 10))}';
    return imageUrl;
  }

  Future<String> _getNewStudentId() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance.collection('student').get();

    final int count = querySnapshot.docs.length + 1;

    return 'STU$count';
  }

  Future<void> _uploadStudentDetails() async {
    final String studentId = await _getNewStudentId();

    // Upload image to telegra.ph
    final imageUrl = await _uploadImageToTelegraph(_imageFile);

    // Save student details to Firestore
    await FirebaseFirestore.instance.collection('student').doc(studentId).set({
      'studentId': studentId,
      'name': _nameController.text.trim(),
      'dob': _dobController.text.trim(),
      'mobile': _mobileController.text.trim(),
      'college': _collegeController.text.trim(),
      'course': _courseController.text.trim(),
      'parentName': _parentNameController.text.trim(),
      'parentMobile': _parentMobileController.text.trim(),
      'address': _addressController.text.trim(),
      'roomNumber': _roomController.text.trim(),
      'photoUrl': imageUrl, // Save image URL to Firestore
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Student details uploaded successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: _mobileController,
              decoration: InputDecoration(labelText: 'Mobile Number'),
            ),
            TextField(
              controller: _collegeController,
              decoration: InputDecoration(labelText: 'College'),
            ),
            TextField(
              controller: _courseController,
              decoration: InputDecoration(labelText: 'Course'),
            ),
            TextField(
              controller: _parentNameController,
              decoration: InputDecoration(labelText: "Parent's Name"),
            ),
            TextField(
              controller: _parentMobileController,
              decoration: InputDecoration(labelText: "Parent's Mobile Number"),
            ),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _roomController,
              decoration: InputDecoration(labelText: 'Room Number'),
            ),
            SizedBox(height: 20),
            _imageFile.path.isNotEmpty
                ? Image.file(
                    _imageFile,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : SizedBox(height: 200, child: Placeholder()), // Placeholder for empty image
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Upload Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _uploadStudentDetails,
              child: Text('Upload Student Details'),
            ),
          ],
        ),
      ),
    );
  }
}

