import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../common/widgets/app_bar/appbar.dart';
import '../../../../common/widgets/common_images/circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key});

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWidget(
        showBackArrow: true,
        title: Text(
          "My Profile",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // عرض دائرة التحميل أثناء جلب البيانات
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // إذا حدث خطأ أثناء جلب البيانات
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Text('No data available'); // إذا لم تكن هناك بيانات متاحة
          }

          final userData = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      // صورة المستخدم
                      CircularImage(
                        image: TImages.Profile, // استخدام الصورة الموجودة في Firebase إذا كانت متاحة، وإلا استخدام الصورة الافتراضية
                        width: 80,
                        height: 80,
                      ),
                      // زر تغيير الصورة
                      TextButton(
                        onPressed: () {
                          // اضافة التعليقات اللازمة هنا لتغيير الصورة
                        },
                        child: const Text("Change profile picture"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 2),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                const SectionHeading(
                  title: "Profile Information",
                  showActionButton: false,
                ),
                // استخدام بيانات المستخدم من Firestore
                ProfileMenu(
                  onTap: () {
                    // اضافة التعليقات اللازمة هنا لتعديل البيانات
                    showDialog(
                      context: context,
                      builder: (context) => _buildEditDialog(
                        context,
                        'name', // اسم الحقل الذي تريد تعديله
                        userData['name'], // القيمة الحالية للحقل
                      ),
                    );
                  },
                  title: "Name",
                  value: userData['name'] ?? "", // استخدام الاسم الموجود في Firestore إذا كان متاحًا
                ),
                ProfileMenu(
                  onTap: () {
                    // اضافة التعليقات اللازمة هنا لتعديل البيانات
                    showDialog(
                      context: context,
                      builder: (context) => _buildEditDialog(
                        context,
                        'email', // اسم الحقل الذي تريد تعديله
                        userData['email'], // القيمة الحالية للحقل
                      ),
                    );
                  },
                  title: "Email",
                  value: userData['email'] ?? "", // استخدام البريد الإلكتروني الموجود في Firestore إذا كان متاحًا
                ),
                ProfileMenu(
                  onTap: () {
                    // اضافة التعليقات اللازمة هنا لتعديل البيانات
                    showDialog(
                      context: context,
                      builder: (context) => _buildEditDialog(
                        context,
                        'about', // اسم الحقل الذي تريد تعديله
                        userData['about'], // القيمة الحالية للحقل
                      ),
                    );
                  },
                  title: "About",
                  value: userData['about'] ?? "", // استخدام الوصف الموجود في Firestore إذا كان متاحًا
                ),
                // استمر في إضافة عناصر الملف الشخصي الأخرى
                // ...
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEditDialog(BuildContext context, String field, String initialValue) {
    String updatedValue = initialValue;

    return AlertDialog(
      title: Text('Edit $field'),
      content: TextFormField(
        initialValue: initialValue,
        onChanged: (newValue) => updatedValue = newValue,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // اضافة الكود اللازم هنا لتحديث القيمة في Firestore
            FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update({
              field: updatedValue,
            });
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
