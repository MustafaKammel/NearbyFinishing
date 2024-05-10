import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduateproject/features/authentication/controllers/home_controller.dart';
import 'package:graduateproject/utils/constants/colors.dart';

import '../../../../../../../common/widgets/custom_shapes/contianers/circular_container.dart';
import '../../../../../../../common/widgets/common_images/rounded_image.dart';
import '../../../../../../../utils/constants/image_string.dart';
import '../../../../../../../utils/constants/sizes.dart';


class PromoSlider extends StatelessWidget {
  const PromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, context) =>
                  controller.updatePageIndicator(index),
              viewportFraction: 1,
            ),
            items: const [
              RoundedImage(
                imagUrl: TImages.PromoBanner2,
              ),
              RoundedImage(
                imagUrl: TImages.PromoBanner2,
              ),
              RoundedImage(
                imagUrl: TImages.PromoBanner3,
              ),
            ]),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 3; i++)
                  CircularContainer(
                    width: 20,
                    height: 4,
                    backgroundcolor: controller.carsoulCurrentIndex.value == i
                        ? MColors.primary
                        : MColors.grey,
                    margin: const EdgeInsets.only(right: 10),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
