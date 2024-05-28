import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduateproject/features/authentication/controllers/home_controller.dart';
import 'package:graduateproject/utils/constants/colors.dart';
import 'package:graduateproject/utils/constants/sizes.dart';
import 'package:graduateproject/utils/constants/text_strings.dart';
import 'package:graduateproject/utils/helpers/helper_functions.dart';
import 'package:graduateproject/views/doctor_profile_view/doctor_profile_view.dart';
import '../../../../../../common/widgets/custom_shapes/contianers/primary_header_container.dart';
import '../../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../../common/widgets/Doctors/doctor_card_vertical.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';
import 'widgets/home_search.dart';
import 'widgets/promo_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isConnected = true; // Initially assume internet connection exists
  late HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(HomeController());
    _checkInternetConnection();
  }

  Future<void> _checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No Internet Connection",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _checkInternetConnection();
                },
                child: Text("Retry"),
              ),
            ],
          ),
        ),
      );
    }

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
                    future: _controller.getDoctorList(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('No Data Available'),
                        );
                      } else {
                        var data = snapshot.data?.docs;
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: GridView.builder(
                            shrinkWrap: true,
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
                                docId: data![index]['docId'],
                                title: data![index]['docName'],
                                subtitle: data[index]['docCategory'],
                                image: 'assets/images/doctors/doctor_1.jpg',
                                isFavorite: data[index]['isFavorite'] ?? false,
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
