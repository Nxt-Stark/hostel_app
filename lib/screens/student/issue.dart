import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_app/screens/student.dart';

class ReportIssueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Container(
            child: AppBar(
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
                  _onBackPressed(context);
                },
              ),
              title: Text(
                'Report an Issue',
                style: GoogleFonts.poppins(
                  fontSize: 22, // Adjust the font size
                  fontWeight: FontWeight.bold, // Adjust the font weight
                  color: Color(0xff7364e3), // Adjust the text color
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 40, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What issue are you facing?',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff7364e3),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Describe the issue...',
                    contentPadding: EdgeInsets.all(20.0),
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xB97364E3),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                SizedBox(height: 40),
                Text(
                  'Additional Details (Optional)',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff7364e3),
                  ),
                ),
                SizedBox(height: 30),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Any additional details...',
                    contentPadding: EdgeInsets.all(20.0),
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xB97364E3),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 40),
                SizedBox(
                  width: double.infinity, // Make button width equal to page width
                  child: ElevatedButton(
                    onPressed: () {
                      // Logic to submit the issue
                      // You can add your logic here to submit the issue
                      // For example, sending it to a server or storing it locally
                      // This is just a placeholder
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Issue reported!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff7364e3), // Background color
                      onPrimary: Colors.white, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Border radius
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24), // Button padding
                    ),
                    child: Text(
                      'Submit Issue',
                      style: GoogleFonts.poppins(
                          fontSize: 14, // Text size
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
        ),),
        content: Text('Do you want to leave without submitting the issue?',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
        ),),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
           onPressed: () {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );
},

            child: Text('Yes'),
          ),
        ],
      ),
    );
    return result ?? false; // Return false if result is null
  }


}

void main() {
  runApp(MaterialApp(
    home: ReportIssueScreen(),
  ));
}
