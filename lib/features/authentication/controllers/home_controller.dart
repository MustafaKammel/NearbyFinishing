import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:graduateproject/utils/consts/consts.dart';

class HomeController extends GetxController {
  var searchQueryController = TextEditingController();
  var isLoading = false.obs;
  Future<QuerySnapshot<Map<String, dynamic>>> getDoctorList() async {
    var doctors = FirebaseFirestore.instance.collection('doctors').get();
    return doctors;
  }

  static HomeController get instance => Get.find();

  // variables
  final carsoulCurrentIndex = 0.obs;

  // jump to spasificdot selected page
  void updatePageIndicator(index) {
    carsoulCurrentIndex.value = index;
  }
}
