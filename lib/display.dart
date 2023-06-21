//by Nurul Fakhriwani 1911480

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

import 'EditPage.dart'; // Import the edit_page.dart file

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

  void deleteUser(String key) {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    databaseRef.child('user_details').child(key).remove().then((_) {
      setState(() {
        userDetails.removeWhere((user) => user['key'] == key);
      });
    });
  }

  void updateUserData(Map<String, dynamic> editedUser) {
    DatabaseReference databaseRef = FirebaseDatabase.instance.ref();
    String userKey = editedUser['key'];

    databaseRef
        .child('user_details')
        .child(userKey)
        .update(editedUser)
        .then((_) {
      setState(() {
        int userIndex =
            userDetails.indexWhere((user) => user['key'] == userKey);
        if (userIndex != -1) {
          userDetails[userIndex] = editedUser;
        }
      });
      showMessage('User updated successfully!');
    }).catchError((error) {
      showMessage('Failed to update user: $error');
    });
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
            userDetails.add({
              ...Map<String, dynamic>.from(values),
              'key': event.snapshot.key,
            });
          });
        }
      }
    });
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
                        Text('Gender: ${user['gender']}'),
                        Text('Age: ${user['age']}'),
                        Text(
                          'Date of Birth: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(user['dob']))}',
                        ),
                        Text('Occupation: ${user['occupation']}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPage(user: user),
                              ),
                            ).then((editedUser) {
                              updateUserData(editedUser);

                              // if (editedUser != null) {
                              //   print('hello');
                              //   print(editedUser);
                              //   updateUserData(editedUser);
                              // }
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete User'),
                                  content: const Text(
                                      'Are you sure you want to delete this user?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        deleteUser(user['key']);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
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
}
