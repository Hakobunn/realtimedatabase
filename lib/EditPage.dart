import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditPage({Key? key, required this.user}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController nameController;
  late TextEditingController genderController;
  late TextEditingController ageController;
  late TextEditingController dobController;
  late TextEditingController occupationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user['name']);
    genderController = TextEditingController(text: widget.user['gender'] ?? '');
    ageController = TextEditingController(text: widget.user['age'].toString());
    dobController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.user['dob']));
    occupationController =
        TextEditingController(text: widget.user['occupation']);
  }

  @override
  void dispose() {
    nameController.dispose();
    genderController.dispose();
    ageController.dispose();
    dobController.dispose();
    occupationController.dispose();
    super.dispose();
  }

  void saveChanges() {
    String name = nameController.text;
    String gender = genderController.text;
    int age = int.tryParse(ageController.text) ?? 0;
    DateTime dob = DateFormat('yyyy-MM-dd').parse(dobController.text);
    String occupation = occupationController.text;

    Map<String, dynamic> editedUser = {
      'name': name,
      'gender': gender,
      'age': age,
      'dob': dob,
      'occupation': occupation,
      'key': widget.user['key'],
    };

    Navigator.pop(context, editedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: dobController,
              decoration: const InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: occupationController,
              decoration: const InputDecoration(labelText: 'Occupation'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: saveChanges,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
