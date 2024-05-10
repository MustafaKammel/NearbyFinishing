import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:graduateproject/features/authentication/controllers/auth_controller.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../../../../utils/constants/sizes.dart';
import '../../../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import 'terms_and_conditions_checkbox.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var isDoctor = false;
  bool passwordVisible = false;
  String _selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());

  String _startDate = DateFormat('HH:mm:ss').format(DateTime.now());

  String _endDate =
      DateFormat('HH:mm:ss').format(DateTime.now().add(Duration(minutes: 15)));

  var controller = Get.put(AuthController());

  // String categoryslected = 'Cardiolo';

  List<String> categoryList = [
    "Cardiolo", //أمراض القلب
    "Ophthalmology", //طب العيون
    "pulmonology", //أمراض الرئة
    "Dentist", //طبيب أسنان
    "Neurology", //علم الأعصاب
    "Orthopedic", //تقويم العظام
    "Nephrology", //أمراض الكلى
    "Otolaryngolgy",
    // Add more categories as needed
  ];
  List<String> _selectedDays = [];
  final List<String> availableDays = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //UserName
          TextFormField(
            keyboardType: TextInputType.name,
            controller: controller.fullnameController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.user_edit),
              labelText: TTexts.username,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required!';
              }
              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Email
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Iconsax.direct),
              labelText: TTexts.email,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required.';
              }

              // Regular expression for email validation
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

              if (!emailRegExp.hasMatch(value)) {
                return 'Invalid email address.';
              }

              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),

          //Password
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            controller: controller.passwordController,
            obscureText: !passwordVisible,
            decoration: InputDecoration(
              prefixIcon: const Icon(Iconsax.password_check),
              labelText: TTexts.password,
              suffixIcon: IconButton(
                icon: Icon(passwordVisible ? Iconsax.eye_slash : Iconsax.eye),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible; // Toggle visibility
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required.';
              }

              // Check for minimum password length
              if (value.length < 6) {
                return 'Password must be at least 6 characters long.';
              }

              // Check for uppercase letters
              if (!value.contains(RegExp(r'[A-Z]'))) {
                return 'Password must contain at least one uppercase letter.';
              }

              // Check for numbers
              if (!value.contains(RegExp(r'[0-9]'))) {
                return 'Password must contain at least one number.';
              }

              // Check for special characters
              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                return 'Password must contain at least one special character.';
              }

              return null;
            },
          ),

          const SizedBox(height: TSizes.spaceBtwInputFields),
          SwitchListTile(
            title: const Text("Sign up as a Doctor"),
            value: isDoctor,
            onChanged: (newValue) {
              setState(() {
                isDoctor = newValue;
              });
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Visibility(
            visible: isDoctor,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: controller.aboutController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.info_circle),
                    labelText: "About",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'About is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.category), // Your desired icon
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    value: controller.categoryslected,
                    alignment: AlignmentDirectional.centerEnd,
                    isExpanded: true,
                    isDense: true,
                    style: TextStyle(
                      color: dark ? Colors.white : Colors.black,
                    ),
                    items: const [
                      DropdownMenuItem<String>(
                        child: Text("Cardiolo"),
                        value: "Cardiolo",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("pulmonology"),
                        value: "pulmonology",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Ophthalmology"),
                        value: "Ophthalmology",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Dentist"),
                        value: "Dentist",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Neurology"),
                        value: "Neurology",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Orthopedic"),
                        value: "Orthopedic",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Nephrology"),
                        value: "Nephrology",
                      ),
                      DropdownMenuItem<String>(
                        child: Text("Otolaryngolgy"),
                        value: "Otolaryngolgy",
                      ),
                    ],
                    onChanged: (String? newvalue) {
                      setState(() {
                        controller.categoryslected = newvalue!;
                      });
                    },
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: controller.servicesController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.medical_services),
                    labelText: "Services",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Services are required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  controller: controller.addressController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Address",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: controller.phoneController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.call),
                    labelText: "Phone Number",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _selectStartTime(context);
                        },
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          enabled: false,
                          controller: controller.timingControllerfrom,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.timelapse_outlined),
                            labelText: "Duration From",
                            hintText: _startDate.toString(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Duration From is required.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _selectEndTime(context);
                        },
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          enabled: false,
                          controller: controller.timingControllerto,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.timelapse_outlined),
                            labelText: "Duration To",
                            hintText: _endDate.toString(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Duration To is required.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Unavailable Days",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 17,
                        children: availableDays.map((day) {
                          return FilterChip(
                            label: Text(day),
                            selected: _selectedDays.contains(day),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  _selectedDays.add(day);
                                } else {
                                  _selectedDays.remove(day);
                                }
                                // Call function to update available days in Firestore
                                // controller.updateDoctorAvailableDays(_selectedDays);
                              });
                            },
                            selectedColor: Colors.red,
                            backgroundColor: Colors.grey[200],
                            checkmarkColor: Colors.white,
                            showCheckmark: true,
                            elevation: 2,
                            pressElevation: 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 9),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller.salaryController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.attach_money_rounded),
                    labelText: "Add Your Price",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
              ],
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          // Terms & Conditions of CheckBox
          const TermsAndConditionsCheckBox(),

          const SizedBox(height: TSizes.spaceBtwSections),

          // Create Account Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Perform form validation
                  if (isDoctor == true) {
                    if (_selectedDays.isEmpty) {
                      // If no unavailable days are selected, show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Please select at least one unavailable day"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else {
                      // Otherwise, proceed with sign up process
                      controller.signupUser(isDoctor, _selectedDays);
                    }
                  } else {
                    controller.signupUser(isDoctor, _selectedDays);
                  }
                }
              },
              child: const Text(TTexts.createAccount),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Do you have an account?"),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Text(
                  " Log in",
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      currentDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    setState(() {
      if (selected != null) {
        _selectedDate = DateFormat('yyyy-MM-dd').format(selected).toString();
        print(_selectedDate);
      } else {
        _selectedDate =
            DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
      }
    });
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    var date = join(DateTime.parse(_selectedDate), selected!);
    print(date);
    var formattedTime = DateFormat("HH:mm:ss").format(date);
    print(formattedTime);

    setState(() {
      _startDate = formattedTime;
      controller.timingControllerfrom.text = formattedTime;
    });
  }

  DateTime join(DateTime date, TimeOfDay time) {
    print(time.hour);
    return new DateTime(
        date.year, date.month, date.day, time.hour, time.minute);
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    var date = join(DateTime.parse(_selectedDate), selected!);
    print(date);
    var formattedTime = DateFormat("HH:mm:ss").format(date);
    print(formattedTime);
    // Conversion logic starts here
    setState(() {
      _endDate = formattedTime;
      controller.timingControllerto.text = formattedTime;
      print(formattedTime);
    });
  }
}
