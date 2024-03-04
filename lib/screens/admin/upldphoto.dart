import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  final TextEditingController _studentIdController = TextEditingController();
  File? _imageFile; // Make _imageFile nullable
  bool _imageSelected = false;

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final decodedImage =
          await decodeImageFromList(imageFile.readAsBytesSync());

      if (decodedImage.width == decodedImage.height) {
        setState(() {
          _imageFile = imageFile;
          _imageSelected = true; // Set imageSelected to true
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please select a square image.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('No image selected.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _submitData() async {
    if (_imageFile != null && _studentIdController.text.isNotEmpty) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20.0),
                  Text('Uploading...'),
                ],
              ),
            ),
          );
        },
      );

      try {
        // Upload image to Firebase Storage
        final Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('student_images')
            .child('${_studentIdController.text}.jpg');
        await storageRef.putFile(_imageFile!); // Use ! to assert non-null
        final String downloadUrl = await storageRef.getDownloadURL();

        // Save image URL to Firestore
        await FirebaseFirestore.instance
            .collection('student')
            .doc(_studentIdController.text)
            .set({
          'imageUrl': downloadUrl,
        });

        // Close loading dialog
        Navigator.pop(context);

        // Show success dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Data submitted successfully!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Clear text field and image file
        _studentIdController.clear();
        setState(() {
          _imageFile = null;
          _imageSelected = false; // Reset _imageSelected
        });
      } catch (error) {
        // Close loading dialog
        Navigator.pop(context);

        // Show error dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Failed to submit data.$error'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );

        // Clear image file
        setState(() {
          _imageFile = null;
          _imageSelected = false; // Reset _imageSelected
        });
      }
    } else {
      // Show error dialog if image or student ID is empty
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please select an image and enter a student ID.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F0F0),
        toolbarHeight: 80.0,
        leading: IconButton(
          padding: EdgeInsets.all(20.0),
          icon: Icon(
            Icons.navigate_before_rounded, // Change to navigate_before
            size: 35, // Adjust the size of the icon
            color: Color(0xff7364e3), // Adjust the color of the icon
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate to the previous page
          },
        ),
        title: Text(
          'Upload Photo',
          style: GoogleFonts.poppins(
            fontSize: 22, // Adjust the font size
            fontWeight: FontWeight.bold, // Adjust the font weight
            color: Color(0xff7364e3), // Adjust the text color
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(40, 40, 40, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2), // Set shadow color
                      spreadRadius: 3, // Set spread radius
                      blurRadius: 10, // Set blur radius
                      offset: Offset(0, 3), // Set offset
                    ),
                  ],
                ),
                child: TextField(
                  controller: _studentIdController,
    style: GoogleFonts.poppins(
      // Replace 'YourFontFamily' with your desired font family
      fontWeight: FontWeight.bold,
      color: Color(0xFF7364E3), // Adjust the text color
    ),
                  decoration: InputDecoration(
                    labelText: 'Enter Student ID',
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ), // Hint text style
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              ElevatedButton.icon(
                onPressed: _uploadImage,
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff7364e3), // Background color
                  onPrimary: Colors.white, // Text color
                  minimumSize: Size(150, 50), // Adjust the width and height
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10), // Border radius
                  ),
                ),
                icon: Icon(
                  Icons.cloud_upload, // Your icon data
                  size: 24, // Adjust the icon size
                  color: Colors.white, // Adjust the icon color
                ),
                label: Text(
                  'Upload File',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16, // Adjust the font size
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              _imageSelected
                  ? Column(
                      children: [
                        Container(
                          height: 500,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _imageFile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: _submitData,
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff7364e3), // Background color
                            onPrimary: Colors.white, // Text color
                            minimumSize:
                                Size(double.infinity, 50), // Adjust the width and height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  10), // Border radius
                            ),
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16, // Adjust the font size
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UploadPhotoPage(),
  ));
}
