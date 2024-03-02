import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewStudentDetails extends StatefulWidget {
  @override
  _ViewStudentDetailsState createState() => _ViewStudentDetailsState();
}

class _ViewStudentDetailsState extends State<ViewStudentDetails> {
  String _searchedStudentId = '';
  String _studentName = '';
  String _studentId = '';
  String _roomNumber = '';
  String _phoneNumber = '';
  String _imageUrl = '';
  bool _isLoading = false;

  final TextEditingController _searchController = TextEditingController();

  Future<void> _searchStudent() async {
    setState(() {
      _isLoading = true;
    });

    final QuerySnapshot<Map<String, dynamic>> queryResult =
        await FirebaseFirestore.instance
            .collection('student')
            .where('studentId', isEqualTo: _searchedStudentId)
            .get();

    if (queryResult.docs.isNotEmpty) {
      final data = queryResult.docs.first.data();
      setState(() {
        _studentName = data['studentName'] ?? '';
        _studentId = data['studentId'] ?? '';
        _roomNumber = data['roomNumber'] ?? '';
        _phoneNumber = data['phoneNumber'] ?? '';
        _imageUrl = data['imageUrl'] ?? '';
        _isLoading = false;
      });
    } else {
      setState(() {
        _studentName = '';
        _studentId = '';
        _roomNumber = '';
        _phoneNumber = '';
        _imageUrl = '';
        _isLoading = false;
      });
    }
  }

  void _showFullSizeImage() {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(_imageUrl),
        ),
      ),
    );
  }

void _editStudentDetails() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EditStudentDetails(
        studentId: _studentId,
        studentName: _studentName,
        roomNumber: _roomNumber,
        phoneNumber: _phoneNumber,
        imageUrl: _imageUrl,
      ),
    ),
  ).then((value) {
    if (value != null && value is Map<String, dynamic>) {
      setState(() {
        _studentName = value['studentName'] ?? '';
        _roomNumber = value['roomNumber'] ?? '';
        _phoneNumber = value['phoneNumber'] ?? '';
        _imageUrl = value['imageUrl'] ?? '';
      });
      print('Updating student with ID: $_studentId');
      // Check if the document exists before updating
      FirebaseFirestore.instance
          .collection('student')
          .doc(_studentId)
          .get()
          .then((docSnapshot) {
        if (docSnapshot.exists) {
          print('Document exists. Updating details...');
          FirebaseFirestore.instance
              .collection('student')
              .doc(_studentId)
              .update({
            'studentName': _studentName,
            'roomNumber': _roomNumber,
            'phoneNumber': _phoneNumber,
            'imageUrl': _imageUrl,
          }).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Student details updated successfully'),
              ),
            );
          }).catchError((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update student details: $error'),
              ),
            );
          });
        } else {
          print('Document does not exist.');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Student document does not exist'),
            ),
          );
        }
      });
    }
  });
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by Student ID',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _searchedStudentId = _searchController.text;
                            _searchStudent();
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : _studentName.isNotEmpty
                          ? Center(
                              child: GestureDetector(
                                onTap: _showFullSizeImage,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(_imageUrl),
                                ),
                              ),
                            )
                          : SizedBox.shrink(),
                  SizedBox(height: 20),
                  _isLoading
                      ? SizedBox.shrink()
                      : _studentName.isNotEmpty
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Name: $_studentName',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: _editStudentDetails,
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                  SizedBox(height: 10),
                  _isLoading
                      ? SizedBox.shrink()
                      : _studentName.isNotEmpty
                          ? Text(
                              'Student ID: $_studentId',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            )
                          : SizedBox.shrink(),
                  SizedBox(height: 10),
                  _isLoading
                      ? SizedBox.shrink()
                      : _studentName.isNotEmpty
                          ? Text(
                              'Room Number: $_roomNumber',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            )
                          : SizedBox.shrink(),
                  SizedBox(height: 10),
                  _isLoading
                      ? SizedBox.shrink()
                      : _studentName.isNotEmpty
                          ? Text(
                              'Phone Number: $_phoneNumber',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                              ),
                            )
                          : SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditStudentDetails extends StatefulWidget {
  final String studentId;
  final String studentName;
  final String roomNumber;
  final String phoneNumber;
  final String imageUrl;

  const EditStudentDetails({
    required this.studentId,
    required this.studentName,
    required this.roomNumber,
    required this.phoneNumber,
    required this.imageUrl,
  });

  @override
  _EditStudentDetailsState createState() => _EditStudentDetailsState();
}

class _EditStudentDetailsState extends State<EditStudentDetails> {
  late TextEditingController _nameController;
  late TextEditingController _roomController;
  late TextEditingController _phoneController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.studentName);
    _roomController = TextEditingController(text: widget.roomNumber);
    _phoneController = TextEditingController(text: widget.phoneNumber);
    _imageController = TextEditingController(text: widget.imageUrl);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roomController.dispose();
    _phoneController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Student Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Student Name'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _roomController,
              decoration: InputDecoration(labelText: 'Room Number'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    'studentName': _nameController.text.trim(),
                    'roomNumber': _roomController.text.trim(),
                    'phoneNumber': _phoneController.text.trim(),
                    'imageUrl': _imageController.text.trim(),
                  },
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
