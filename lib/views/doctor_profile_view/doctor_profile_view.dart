import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduateproject/utils/constants/colors.dart';
import 'package:graduateproject/utils/helpers/helper_functions.dart';
import 'package:graduateproject/views/book_appointment_view/book_appointment_view.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/widgets/app_bar/appbar.dart';
import '../../utils/constants/text_strings.dart';

class DoctorProfileView extends StatelessWidget {
  final DocumentSnapshot doc;

  const DoctorProfileView({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? MColors.darkerGrey : MColors.grey,
      appBar: AppBarWidget(
        showBackArrow: true,
        leadingOnPress: () => Get.back(),
        title: Text(
          "Doctor Details",
          style: dark
              ? Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: MColors.white)
              : Theme.of(context)
              .textTheme
              .headlineMedium!
              .apply(color: MColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/doctor.jpg"),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  doc['docName'],
                  style: TextStyle(
                    color: dark ? MColors.white : MColors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  doc['docCategory'],
                  style: TextStyle(
                    color: dark ? MColors.white : MColors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: dark ? MColors.dark : MColors.light,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.call,
                          color: dark ? MColors.white : MColors.black,
                          size: 25,
                        ),
                        onPressed: () async {
                          final url = 'tel:${doc['docPhone']}';
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      decoration: BoxDecoration(
                        color: dark ? MColors.dark : MColors.light,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.chat_bubble_text_fill,
                          color: dark ? MColors.white : MColors.black,
                          size: 25,
                        ),
                        onPressed: () async {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: size.height / 1.5,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 15, top: 20),
                  decoration: const BoxDecoration(
                      color: MColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Rating",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // استخدم أداة التقييم التي ترغب بها هنا
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "About Doctor",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            doc['docAbout'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Phone Number",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            doc['docPhone'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Email",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            doc['docEmail'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Address",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            doc['docAddress'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Timing from",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            doc['docTimingfrom'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const Text(
                            "Timing to",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            doc['docTimingto'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Services",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            doc['docService'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Location",
                            style: TextStyle(
                              color: MColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xFFF0EEFA),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.location_on,
                                color: MColors.primary,
                                size: 30,
                              ),
                            ),
                            title: Text(
                              doc['docAddress'],
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: const Text(
                              "address line of the medical center",
                            ),
                          )
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(15),
        height: 130,
        decoration: const BoxDecoration(color: MColors.white, boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, spreadRadius: 2),
        ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Consultation price",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                Text(
                  "${doc['docSalary']} LE",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  Get.to(() => BookAppointmentView(
                    docId: doc['docId'],
                    docName: doc['docName'],
                    amount: double.parse(
                      doc['docSalary'].toString(),
                    ),
                    Services: doc['docService'],
                  ));
                },
                child: const Text(
                  TTexts.bookAppointment,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
