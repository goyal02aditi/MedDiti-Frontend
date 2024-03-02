import 'package:flutter/material.dart';

class RemScreen extends StatefulWidget {
  @override
  _RemScreenState createState() => _RemScreenState();
}

class _RemScreenState extends State<RemScreen> {
  final _formKey = GlobalKey<FormState>();
  String _medicineName = '';
  String _medicineDose = '';
  String _medicineType = '';
  String _medicineInterval = '2 hours';
  TimeOfDay _medicineTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        title: Text('Medicine Reminder'),
      ),
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Handle onTap logic if needed
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0), // Add padding here
                      child: Container(
                        width: 150, // Adjust width as needed
                        height: 150, // Adjust height as needed
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/pill_rounded.png',
                              width: 70, // Adjust width as needed
                              height: 70, // Adjust height as needed
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Doliprane\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Every 4 hours',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // Handle onTap logic if needed
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.all(8.0), // Add padding here
                      child: Container(
                        width: 150, // Adjust width as needed
                        height: 150, // Adjust height as needed
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/syringe.png',
                              width: 70, // Adjust width as needed
                              height: 70, // Adjust height as needed
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Insulin\n',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Every 8 hours',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: FloatingActionButton(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.white,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 900,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Medicine Name',
                                    hintText: 'Enter the name of the medicine',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the name of the medicine';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _medicineName = value!,
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Dose',
                                    hintText: 'Enter the dose of the medicine',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter the dose of the medicine';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _medicineDose = value!,
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Type',
                                    hintText: 'Select the type of the medicine',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select the type of the medicine';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) => _medicineType = value!,
                                ),
                                SizedBox(height: 16.0),
                                DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: 'Interval',
                                    hintText: 'Select the interval of the medicine',
                                  ),
                                  value: _medicineInterval,
                                  onChanged: (value) {
                                    setState(() {
                                      _medicineInterval = value!;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select the interval of the medicine';
                                    }
                                    return null;
                                  },
                                  items: [
                                    DropdownMenuItem(
                                      child: Text('2 hours'),
                                      value: '2 hours',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('4 hours'),
                                      value: '4 hours',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('8 hours'),
                                      value: '8 hours',
                                    ),
                                    DropdownMenuItem(
                                      child: Text('12 hours'),
                                      value: '12 hours',
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState?.save();
                                      // Add your code to save the reminder here
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(content: Text('Reminder added')));
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Add Reminder'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
