//Create page and all code here Nur Athirah Zaaba 2011156
// Alter the code Nur Amanina 2011402

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
  late DateTime _selectedDate;
  late TextEditingController occupationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user['name']);
    genderController = TextEditingController(text: widget.user['gender'] ?? '');
    ageController = TextEditingController(text: widget.user['age'].toString());
    // dobController = TextEditingController(text: widget.user['dob']);
    dobController = TextEditingController(
        text: DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(widget.user['dob'])));
    _selectedDate = DateTime.parse(widget.user['dob']);
    occupationController =
        TextEditingController(text: widget.user['occupation']);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dobController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
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
    String dob = dobController.text; // Store dob as String
    print(dob);
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
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Gender',
              ),
              value: genderController.text,
              onChanged: (value) {
                setState(() {
                  genderController.text = value!;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: 'Male',
                  child: Text('Male'),
                ),
                DropdownMenuItem(
                  value: 'Female',
                  child: Text('Female'),
                ),
              ],
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              readOnly: true,
              controller: dobController,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                suffixIcon: IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
              ),

              // controller: dobController,
              // decoration: const InputDecoration(labelText: 'Date of Birth'),
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
