import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:graduateproject/features/authentication/controllers/home_controller.dart';
import 'package:graduateproject/utils/constants/colors.dart';
import 'package:graduateproject/utils/constants/sizes.dart';
import 'package:graduateproject/utils/constants/text_strings.dart';
import 'package:graduateproject/utils/consts/consts.dart';
import 'package:graduateproject/utils/helpers/helper_functions.dart';
import 'package:graduateproject/views/doctor_profile_view/doctor_profile_view.dart';
import '../../../../../../common/widgets/custom_shapes/contianers/primary_header_container.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../common/widgets/Doctors/doctor_card_vertical.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_search.dart';
import 'widgets/promo_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              height: 380,
              child: Column(
                children: [
                  const HomeAppBar(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  //search
                  const SearchHomePage(text: "Search"),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        const SectionHeading(
                          title: TTexts.homeSubTitle1,
                          showActionButton: false,
                          textColor: MColors.white,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        HomeCategories(),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const PromoSlider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SectionHeading(
                    title: TTexts.homeSubTitle2,
                    showActionButton: false,
                    textColor: dark ? MColors.white : MColors.black,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  FutureBuilder<QuerySnapshot>(
                    future: controller.getDoctorList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        var data = snapshot.data?.docs;
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: GridView.builder(
                            shrinkWrap: true,
                            // physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: TSizes.gridViewSpacing,
                              crossAxisSpacing: TSizes.gridViewSpacing,
                              mainAxisExtent: 220,
                            ),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: data?.length ?? 0,
                            itemBuilder: (context, index) {
                              return DoctorCardVertical(
                                image: doctor,
                                subtitle: data![index]['docCategory'],
                                title: data[index]['docName'],
                                onTap: () {
                                  Get.to(() => DoctorProfileView(
                                    doc: data[index],
                                  ));
                                },
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//**
// ignore_for_file: must_be_immutable
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:graduateproject/features/authentication/controllers/home_controller.dart';
//
// import 'package:graduateproject/utils/constants/colors.dart';
// import 'package:graduateproject/utils/constants/sizes.dart';
// import 'package:graduateproject/utils/constants/text_strings.dart';
// import 'package:graduateproject/utils/consts/consts.dart';
// import 'package:graduateproject/utils/helpers/helper_functions.dart';
// import 'package:graduateproject/views/doctor_profile_view/doctor_profile_view.dart';
//
// import '../../../../../../common/widgets/custom_shapes/contianers/primary_header_container.dart';
// import '../../../../../../common/widgets/texts/section_heading.dart';
// import '../../../../../../common/widgets/Doctors/doctor_card_vertical.dart';
// import 'widgets/home_appbar.dart';
// import 'widgets/home_categories.dart';
// import 'widgets/home_search.dart';
// import 'widgets/promo_slider.dart';
//
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(HomeController());
//     final dark = THelperFunctions.isDarkMode(context);
//     return Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               PrimaryHeaderContainer(
//                 height: 380,
//                 child: Column(
//                   children: [
//                     const HomeAppBar(),
//                     const SizedBox(
//                       height: TSizes.spaceBtwSections,
//                     ),
//                     //search
//                     const SearchHomePage(text: "Search"),
//                     const SizedBox(
//                       height: TSizes.spaceBtwSections,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: TSizes.defaultSpace),
//                       child: Column(
//                         children: [
//                           const SectionHeading(
//                             title: TTexts.homeSubTitle1,
//                             showActionButton: false,
//                             textColor: MColors.white,
//                           ),
//                           const SizedBox(
//                             height: TSizes.spaceBtwItems,
//                           ),
//                           HomeCategories(),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(TSizes.defaultSpace),
//                 child: Column(
//                   children: [
//                     const PromoSlider(),
//                     const SizedBox(
//                       height: TSizes.spaceBtwItems,
//                     ),
//                     SectionHeading(
//                       title: TTexts.homeSubTitle2,
//                       showActionButton: false,
//                       textColor: dark ? MColors.white : MColors.black,
//                     ),
//                     const SizedBox(
//                       height: TSizes.spaceBtwItems,
//                     ),
//                     FutureBuilder<QuerySnapshot>(
//                       future: controller.getDoctorList(),
//                       builder: (BuildContext context,
//                           AsyncSnapshot<QuerySnapshot> snapshot) {
//                         if (!snapshot.hasData) {
//                           return const Center(
//                             child: CircularProgressIndicator(),
//                           );
//                         } else {
//                           var data = snapshot.data?.docs;
//                           return SizedBox(
//                             height: 150,
//                             child: GridView.builder(
//                               shrinkWrap: true,
//                               // physics: const NeverScrollableScrollPhysics(),
//                               gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 2,
//                                 mainAxisSpacing: TSizes.gridViewSpacing,
//                                 crossAxisSpacing: TSizes.gridViewSpacing,
//                                 mainAxisExtent: 220,
//                               ),
//                               physics: const BouncingScrollPhysics(),
//                               scrollDirection: Axis.vertical,
//                               itemCount: data?.length ?? 0,
//                               itemBuilder: (context, index) {
//                                 return DoctorCardVertical(
//                                   image: doctor,
//                                   subtitle: data![index]['docCategory'],
//                                   title: data[index]['docName'],
//                                   onTap: () {
//                                     Get.to(() => DoctorProfileView(
//                                       doc: data[index],
//                                     ));
//                                   },
//
//
//                                 );
//                               },
//                             ),
//                           );
//                         }
//                       },
//                     ),
//
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }