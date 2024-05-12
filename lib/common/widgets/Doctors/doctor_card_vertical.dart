import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduateproject/utils/constants/colors.dart';
import 'package:graduateproject/utils/constants/sizes.dart';
import 'package:graduateproject/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/authentication/controllers/home_controller.dart';
import '../../styles/shadow_style.dart';
import '../common_images/rounded_image.dart';
import '../custom_shapes/contianers/rounded_container.dart';
import '../texts/doctor_title_text.dart';

class DoctorCardVertical extends StatelessWidget {
  const DoctorCardVertical({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.isFavorite,
    this.onTap,
    this.onFavoritePressed,
  }) : super(key: key);

  final String title, subtitle, image;
  final bool isFavorite;
  final void Function()? onTap;
  final void Function()? onFavoritePressed; // إضافة دالة للتحديث عند الضغط على القلب
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalDoctorShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: dark ? MColors.darkGrey : MColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedContainer(
              width: double.infinity,
              padding: const EdgeInsets.all(TSizes.sm),
              backGroundColor: dark ? MColors.dark : MColors.grey,
              child: Stack(
                children: [
                  RoundedImage(
                    imagUrl: image,
                    applyImageRadius: true,
                    fit: BoxFit.fill,
                    height: 100,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: -5,
                    right: -5,
                    child: IconButton(
                      icon: isFavorite
                          ? Icon(
                        Iconsax.heart5,
                        color: MColors.error,
                      )
                          : Icon(
                        Iconsax.heart,
                        color: Colors.grey,
                      ),
                      onPressed:toggleFavoriteStatus, // استخدم الدالة الممررة لتحديث حالة العلامة المفضلة
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorTitleText(
                    title: title,
                    smallSize: true,
                  ),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundedContainer(
                        radius: TSizes.sm,
                        width: 60,
                        backGroundColor: MColors.secondary.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: TSizes.sm, vertical: TSizes.xs),
                        child: const Row(
                          children: [
                            Icon(
                              Iconsax.star,
                              size: 12,
                            ),
                            SizedBox(
                              width: TSizes.xs,
                            ),
                            Text(
                              "9.5",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: TSizes.iconLg * 1.2,
                        height: TSizes.iconLg * 1.2,
                        decoration: const BoxDecoration(
                          color: MColors.dark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(TSizes.cardRadiusMd),
                            bottomRight:
                            Radius.circular(TSizes.productImageRadius),
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Iconsax.add,
                            color: MColors.white,
                          ),
                          onPressed: () {

                          },

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> toggleFavoriteStatus() async {
    try {
      // احصل على مرجع لمستند الطبيب
      var doctorRef = FirebaseFirestore.instance.collection('doctors').doc('docId');

      // احصل على بيانات الطبيب
      var doctorSnapshot = await doctorRef.get();
      if (!doctorSnapshot.exists) {
        return; // تأكد من أن المستند موجود
      }

      // احصل على قيمة isFavorite الحالية وقم بتبديلها
      bool isFavorite = doctorSnapshot.data()?['isFavorite'] ?? false;
      await doctorRef.update({'isFavorite': !isFavorite});
    } catch (e) {
      print('Error toggling favorite status: $e');
      // يمكنك إدراج معالجة الأخطاء هنا
    }
  }
}


// import 'package:flutter/material.dart';
// import 'package:graduateproject/utils/constants/colors.dart';
// import 'package:graduateproject/utils/constants/sizes.dart';
// import 'package:graduateproject/utils/helpers/helper_functions.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../styles/shadow_style.dart';
// import '../common_images/rounded_image.dart';
// import '../custom_shapes/contianers/rounded_container.dart';
// import '../texts/doctor_title_text.dart';
//
// class DoctorCardVertical extends StatelessWidget {
//   const DoctorCardVertical({
//     super.key,
//     required this.title,
//     required this.subtitle,
//     required this.image,
//     this.onTap,
//   });
//   final String title, subtitle, image;
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.all(1),
//         decoration: BoxDecoration(
//           boxShadow: [ShadowStyle.verticalDoctorShadow],
//           borderRadius: BorderRadius.circular(TSizes.productImageRadius),
//           color: dark ? MColors.darkGrey : MColors.white,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             RoundedContainer(
//               width: double.infinity,
//               padding: const EdgeInsets.all(TSizes.sm),
//               backGroundColor: dark ? MColors.dark : MColors.grey,
//               child: Stack(
//                 children: [
//                   RoundedImage(
//                     imagUrl: image,
//                     applyImageRadius: true,
//                     fit: BoxFit.fill,
//                     height: 100,
//                     width: double.infinity,
//                   ),
//                   Positioned(
//                     top: -5,
//                     right: -5,
//                     child: IconButton(
//                       icon: const Icon(
//                         Iconsax.heart5,
//                         color: Colors.grey,
//                       ),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(TSizes.sm),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   DoctorTitleText(
//                     title: title,
//                     smallSize: true,
//                   ),
//                   Text(
//                     subtitle,
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                     style: Theme.of(context).textTheme.labelMedium,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       RoundedContainer(
//                         radius: TSizes.sm,
//                         width: 60,
//                         backGroundColor: MColors.secondary.withOpacity(0.8),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: TSizes.sm, vertical: TSizes.xs),
//                         child: const Row(
//                           children: [
//                             Icon(
//                               Iconsax.star,
//                               size: 12,
//                             ),
//                             SizedBox(
//                               width: TSizes.xs,
//                             ),
//                             Text(
//                               "9.5",
//                               style: TextStyle(fontSize: 12),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         width: TSizes.iconLg * 1.2,
//                         height: TSizes.iconLg * 1.2,
//                         decoration: const BoxDecoration(
//                           color: MColors.dark,
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(TSizes.cardRadiusMd),
//                             bottomRight:
//                                 Radius.circular(TSizes.productImageRadius),
//                           ),
//                         ),
//                         child: IconButton(
//                           icon: const Icon(
//                             Iconsax.add,
//                             color: MColors.white,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
