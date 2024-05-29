import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduateproject/common/widgets/app_bar/appbar.dart';
import 'package:iconsax/iconsax.dart';

class Doc_Settings extends StatefulWidget {
  const Doc_Settings({Key? key}) : super(key: key);

  @override
  State<Doc_Settings> createState() => _DocSettingsState();
}

class _DocSettingsState extends State<Doc_Settings> {
  User? user = FirebaseAuth.instance.currentUser;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late TextEditingController _categoryController;
  late TextEditingController _salaryController;
  late TextEditingController _serviceController;
  late TextEditingController _timingFromController;
  late TextEditingController _timingToController;
  late TextEditingController _aboutController;
  List<String> _availableDays = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _categoryController = TextEditingController();
    _salaryController = TextEditingController();
    _serviceController = TextEditingController();
    _timingFromController = TextEditingController();
    _timingToController = TextEditingController();
    _aboutController = TextEditingController();

    _loadData();
  }

  Future<void> _loadData() async {
    if (user != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user!.uid)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        _nameController.text = data['docName'] ?? '';
        _emailController.text = data['docEmail'] ?? '';
        _phoneController.text = data['docPhone'] ?? '';
        _addressController.text = data['docAddress'] ?? '';
        _categoryController.text = data['docCategory'] ?? '';
        _salaryController.text = data['docSalary'] ?? '';
        _serviceController.text = data['docService'] ?? '';
        _timingFromController.text = data['docTimingfrom'] ?? '';
        _timingToController.text = data['docTimingto'] ?? '';
        _aboutController.text = data['docAbout'] ?? '';
        _availableDays = List<String>.from(data['availableDays'] ?? []);
      }
    }
  }

  Future<void> _confirmSignOut() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateData() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user!.uid)
          .update({
        'docName': _nameController.text,
        'docEmail': _emailController.text,
        'docPhone': _phoneController.text,
        'docAddress': _addressController.text,
        'docCategory': _categoryController.text,
        'docSalary': _salaryController.text,
        'docService': _serviceController.text,
        'docTimingfrom': _timingFromController.text,
        'docTimingto': _timingToController.text,
        'docAbout': _aboutController.text,
        'availableDays': _availableDays,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Text(
          "My profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          IconButton(
            onPressed: _confirmSignOut,
            icon: const Icon(Iconsax.logout_1),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null
                  ? const Icon(Icons.person, size: 60, color: Colors.white)
                  : null,
            ),
            const SizedBox(height: 20),
            _buildTextField(_nameController, 'Name'),
            const SizedBox(height: 10),
            _buildTextField(_emailController, 'Email'),
            const SizedBox(height: 10),
            _buildTextField(_phoneController, 'Phone'),
            const SizedBox(height: 10),
            _buildTextField(_addressController, 'Address'),
            const SizedBox(height: 10),
            _buildTextField(_categoryController, 'Category'),
            const SizedBox(height: 10),
            _buildTextField(_salaryController, 'Salary'),
            const SizedBox(height: 10),
            _buildTextField(_serviceController, 'Service'),
            const SizedBox(height: 10),
            _buildTextField(_timingFromController, 'Timing From'),
            const SizedBox(height: 10),
            _buildTextField(_timingToController, 'Timing To'),
            const SizedBox(height: 10),
            _buildTextField(_aboutController, 'About'),
            const SizedBox(height: 20),
            Text(
              'Un Available Days',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                'Saturday',
                'Sunday',
                'Monday',
                'Tuesday',
                'Wednesday',
                'Thursday',
                'Friday'
              ]
                  .map((day) => FilterChip(
                        label: Text(day),
                        selected: _availableDays.contains(day),
                        onSelected: (bool selected) {
                          setState(() {
                            if (selected) {
                              _availableDays.add(day);
                            } else {
                              _availableDays.remove(day);
                            }
                          });
                        },
                        selectedColor: Colors.red,
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            Container(
              width: 200,
              child: ElevatedButton(
                onPressed: _updateData,
                child: const Text('Update Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            enabled: false,
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Edit $label'),
                  content: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: label,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          // Update the text from the dialog
                          controller.text = controller.text;
                        });
                        Navigator.pop(context);
                      },
                      child: Text('Save'),
                    ),
                  ],
                );
              },
            );
          },
          icon: Icon(Iconsax.edit_2),
        ),
      ],
    );
  }
}
