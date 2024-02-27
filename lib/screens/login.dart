import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: Image.asset('assets/images/light-2.png'),
                  ),
                  Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: Image.asset('assets/images/clock.png'),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Enter your mobile:",
                    style: GoogleFonts.poppins(
                      color: Colors.grey[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                          padding: EdgeInsets.fromLTRB(20, 8.0, 8.0, 8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide.none,
                            ),
                          ),
                          child: TextField(
                            controller: phoneNumberController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                isButtonEnabled = value.length == 10;
                              });
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,10}$')),
                            ],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter 10-digit number",
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey[700],
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
                  GestureDetector(
                    onTap: isButtonEnabled
                        ? () async {
                            String phoneNumber = phoneNumberController.text;
                            bool otpSent = await sendOTP(context, phoneNumber);
                            if (otpSent) {
                              // If OTP sent successfully, show alert and navigate to OTP verification page
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Done",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    content: Text(
                                      "OTP Sent Successfully!",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          // Navigate to OTP verification page
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => OtpScreen()),
                                          );
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              // If OTP not sent, show alert
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      "Error",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    content: Text(
                                      "Failed to send OTP!",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    contentPadding: EdgeInsets.fromLTRB(25, 10, 10, 10),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          }
                        : null,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: isButtonEnabled ? Color(0xFF8E94FF) : Color(0xFF8E94FF).withOpacity(0.7),
                      ),
                      child: Center(
                        child: Text(
                          "Next",
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
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
              child: Text(
                "Made with love by Hadi",
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Future<bool> sendOTP(BuildContext context, String phoneNumber) async {
  // Send OTP logic goes here, using Firebase Authentication or any other method
  // In this example, we're just simulating a delay of 5 seconds and returning true to indicate success

  // Show loading alert
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text(
                "Sending OTP...",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

  // Simulate a delay of 5 seconds
  await Future.delayed(Duration(seconds: 5));

  // Dismiss loading alert
  Navigator.of(context).pop();

  // Simulate OTP sending success
  return true;
}





class OtpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: Image.asset('assets/images/light-2.png'),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: Image.asset('assets/images/clock.png'),
                        ),
                        Positioned(
                          child: Container(
                            margin: EdgeInsets.only(top: 50),
                            child: Center(
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Enter the OTP:",
                          style: GoogleFonts.poppins(
                            color: Colors.grey[800],
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            buildOtpTextField(0),
                            SizedBox(width: 10), // Adjust the space between input fields
                            buildOtpTextField(1),
                            SizedBox(width: 10), // Adjust the space between input fields
                            buildOtpTextField(2),
                            SizedBox(width: 10), // Adjust the space between input fields
                            buildOtpTextField(3),
                            SizedBox(width: 10), // Adjust the space between input fields
                            buildOtpTextField(4),
                            SizedBox(width: 10), // Adjust the space between input fields
                            buildOtpTextField(5),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Handle OTP verification here
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromRGBO(142, 148, 255, 1),
                            ),
                            child: Center(
                              child: Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        "Made with love by Hadil",
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 30,
            child: GestureDetector(
              onTap: () {
                // Navigate to previous screen
                Navigator.pop(context);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.3),
                ),
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOtpTextField(int index) {
  return Container(
    width: 60,
    height: 70, // Adjust the width as needed
    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
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
    child: TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]{0,1}$')),
      ],
      textAlign: TextAlign.center,
      cursorColor: Colors.transparent,
      style: TextStyle(
        color: Colors.black,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "-",
        hintStyle: TextStyle(
          color: const Color.fromARGB(66, 97, 97, 97),
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

}
