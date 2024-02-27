import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaveRequestScreen extends StatefulWidget {
  @override
  _LeaveRequestScreenState createState() => _LeaveRequestScreenState();
}

class _LeaveRequestScreenState extends State<LeaveRequestScreen> {
  String _selectedLeaveType = 'Vacation';
  DateTime? _selectedStartDate = DateTime.now();
  DateTime? _selectedEndDate = DateTime.now();
  String _leaveReason = '';

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedStartDate)
      setState(() {
        _selectedStartDate = picked;
      });
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? DateTime.now(),
      firstDate: _selectedStartDate ?? DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedEndDate)
      setState(() {
        _selectedEndDate = picked;
      });
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
          'Leave Request',
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
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 10), // Adjust margin as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Leave Type',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7364e3),
                      ),
                    ),
                    SizedBox(height: 20), // Add spacing between heading and dropdown
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
                        border: Border.all(color: Color.fromARGB(255, 115, 100, 227)), // Add border color
                      ),
                      child: DropdownButtonFormField(
                        value: _selectedLeaveType,
                        items: ['Vacation', 'Sick Leave', 'Maternity Leave', 'Paternity Leave']
                            .map((leaveType) => DropdownMenuItem(
                              child: Text(
                                leaveType,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff7364e3),
                                  fontSize: 18,
                                ),
                              ),
                              value: leaveType,
                            ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedLeaveType = value!;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Adjust padding
                          border: InputBorder.none, // Remove input border
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start Date',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7364e3),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
                            border: Border.all(color: Color.fromARGB(255, 115, 100, 227)), // Add border color
                          ),
                          child: TextFormField(
                            controller: TextEditingController(text: '${_selectedStartDate?.day}/${_selectedStartDate?.month}/${_selectedStartDate?.year}'),
                            onTap: () => _selectStartDate(context),
                            readOnly: true,
                            style: GoogleFonts.poppins(color: Color(0xff7364e3)), // Set text color
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Adjust padding
                              border: InputBorder.none, // Remove input border
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'End Date',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff7364e3),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
                            border: Border.all(color: Color.fromARGB(255, 115, 100, 227)), // Add border color
                          ),
                          child: TextFormField(
                            controller: TextEditingController(text: '${_selectedEndDate?.day}/${_selectedEndDate?.month}/${_selectedEndDate?.year}'),
                            onTap: () => _selectEndDate(context),
                            readOnly: true,
                            style: GoogleFonts.poppins(color: Color(0xff7364e3)), // Set text color
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Adjust padding
                              border: InputBorder.none, // Remove input border
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(bottom: 10), // Adjust margin as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for Leave',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff7364e3),
                      ),
                    ),
                    SizedBox(height: 20), // Add spacing between heading and text field
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8), // Adjust border radius as needed
                        border: Border.all(color: Color.fromARGB(255, 115, 100, 227)), // Add border color
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            _leaveReason = value;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20), // Adjust padding
                          border: InputBorder.none, // Remove input border
                        ),
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _leaveReason.isEmpty ? null : () {
                  // Handle submitting leave request
                  // This is just a placeholder
                  print('Leave Type: $_selectedLeaveType');
                  print('Start Date: $_selectedStartDate');
                  print('End Date: $_selectedEndDate');
                  print('Reason: $_leaveReason');
                },
                child: Text('Submit',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff7364e3), // Background color
                  textStyle: GoogleFonts.poppins(fontSize: 18), // Text style
                  padding: EdgeInsets.symmetric(vertical: 14), // Button padding
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Button border radius
                ),
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true, // Enable resizing to avoid bottom inset
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LeaveRequestScreen(),
  ));
}
