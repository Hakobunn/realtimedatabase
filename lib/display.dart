import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class DisplayPage extends StatefulWidget {
  final String name;
  final String? gender;
  final int age;
  final DateTime dob;
  final String occupation;

  const DisplayPage({
    Key? key,
    required this.name,
    this.gender,
    required this.age,
    required this.dob,
    required this.occupation,
  }) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  List<Map<String, dynamic>> userDetails = [];

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: userDetails.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> user = userDetails[index];

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text('Name: ${user['name']}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Gender: ${user['gender'] ?? 'N/A'}'),
                        Text('Age: ${user['age']}'),
                        Text(
                            'Date of Birth: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(user['dob']))}'),
                        Text('Occupation: ${user['occupation']}'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void fetchUserDetails() {
    // ignore: deprecated_member_use
    DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
    databaseRef.child('user_details').onChildAdded.listen((event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          setState(() {
            userDetails.add(Map<String, dynamic>.from(values));
          });
        }
      }
    });
  }
}
