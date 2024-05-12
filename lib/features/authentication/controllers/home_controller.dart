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

  // تحديث حالة isFavorite للطبيب المحدد
  Future<void> toggleFavoriteStatus(String doctorId) async {
    try {
      // احصل على مرجع لمستند الطبيب
      var doctorRef = FirebaseFirestore.instance.collection('doctors').doc(doctorId);

      // احصل على بيانات الطبيب
      var doctorSnapshot = await doctorRef.get();
      if (!doctorSnapshot.exists) {
        return; // تأكد من أن المستند موجود
      }

      // احصل على قيمة isFavorite الحالية وقم بتبديلها
      bool isFavorite = doctorSnapshot.data()?['isFavorite'] ?? false;
      await doctorRef.update({'isFavorite': !isFavorite});
    } catch (e) {
      print('Error toggling favorite status: $e');
      // يمكنك إدراج معالجة الأخطاء هنا
    }
  }

  static HomeController get instance => Get.find();

  // variables
  final carsoulCurrentIndex = 0.obs;

  // jump to spasificdot selected page
  void updatePageIndicator(index) {
    carsoulCurrentIndex.value = index;
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:graduateproject/utils/consts/consts.dart';
//
// class HomeController extends GetxController {
//   var searchQueryController = TextEditingController();
//   var isLoading = false.obs;
//   Future<QuerySnapshot<Map<String, dynamic>>> getDoctorList() async {
//     var doctors = FirebaseFirestore.instance.collection('doctors').get();
//     return doctors;
//   }
//
//   static HomeController get instance => Get.find();
//
//   // variables
//   final carsoulCurrentIndex = 0.obs;
//
//   // jump to spasificdot selected page
//   void updatePageIndicator(index) {
//     carsoulCurrentIndex.value = index;
//   }
// }
