import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_app/screens/addstd.dart';
import 'package:hostel_app/screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(HomePage());
}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String userName = "Hadil";
  String profilePhotoUrl = "assets/images/profile_photo.jpg";

  TextEditingController adminPasswordController = TextEditingController();
  String adminPassword = "admin123"; // Replace with your actual admin password

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdminLogin() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Admin Login"),
          content: Column(
            children: [
              TextField(
                controller: adminPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Enter Admin Password"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                if (adminPasswordController.text == adminPassword) {
                  Navigator.pop(context); // Close the dialog
                  _navigateToAdminScreen();
                } else {
                  // Show error message or handle incorrect password
                }
              },
              child: Text("Login"),
            ),
          ],
        );
      },
    );
  }

  void _navigateToAdminScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminHomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
  toolbarHeight: 80.0,
  backgroundColor: Color(0xFF7364e3),
  elevation: 0,
  shape: ContinuousRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0),
    ),
  ),
  leading: Padding(
    padding: const EdgeInsets.only(left: 18.0,),
    child: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: Icon(Icons.sort, color: Color.fromARGB(255, 255, 255, 255), size: 40),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
  ),
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 30.0, ),
      child: ElevatedButton(
        onPressed: _onAdminLogin,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          elevation: 0,
        ),
        child: Text(
          'Admin',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(right: 30.0,),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Color.fromARGB(255, 255, 255, 255), width: 2),
        ),
        child: CircleAvatar(
          backgroundImage: AssetImage(profilePhotoUrl),
          radius: 20,
        ),
      ),
    ),
  ],
),

      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // art.png at the back
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/art.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Other elements
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                stops: [0.25, 0.9],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CustomPaint(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 150, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'HI, ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff7364e3),
                                  ),
                                ),
                                Text(
                                  userName + ' :)',
                                  style: GoogleFonts.poppins(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff7364e3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'You have 0 new notification(s)',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff7364e3),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
  width: 600, // Set your desired width
  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
  decoration: BoxDecoration(
    color: Color(0xff7364e3),
    borderRadius: BorderRadius.circular(10),
  ),
  child: Stack(
    children: [
      Positioned(
        top: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Set your desired background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            ),
          ),
          padding: EdgeInsets.all(8),
          child: Icon(
            Icons.keyboard_arrow_right,
            color: Color(0xff7364e3), // Set your desired arrow color
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total estimated bill',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10), // Add some space between the two texts
              Text(
                'Your total bill of November month:',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 207, 207, 207),
                ),
              ),
              SizedBox(height: 10), // Add some space between the two texts
              Row(
                children: [
                  Text(
                    '₹',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Text(
                    '5100',
                    style: GoogleFonts.ultra(
                      fontSize: 48,
                      fontWeight: FontWeight.w400,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Text(
                    '/-',
                    style: GoogleFonts.lemon(
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ],
              ),
            ],
          ), // Add space between texts and button
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add your Pay Now button functionality here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 255, 255, 255), // Set your desired button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(double.infinity, 50), // Set button width to full
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Pay Now',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff7364e3),
                ),
              ),
            ),
          ),
        ],
      ),
    ],
  ),
)

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)],
              stops: [0.02, 0.9],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Image.asset(
                    'assets/images/mainlogo.png',
                    height: 40,
                    width: 120,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Home',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for menu item 1
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Leave Req.',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.announcement,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for menu item 2
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Food Menu',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.fastfood,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for menu item 3
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Resident',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.hotel,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for menu item 4
                  },
                ),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 40),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Sign Out',
                      style: GoogleFonts.poppins(
                        color: Color(0xff7364e3),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Navigate to another page (here a simple message is shown)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFFFFFF),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Icon(Icons.payment),
            ),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Icon(Icons.home),
            ),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Icon(Icons.settings),
            ),
            label: ' ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff7364e3),
        unselectedItemColor: Color(0xFFCAC4F8),
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Color(0xFF7364e3),
        elevation: 0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.sort, color: Colors.white, size: 40),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: ElevatedButton(
              onPressed: () {
                // Replace with your admin login functionality
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
              ),
              child: Text(
                'Admin',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile_photo.jpg'),
                radius: 20,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/art.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Main content
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                stops: [0.25, 0.9],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CustomPaint(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 150, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Hlo, ',
                                  style: GoogleFonts.poppins(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff7364e3),
                                  ),
                                ),
                                Text(
                                  'Admin :)', // Replace with the actual username
                                  style: GoogleFonts.poppins(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff7364e3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'You have 0 new notification(s)', // Replace with actual notification count
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff7364e3),
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: 600,
                          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                          decoration: BoxDecoration(
                            color: Color(0xff7364e3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(50),
                                      bottomLeft: Radius.circular(50),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Color(0xff7364e3),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total estimated bill',
                                        style: GoogleFonts.poppins(
                                          fontSize: 22,
                                          color: Color.fromARGB(255, 255, 255, 255),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Your total bill of November month:', // Replace with actual billing information
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 207, 207, 207),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Text(
                                            '₹',
                                            style: TextStyle(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                            ),
                                          ),
                                          Text(
                                            '5100', // Replace with actual bill amount
                                            style: GoogleFonts.ultra(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                            ),
                                          ),
                                          Text(
                                            '/-',
                                            style: GoogleFonts.lemon(
                                              fontSize: 48,
                                              fontWeight: FontWeight.w900,
                                              color: Color.fromARGB(255, 255, 255, 255),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Add your Pay Now button functionality here
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Color.fromARGB(255, 255, 255, 255),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      minimumSize: Size(double.infinity, 50),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                        'Pay Now',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff7364e3),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.white],
              stops: [0.02, 0.9],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(),
                  child: Image.asset(
                    'assets/images/mainlogo.png',
                    height: 40,
                    width: 120,
                  ),
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Register Student',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.group_add,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPage(),
                              ),
                            );
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'View Student',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.remove_red_eye,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for menu item 2
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Manage Rooms',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.hotel,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for menu item 3
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Fee Details',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.currency_rupee,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for menu item 4
                  },
                ),
                SizedBox(height: 20),
                ListTile(
                  title: Text(
                    'Food Menu',
                    style: GoogleFonts.poppins(
                      color: Color(0xff7364e3),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.food_bank,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Add functionality for menu item 4
                  },
                ),
                SizedBox(height: 30),
                Divider(),
                SizedBox(height: 40),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Sign Out',
                      style: GoogleFonts.poppins(
                        color: Color(0xff7364e3),
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Color(0xff7364e3),
                  ),
                  onTap: () {
                    // Navigate to another page (here a simple message is shown)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(), // Replace with your login screen
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Icon(Icons.payment),
            ),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Icon(Icons.home),
            ),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 15.0),
              child: Icon(Icons.settings),
            ),
            label: ' ',
          ),
        ],
        // Replace the following properties with your actual implementation
        currentIndex: 0,
        selectedItemColor: Color(0xff7364e3),
        unselectedItemColor: Color(0xFFCAC4F8),
        onTap: (index) {
          // Handle bottom navigation item tap
        },
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w800),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}