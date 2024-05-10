import 'package:get/get.dart';
import 'package:graduateproject/utils/consts/consts.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/app_bar/appbar.dart';
import '../../../../common/widgets/common_images/circular_image.dart';
import '../../../../common/widgets/custom_shapes/contianers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tiles.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../App/screens/Schedule/views/upcoming_schedule.dart';
import '../../../authentication/controllers/auth_controller.dart';
import '../../controllers/setting_controller.dart';
import '../profile/profile.dart';

class SettigsView extends StatelessWidget {
  const SettigsView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(SettingController());
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    //-- Header
                    PrimaryHeaderContainer(
                      height: 200,
                      child: Column(
                        children: [
                          AppBarWidget(
                            title: Text(
                              "Account",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .apply(color: MColors.white),
                            ),
                          ),
                          ListTile(
                            leading: const CircularImage(
                                image: TImages.Profile,
                                width: 50,
                                height: 50,
                                padding: 0),
                            title: Text(controller.username.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .apply(color: MColors.white)),
                            subtitle: Text(controller.email.value,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .apply(color: MColors.white)),
                            trailing: IconButton(
                                onPressed: () {
                                  Get.to(() => const ProfileScreen());
                                },
                                icon: const Icon(
                                  Iconsax.edit,
                                  color: MColors.white,
                                )),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                        ],
                      ),
                    ),
                    //-- Body
                    Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: Column(
                        children: [
                          const SectionHeading(
                            title: "Account Setting",
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          SettingMenuTiles(
                            icon: Iconsax.book,
                            title: 'My Appointments',
                            subtitle: 'Set of your Appointments',
                            ontap: () => Get.to(() => const Upcomingschedule()),
                          ),
                          SettingMenuTiles(
                            icon: Iconsax.notification,
                            title: 'Notification',
                            subtitle: 'set any kind of Notification messages',
                            ontap: () {},
                          ),
                          SettingMenuTiles(
                            icon: Iconsax.security_card,
                            title: 'Account Privacy',
                            subtitle:
                                'manage data usage and connected accounts',
                            ontap: () {},
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          const SectionHeading(
                            title: "App Setting",
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          SettingMenuTiles(
                            icon: Iconsax.document_upload,
                            title: 'Load Data',
                            subtitle: 'upload data to your cloud firebase',
                            ontap: () {},
                          ),
                          SettingMenuTiles(
                            icon: Iconsax.location,
                            title: 'Geolocation',
                            subtitle: 'set recommandaion based on location',
                            trailing: Switch(
                              value: true,
                              onChanged: (value) {},
                            ),
                          ),
                          SettingMenuTiles(
                            icon: Iconsax.security_user,
                            title: 'safe mode',
                            subtitle: 'set recommandaion based on location',
                            trailing: Switch(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          SettingMenuTiles(
                            icon: Iconsax.image,
                            title: 'HD Image Quality',
                            subtitle: 'set image quality to been seen',
                            trailing: Switch(
                              value: false,
                              onChanged: (value) {},
                            ),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                AuthController().signout();
                              },
                              child: const Text("Logout"),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
