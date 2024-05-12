import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../../common/widgets/Doctors/doctor_card_vertical.dart';
import '../../../../views/doctor_profile_view/doctor_profile_view.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "  My Favorite Doctors",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('doctors').where('isFavorite', isEqualTo: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No favorite doctors found.'));
          }
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var data = snapshot.data?.docs;
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 220,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: data?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return DoctorCardVertical(
                    image: 'assets/images/doctors/doctor_1.jpg',
                    subtitle: data![index]['docCategory'],
                    title: data[index]['docName'],
                    onTap: () {
                      Get.to(() => DoctorProfileView(
                        doc: data[index],
                      ));
                    },
                    isFavorite: data[index]['isFavorite'] ?? false,
                  );

                },
              ),
            );
          }
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:graduateproject/utils/constants/sizes.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../../../../common/widgets/Doctors/doctor_card_vertical.dart';
// import '../../../../../../common/widgets/app_bar/appbar.dart';
// import '../../../../../../common/widgets/custom_icons/circular_icon.dart';
// import '../Home/widgets/home_lists.dart';
//
// class FavoriteScreen extends StatelessWidget {
//   const FavoriteScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBarWidget(
//         title: Text(
//           "WishList",
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         actions: [
//           CircularIcon(
//             icon: Iconsax.add,
//             onpress: () => Navigator.pop(context),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.defaultSpace),
//           child: Column(
//             children: [
//               GridView.builder(
//                 itemCount: 6,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   mainAxisSpacing: TSizes.gridViewSpacing,
//                   crossAxisSpacing: TSizes.gridViewSpacing,
//                   mainAxisExtent: 220,
//                 ),
//                 itemBuilder: (context, index) => DoctorCardVertical(
//                   title: HomeLists.title[index],
//                   subtitle: HomeLists.subTitle[index],
//                   image: HomeLists.images[index],
//                   isFavorite: false,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
