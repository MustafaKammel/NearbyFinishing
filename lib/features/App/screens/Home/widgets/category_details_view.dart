import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:graduateproject/views/doctor_profile_view/doctor_profile_view.dart';

import '../../../../../common/widgets/Doctors/doctor_card_vertical.dart';
import '../../../../../common/widgets/app_bar/appbar.dart';
import '../../../../../utils/consts/consts.dart';

class CategoryDetailsView extends StatelessWidget {
  final String catName;
  const CategoryDetailsView({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        leadingOnPress: () => Get.back(),
        title: Text(
          catName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   title:
      //       AppStyle.bold(size: 18, title: catName, color: AppColor.whiteColor),
      // ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('doctors')
            .where('docCategory', isEqualTo: catName)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    image: doctor,
                    subtitle: data![index]['docCategory'],
                    title: data[index]['docName'],
                    onTap: () {
                      Get.to(() => DoctorProfileView(
                            doc: data[index],
                          ));
                    },
                  );
                  // return Container(
                  //   padding: const EdgeInsets.only(left: 10, bottom: 10),
                  //   clipBehavior: Clip.hardEdge,
                  //   decoration: BoxDecoration(
                  //       color: Colors.black12,
                  //       borderRadius: BorderRadius.circular(16)),
                  //   margin: const EdgeInsets.only(right: 8),
                  //   width: 150,
                  //   height: 100,
                  //   child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Container(
                  //           alignment: Alignment.center,
                  //           child: Image.asset(
                  //             doctor,
                  //             width: 170,
                  //             scale: 50,
                  //             fit: BoxFit.cover,
                  //           ),
                  //         ),
                  //         5.heightBox,
                  //         AppStyle.normal(
                  //             title: data![index]['docName'],
                  //             color: Colors.black),
                  //         VxRating(
                  //           onRatingUpdate: (value) {},
                  //           count: 5,
                  //           value: double.parse(
                  //               data[index]['docRating'].toString()),
                  //           stepInt: true,
                  //           selectionColor: Colors.yellowAccent,
                  //           maxRating: 5,
                  //         ),
                  //       ]),
                  // ).onTap(() {
                  //   Get.to(() => DoctorProfileView(doc: data[index]));
                  // });
                },
              ),
            );
          }
        },
      ),
    );
  }
}
