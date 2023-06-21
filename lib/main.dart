//Nur Amanina 2011402
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'userdetail.dart';
import 'databaseView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'User Details',
      title: 'Welcome',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const UserDetailsForm(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home Page',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Database Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DatabaseViewPage()),
                );
              },
              child: const Text('View Database'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to UserDetailPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const UserDetailsForm()),
                );
              },
              child: const Text('Go to User Detail Form'),
            ),
          ],
        ),
      ),
    );
  }
}







// class UserDetailsForm extends StatefulWidget {
//   const UserDetailsForm({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _UserDetailsFormState createState() => _UserDetailsFormState();
// }

// class _UserDetailsFormState extends State<UserDetailsForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _ageController = TextEditingController();
//   final _occupationController = TextEditingController();
//   String? _gender;
//   DateTime _selectedDate = DateTime.now();

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _ageController.dispose();
//     _occupationController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // Perform further actions with the validated user details
//       String name = _nameController.text;
//       int age = int.parse(_ageController.text);
//       String occupation = _occupationController.text;
//       String? gender = _gender;
//       DateTime dob = _selectedDate;

//       // Push user details to Firebase Realtime Database
//       // ignore: deprecated_member_use
//       DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
//       databaseRef.child('user_details').push().set({
//         'name': name,
//         'gender': gender,
//         'age': age,
//         'dob': dob.toString(),
//         'occupation': occupation,
//       });

//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('User Details'),
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Name: $name'),
//                 Text('Gender: $gender'),
//                 Text('Age: $age'),
//                 Text('Date of Birth: ${DateFormat('yyyy-MM-dd').format(dob)}'),
//                 Text('Occupation: $occupation'),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('Cancel'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                 child: const Text('Confirm'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DisplayPage(
//                         name: name,
//                         gender: gender,
//                         age: age,
//                         dob: dob,
//                         occupation: occupation,
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           );
//         },
//       );

//       _resetForm(); // Reset the form after submitting the details
//     }
//   }

//   void _resetForm() {
//     setState(() {
//       _nameController.clear();
//       _ageController.clear();
//       _occupationController.clear();
//       _gender = null;
//       _selectedDate = DateTime.now();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return true;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('User Details'),
//         ),
//         body: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: const InputDecoration(labelText: 'Name'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your name';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 DropdownButtonFormField<String>(
//                   decoration: const InputDecoration(
//                     labelText: 'Gender',
//                   ),
//                   value: _gender,
//                   onChanged: (value) {
//                     setState(() {
//                       _gender = value;
//                     });
//                   },
//                   items: const [
//                     DropdownMenuItem(
//                       value: 'Male',
//                       child: Text('Male'),
//                     ),
//                     DropdownMenuItem(
//                       value: 'Female',
//                       child: Text('Female'),
//                     ),
//                   ],
//                   validator: (value) {
//                     if (value == null) {
//                       return 'Please select your gender';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: _ageController,
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(labelText: 'Age'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your age';
//                     }
//                     int? age = int.tryParse(value);
//                     if (age == null || age <= 0) {
//                       return 'Please enter a valid age';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 16.0),
//                 const Text('Date of Birth'),
//                 const SizedBox(height: 16.0),
//                 InkWell(
//                   onTap: () {
//                     _selectDate(context);
//                   },
//                   child: InputDecorator(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                     ),
//                     child: Text(
//                       DateFormat('yyyy-MM-dd').format(_selectedDate),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextFormField(
//                   controller: _occupationController,
//                   decoration: const InputDecoration(labelText: 'Occupation'),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Please enter your occupation';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 24.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     _submitForm();
//                     _resetForm(); // Reset the form after submitting the details
//                   },
//                   child: const Text(
//                     'Submit',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
