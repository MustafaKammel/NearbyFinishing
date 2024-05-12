import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../common/widgets/app_bar/appbar.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../views/appointment_details_view/appointment_details_view.dart';
import '../../../../authentication/controllers/auth_controller.dart';
import '../../../controllers/appointment_controller.dart';

class Upcomingschedule extends StatelessWidget {
  final bool isDoctor;
  const Upcomingschedule({super.key, this.isDoctor = false});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmnetController());
    final dark = THelperFunctions.isDarkMode(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: false,
        leadingOnPress: () => Get.back(),
        title: Text(
          "My Appoinments",
          style: Theme.of(context).textTheme.headlineMedium,
        ),

      ),

      body:StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance
              .collection('appointments')
              .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            DateTime end, start;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data?.docs;
              if (data!.isEmpty) {
                return Center(
                  child: Text(
                    'No appointments!',
                    style: TextStyle(
                      fontSize: 18, // Adjust font size as needed
                      fontWeight: FontWeight.bold, // Make the text bold
                      color: Colors.grey[600], // Set text color to grey
                    ),
                    textAlign: TextAlign.center, // Center-align the text
                  ),
                );

              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    end = DateTime.parse(
                        snapshot.data!.docs[index]['bookingEnd'].toString());
                    start = DateTime.parse(
                        snapshot.data!.docs[index]['bookingStart'].toString());
                    var timestart = DateFormat('hh:mm a').format(start);
                    var timeend = DateFormat('hh:mm a').format(end);
                    var datestart = DateFormat('dd-MM-yyyy').format(start);
                    var dateend = DateFormat('dd-MM-yyyy').format(end);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: dark ? MColors.darkContainer : MColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              ),
                            ]),
                        child: SizedBox(
                          width: size.width,
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () => Get.to(
                                  () => AppointmentDetailsView(
                                    doc: data[index],
                                  ),
                                ),
                                title: Text(
                                  data![index]['userName'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                        color: dark
                                            ? MColors.white
                                            : MColors.black,
                                      ),
                                ),
                                subtitle: Text(
                                  "${data[index]['serviceName']}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .apply(
                                        color: dark
                                            ? MColors.white
                                            : MColors.black,
                                      ),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('appointments')
                                          .doc(data[index].id)
                                          .delete();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                                leading: const CircleAvatar(
                                  radius: 25,
                                  backgroundImage: AssetImage(
                                      "assets/images/doctoricon.png"),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  thickness: 1,
                                  height: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month,
                                        color: dark
                                            ? MColors.white
                                            : MColors.black,
                                      ),
                                      const SizedBox(
                                        width: TSizes.xs,
                                      ),
                                      Text(
                                        datestart,
                                        style: TextStyle(
                                          color: dark
                                              ? MColors.white
                                              : MColors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_filled,
                                            color: dark
                                                ? MColors.white
                                                : MColors.black,
                                          ),
                                          const SizedBox(
                                            width: TSizes.xs,
                                          ),
                                          Text(
                                            timestart,
                                            style: TextStyle(
                                              color: dark
                                                  ? MColors.white
                                                  : MColors.black,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                            color: Colors.green,
                                            shape: BoxShape.circle),
                                      ),
                                      const SizedBox(
                                        width: TSizes.xs,
                                      ),
                                      Text(
                                        "Confirmed",
                                        style: TextStyle(
                                          color: dark
                                              ? MColors.white
                                              : MColors.black,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: TSizes.md,
                              ),
                              const SizedBox(
                                height: TSizes.md,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );

                    //  ListTile(
                    //   onTap: () => Get.to(
                    //     () => AppointmentDetailsView(
                    //       doc: data[index],
                    //     ),
                    //   ),
                    //   leading: const CircleAvatar(
                    //     backgroundImage:
                    //         AssetImage("assets/images/doctoricon.png"),
                    //   ),
                    //   title: AppStyle.bold(
                    //       title: data![index]
                    //           [!isDoctor ? 'appWithName' : 'appName']),
                    //   subtitle: AppStyle.normal(
                    //     title:
                    //         "${data[index]['appDay']} - ${data[index]['appTime']}",
                    //     color: Colors.black.withOpacity(0.5),
                    //   ),
                    // );
                  },
                ),
              );
            }
          }),
    );
    //       ],
    //     ),
    //   ),
    // );
  }
}

/**
 *
 * Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: dark ? MColors.darkContainer : MColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ]),
      child: SizedBox(
        width: size.width,
        child: Column(
          children: [
            ListTile(
              title: Text(
                data![index],
                style: Theme.of(context).textTheme.bodyLarge!.apply(
                      color: dark ? MColors.white : MColors.black,
                    ),
              ),
              subtitle: Text(
               "${data[index]['appDay']} - ${data[index]['appTime']}",
                style: Theme.of(context).textTheme.labelSmall!.apply(
                      color: dark ? MColors.white : MColors.black,
                    ),
              ),
              leading: const CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/doctoricon.png"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                thickness: 1,
                height: 20,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: dark ? MColors.white : MColors.black,
                    ),
                    const SizedBox(
                      width: TSizes.xs,
                    ),
                    Text(
                      "9/12/2023",
                      style: TextStyle(
                        color: dark ? MColors.white : MColors.black,
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          color: dark ? MColors.white : MColors.black,
                        ),
                        const SizedBox(
                          width: TSizes.xs,
                        ),
                        Text(
                          "12:21 PM",
                          style: TextStyle(
                            color: dark ? MColors.white : MColors.black,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                    const SizedBox(
                      width: TSizes.xs,
                    ),
                    Text(
                      "Confirmed",
                      style: TextStyle(
                        color: dark ? MColors.white : MColors.black,
                      ),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: TSizes.md,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: dark ? MColors.grey : const Color(0xffD3E6FF),
                        borderRadius: BorderRadius.circular(40)),
                    child: const Center(
                        child: Text(
                      "Cancel",
                      style: TextStyle(color: MColors.primary),
                    )),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 140,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: MColors.primary,
                        borderRadius: BorderRadius.circular(40)),
                    child: const Center(
                        child: Text(
                      "Rescedule",
                      style: TextStyle(color: MColors.white),
                    )),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: TSizes.md,
            ),
          ],
        ),
      ),
    );
 *
 *
 *
 *
 *
 * class AppointmentView extends StatelessWidget {
  final bool isDoctor;
  const AppointmentView({super.key, this.isDoctor = false});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AppointmnetController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: AppStyle.bold(
            size: 18,
            title: "Appoinments",
            color: AppColor.whiteColor,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  AuthController().signout();
                },
                icon: const Icon(Icons.power_settings_new_rounded))
          ],
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: controller.getAppointments(isDoctor),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var data = snapshot.data?.docs;

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  itemCount: data?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      onTap: () => Get.to(
                        () => AppointmentDetailsView(
                          doc: data[index],
                        ),
                      ),
                      leading: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/doctoricon.png"),
                      ),
                      title: AppStyle.bold(
                          title: data![index]
                              [!isDoctor ? 'appWithName' : 'appName']),
                      subtitle: AppStyle.normal(
                        title:
                            "${data[index]['appDay']} - ${data[index]['appTime']}",
                        color: Colors.black.withOpacity(0.5),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}

 *
 */