import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  List<bool> isRead = [false, false, false, false, false];
  List<String> notifications = [
    "Notification 1",
    "Notification 2",
    "Notification 3",
    "Notification 4",
    "Notification 5",
  ];

  String echod =
      'ലോറെം ഇപ്‌സം എന്നത് പ്രിൻ്റിംഗ്, ടൈപ്പ് സെറ്റിംഗ് വ്യവസായത്തിൻ്റെ കേവലം വ്യാജ വാചകമാണ്. 1500-കൾ മുതൽ ലോറം ഇപ്‌സം വ്യവസായത്തിൻ്റെ സ്റ്റാൻഡേർഡ് ഡമ്മി ടെക്‌സ്‌റ്റാണ്, അജ്ഞാതനായ ഒരു പ്രിൻ്റർ ടൈപ്പിൻ്റെ ഒരു ഗാലി എടുത്ത് ഒരു ടൈപ്പ് സ്‌പെസിമെൻ ബുക്ക് സൃഷ്‌ടിക്കാൻ ശ്രമിച്ചപ്പോൾ. ഇത് അഞ്ച് നൂറ്റാണ്ടുകൾ മാത്രമല്ല, ഇലക്ട്രോണിക് ടൈപ്പ് സെറ്റിംഗിലേക്കുള്ള കുതിച്ചുചാട്ടത്തെയും അതിജീവിച്ചു, അടിസ്ഥാനപരമായി മാറ്റമില്ലാതെ തുടരുന്നു. 1960-കളിൽ ലോറം ഇപ്‌സം പാസേജുകൾ അടങ്ങിയ ലെട്രാസെറ്റ് ഷീറ്റുകളുടെ പ്രകാശനത്തിലൂടെയും അടുത്തിടെ ലോറം ഇപ്‌സത്തിൻ്റെ പതിപ്പുകൾ ഉൾപ്പെടെ ആൽഡസ് പേജ് മേക്കർ പോലുള്ള ഡെസ്‌ക്‌ടോപ്പ് പബ്ലിഷിംഗ് സോഫ്‌റ്റ്‌വെയറിലൂടെയും ഇത് ജനപ്രിയമായി.';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
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
            Icons.navigate_before_rounded,
            size: 35,
            color: Color(0xff7364e3),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xff7364e3),
          ),
        ),
      ),
      body: _isLoading
          ? _buildShimmerEffect()
          : Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: notifications.isEmpty
                  ? Center(
                      child: Text('No notifications.'),
                    )
                  : ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: 20), // Add space between cards
                          child: ListTile(
                            leading: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xff7364e3), // Background color
                                  ),
                                  padding: EdgeInsets.all(12), // Adjust padding as needed
                                  child: Icon(
                                    Icons.notifications,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    size: 25,
                                  ), // Notification icon
                                ),
                                if (!isRead[index])
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFFFFFFF),
                                        border: Border.all(
                                          color: Color(0xff7364e3), // You can adjust the color and width of the border
                                          width: 2,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '1',
                                          style: GoogleFonts.poppins(
                                            color: Color(0xff7364e3),
                                            fontWeight: FontWeight.bold, // Set text color to match border color
                                            fontSize: 8, // Set font size according to your preference
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notification ${index + 1}',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff7364e3),
                                  ),
                                ),
                                Text(
                                  'This is a sample notification subheading. This is a sample notification subheading.',
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  '21-12-2004',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Color(0xff7364e3),
                                  ),
                                ),
                              ],
                            ),
                            trailing: Text(
                              '12:00 PM',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Color(0xff7364e3),
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                isRead[index] = true;
                              });
                              _showNotificationDetails(
                                  context, notifications[index], notifications[index]);
                            },
                          ),
                        );
                      },
                    ),
            ),
    );
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25.0,
            ),
            title: Container(
              height: 15.0,
              color: Colors.white,
            ),
            subtitle: Container(
              height: 10.0,
              color: Colors.white,
            ),
            trailing: Container(
              height: 10.0,
              width: 40.0,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  void _showNotificationDetails(BuildContext context, String title, String notification) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                echod,
                style: GoogleFonts.poppins(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
