import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../common/widgets/app_bar/appbar.dart';
import '../../utils/consts/consts.dart';

class AppointmentDetailsView extends StatelessWidget {
  final DocumentSnapshot doc;
  const AppointmentDetailsView({super.key, required this.doc});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        leadingOnPress: () => Get.back(),
        title: Text(
          doc['appWithName'],
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyle.bold(title: "Select appointment day",size: 16),
              5.heightBox,
              AppStyle.normal(title: doc['appDay']),
              10.heightBox,
              AppStyle.bold(title: "Select appointment time",size: 16),
              5.heightBox,
              AppStyle.normal(title: doc['appTime']),
              20.heightBox,
              AppStyle.bold(title: "Mobile Number",size: 16),
              5.heightBox,
              AppStyle.normal(title: doc['appMobile']),
              10.heightBox,
              AppStyle.bold(title: "Full Name",size: 16),
              5.heightBox,
              AppStyle.normal(title: doc['appName']),
              10.heightBox,
              AppStyle.bold(title: "Message:",size: 16),
              5.heightBox,
              AppStyle.normal(title: doc['appMsg']),
            ],
          ),
        ),
      ),
    );
  }
}
