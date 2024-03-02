import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal.shade700, width: 2.0),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/girl.png'), 
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Aina', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color:Colors.teal.shade700),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Date of Birth
            // Date of Birth
Row(
  children: [
    Text(
      'Date of Birth: ', 
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    Text(
      '04 August 2003', 
      style: TextStyle(fontSize: 16),
    ),
  ],
),
SizedBox(height: 10),

// Age
Row(
  children: [
    Text(
      'Age: ', 
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    Text(
      '20 years', 
      style: TextStyle(fontSize: 16),
    ),
  ],
),
SizedBox(height: 10),

// Emergency Number
Row(
  children: [
    Text(
      'Emergency Number: ', 
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    Text(
      '+91 98765 43210', 
      style: TextStyle(fontSize: 16),
    ),
  ],
),
SizedBox(height: 10),

// Gender
Row(
  children: [
    Text(
      'Gender: ', 
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    Text(
      'Female', 
      style: TextStyle(fontSize: 16),
    ),
  ],
),
SizedBox(height: 10),

// Blood Group
Row(
  children: [
    Text(
      'Blood Group: ', 
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
    Text(
      'O+', 
      style: TextStyle(fontSize: 16),
    ),
  ],
),

            
            SizedBox(height: 10),

            // Medical Reports
            Text(
              'Prescriptions:', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color:Colors.teal.shade700),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: GestureDetector(
                onTap: () {
                  _launchURL('https://drive.google.com/file/d/1GewVMh-QQwqIdAgqA9jbJooFfVUDPVVG/view?usp=sharing');
                },
                child: Text(
                  'Prescription',
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Medical Reports
            Text(
              'Medical Reports:', 
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color:Colors.teal.shade700),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: GestureDetector(
                onTap: () {
                  _launchURL('https://drive.google.com/file/d/11TxzcQrcuyTJS6KnGYEsgNkzxykiPxBa/view?usp=sharing');
                },
                child: Text(
                  'Medical Reports',
                  style: TextStyle(
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to launch URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
