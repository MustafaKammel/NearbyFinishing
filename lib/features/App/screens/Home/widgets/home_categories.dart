// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduateproject/features/App/screens/Home/widgets/category_details_view.dart';

import '../../../../../../../common/widgets/image_text/vertically_image_text.dart';

class HomeCategories extends StatelessWidget {
  HomeCategories({super.key});

  List icons = [
    "assets/icons/spicialists/heart.png",
    "assets/icons/spicialists/eye.png",
    "assets/icons/spicialists/lungs.png",
    "assets/icons/spicialists/tooth.png",
    "assets/icons/spicialists/brain.png",
    "assets/icons/spicialists/bones.png",
    "assets/icons/spicialists/kidney.png",
    "assets/icons/spicialists/ear.png",
  ];

  List text = [
    "Cardiolo", //أمراض القلب
    "Ophthalmology", //طب العيون
    "pulmonology", //أمراض الرئة
    "Dentist", //طبيب أسنان
    "Neurology", //علم الأعصاب
    "Orthopedic", //تقويم العظام
    "Nephrology", //أمراض الكلى
    "Otolaryngolgy", //طب الأنف والأذن والحنجرة
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: icons.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return VerticallyImageText(
            image: icons[index],
            text: text[index],
            onTap: () {
              Get.to(
                () => CategoryDetailsView(
                  catName: text[index],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
