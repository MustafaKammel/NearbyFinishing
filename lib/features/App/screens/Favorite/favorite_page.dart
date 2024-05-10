import 'package:flutter/material.dart';
import 'package:graduateproject/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../../common/widgets/Doctors/doctor_card_vertical.dart';
import '../../../../../../common/widgets/app_bar/appbar.dart';
import '../../../../../../common/widgets/custom_icons/circular_icon.dart';
import '../Home/widgets/home_lists.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Text(
          "WishList",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onpress: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              GridView.builder(
                itemCount: 6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: TSizes.gridViewSpacing,
                  crossAxisSpacing: TSizes.gridViewSpacing,
                  mainAxisExtent: 220,
                ),
                itemBuilder: (context, index) => DoctorCardVertical(
                  title: HomeLists.title[index],
                  subtitle: HomeLists.subTitle[index],
                  image: HomeLists.images[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
