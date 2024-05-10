import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import '../../../../common/widgets/app_bar/appbar.dart';
import '../../../../common/widgets/common_images/circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        showBackArrow: true,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const CircularImage(
                    image: TImages.Profile,
                    width: 80,
                    height: 80,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("change profile picture"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),
            const SectionHeading(
                title: "profile Informations", showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems),
            ProfileMenu(onTap: () {}, title: "Name", value: "Karam Mahmoud Salama"),
            ProfileMenu(
                onTap: () {}, title: "User Name", value: "Karam Salama"),
            const SizedBox(height: TSizes.spaceBtwItems),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),
            const SectionHeading(
                title: "Personal Informations", showActionButton: false),
            const SizedBox(height: TSizes.spaceBtwItems),
            ProfileMenu(
              onTap: () {},
              title: "User Id",
              value: "2024",
              icon: Iconsax.copy,
            ),
            ProfileMenu(
                onTap: () {},
                title: "E-mail",
                value: "Karamslama244@gmail.com"),
            ProfileMenu(
                onTap: () {}, title: "Phone Number", value: "01027547215"),
            ProfileMenu(onTap: () {}, title: "Gender", value: "Male"),
            ProfileMenu(
                onTap: () {}, title: "Date of Birth", value: "2/2/2002"),
            const Divider(),
            const SizedBox(height: TSizes.spaceBtwItems),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Close Account",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
