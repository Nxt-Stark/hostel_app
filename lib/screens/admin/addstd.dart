import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AddPage(),
      ),
    );

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String studentName = '';
  DateTime? _selectedDate;
  String mobileNumber = '';
  String selectedCollege = '';
  String? selectedCourse;
  String parentName = '';
  String parentMobile = '';
  String address = '';
  String roomNumber = '';

  List<bool> inputValidationStatus = List.filled(8, true);

  List<String> getCoursesForCollege(String college) {
    switch (college) {
      case 'Majlis Polytechnic College':
        return [
          'Diploma Automobile Engineering',
          'Diploma Computer Engineering',
          'Diploma Civil Engineering',
          'Diploma Electrical and Electronics Engineering',
          'Diploma Mechanical Engineering',
        ];
      case 'Majlis Arts&Science College':
        return [
          'BA Multimedia',
          'BA Mass Communication & Journalism',
          'BA Visual Communication',
          'BA Functional English',
          'BA Sociology',
          'B Sc Physics',
          'B Sc Chemistry',
          'B Sc Computer Science',
          'Bachelor of Computer Application (BCA)',
          'B Sc Mathematics',
          'B Sc Microbiology',
          'Bachelor of Business Administration (BBA)',
          'B Com. Finance',
          'B Com. Computer Application',
          'B Com. Travel and Tourism',
          'B Com. Co-Operation',
          'BA Graphic Designing and Animation',
          'B.Des(Graphic and Communication Design)',
          'MA English',
          'M Com Finance',
          'M Sc Physics',
          'M Sc Chemistry',
          'M Sc Mathematics',
          'M Sc Microbiology',
          'M Sc Computer Science',
          'MA Sociology',
        ];
      default:
        return [];
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    DateTime tenYearsAgo = currentDate.subtract(Duration(days: 365 * 10));

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? tenYearsAgo,
      firstDate: DateTime(1990),
      lastDate: DateTime(2010),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
          content: const Text(
            "Do you really want to add this student to the database?",
            style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel", style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () async {
                await _saveDataToFirebase();
                Navigator.of(context).pop();
              },
              child: const Text("OK", style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveDataToFirebase() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference students = firestore.collection('YOUR_COLLECTION_NAME');

    await students.add({
      'name': studentName,
      'dob': _selectedDate != null ? DateFormat('dd/MM/yyyy').format(_selectedDate!) : null,
      'mobileNumber': mobileNumber,
      'college': selectedCollege,
      'course': selectedCourse,
      'parentsName': parentName,
      'parentsMobile': parentMobile,
      'address': address,
      'roomNumber': roomNumber,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color(0xFF7364e3),
        title: Text(
          'Add Student Details',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Student Name:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2.0, 4.0, 6.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide.none,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          setState(() {
                            studentName = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter student name",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Date of Birth:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 2.0, 4.0, 6.0),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide.none,
                          ),
                        ),
                        child: Text(
                          _selectedDate != null
                              ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                              : "Select date",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_today),
                      color: Color.fromRGBO(143, 148, 251, 1),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Mobile Number:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2.0, 4.0, 6.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide.none,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          setState(() {
                            mobileNumber = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter mobile number",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "College:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCollege,
                  icon: const Icon(Icons.arrow_downward, color: Color.fromRGBO(143, 148, 251, 1)),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCollege = newValue!;
                      selectedCourse = null;
                    });
                  },
                  items: <String>['Majlis Polytechnic College', 'Majlis Arts&Science College'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Course:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedCourse,
                  icon: const Icon(Icons.arrow_downward, color: Color.fromRGBO(143, 148, 251, 1)),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.transparent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCourse = newValue!;
                    });
                  },
                  items: getCoursesForCollege(selectedCollege).map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Parent's Name:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2.0, 4.0, 6.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide.none,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          setState(() {
                            parentName = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter parent's name",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Parent's Mobile Number:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2.0, 4.0, 6.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide.none,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          setState(() {
                            parentMobile = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter parent's mobile number",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Address:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2.0, 4.0, 6.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide.none,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          setState(() {
                            address = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter address",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Room Number:",
                style: GoogleFonts.poppins(
                  color: Colors.grey[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Color.fromRGBO(143, 148, 251, 1),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(143, 148, 251, .2),
                      blurRadius: 20.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 2.0, 4.0, 6.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide.none,
                        ),
                      ),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        onChanged: (value) {
                          setState(() {
                            roomNumber = value;
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter room number",
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    bool isValid = true;
                    for (int i = 0; i < inputValidationStatus.length; i++) {
                      if (!inputValidationStatus[i]) {
                        isValid = false;
                        break;
                      }
                    }

                    if (isValid) {
                      _showConfirmationDialog(context);
                    } else {
                      // Show a message or handle invalid input case
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF7364e3),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
