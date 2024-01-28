import 'package:flutter/material.dart';
import 'homepage.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RemScreen extends StatefulWidget {
  const RemScreen({super.key});

  @override
  _RemScreenState createState() => _RemScreenState();
}


class _RemScreenState extends State<RemScreen> {
    List<String> pillList = [
    'Morning Pill',
    'Afternoon Pill',
    'Evening Pill',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pill Reminder'),
      ),
      body: ListView.builder(
        itemCount: pillList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pillList[index]),
            trailing: IconButton(
              icon: Icon(Icons.alarm),
              onPressed: () {
                // Add logic to set a reminder for the selected pill
                // You can use plugins like flutter_local_notifications to handle notifications
                // For simplicity, you can print a message here.
                print('Set a reminder for ${pillList[index]}');
              },
            ),
          );
        },
      ),
    );
  }
}
