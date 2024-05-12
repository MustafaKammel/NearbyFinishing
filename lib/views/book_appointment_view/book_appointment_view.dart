import 'package:booking_calendar/booking_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:graduateproject/views/payment/stripe_payment/payment_manager.dart';
import 'package:intl/intl.dart';
import '../../common/widgets/app_bar/appbar.dart';
import '../../utils/consts/consts.dart';
import '../../features/App/controllers/appointment_controller.dart';

class BookAppointmentView extends StatefulWidget {
  final String docId;
  final String docName;
  final double amount;

  final String Services;

  const BookAppointmentView(
      {super.key,
        required this.docName,
        required this.docId,
        required this.amount,
        required this.Services});

  @override
  State<BookAppointmentView> createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  final now = DateTime.now();
  late BookingService mockBookingService;

  List<String> days = [];
  List<int>? numbers;

  List<int>? daysInt;
  DateTime? from = DateTime.now(),
      to = DateTime.now().add(Duration(minutes: 15));
  DateTime Now = DateTime.now();
  var Date = DateFormat("yyyy-MM-dd").format(DateTime.now());
  String datefrom = '';
  String dateto = '';
  int? fromhour, tohour;
  String? Username;
  String? UserId, UserEmail, UserPhonenumber;

  void timefromto(var docto, var docfrom) async {
    datefrom = '$Date ${docfrom.toString()}';

    from = DateTime.parse(datefrom);

    dateto = '$Date ${docto.toString()}';

    to = DateTime.parse(dateto);

    fromhour = from!.hour;
    tohour = to!.hour;

    print(from!.hour.toString() + " ......" + to!.hour.toString());

    print(from.toString() + " ......" + to.toString());
  }

  @override
  void initState() {
    super.initState();
    // DateTime.now().startOfDay
    // DateTime.now().endOfDay

    FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.docId)
        .get()
        .then((value) {
      setState(() {
        days = value.data()!['availableDays'].cast<String>();
      });
    }).then((value) {
      numbers = List<int>.filled(days.length, 0);
      for (int i = 0; i < days.length; i++) {
        if (days[i] == 'Sunday') {
          numbers![i] = 7;
        }
        if (days[i] == 'Monday') {
          numbers![i] = 1;
        }
        if (days[i] == 'Tuesday') {
          numbers![i] = 2;
        }
        if (days[i] == 'Wednesday') {
          numbers![i] = 3;
        }
        if (days[i] == 'Thursday') {
          numbers![i] = 4;
        }
        if (days[i] == 'Friday') {
          numbers![i] = 5;
        }
        if (days[i] == 'Saturday') {
          numbers![i] = 6;
        }
      }

      print(numbers.toString() + "hhhhhhhhhhhhhhhhh");

      daysInt = List<int>.filled(7 - days.length, 0);
      int count = 0;
      for (int i = 0; i < 7; i++) {
        if (numbers!.contains(i)) {
        } else {
          // daysInt?.add(i);
          setState(() {
            daysInt![count] = i;
            count++;
          });
        }
      }
    });
    // daysInt!.sort();

    // timefromto();
    if (FirebaseAuth.instance.currentUser != null) {
      UserId = FirebaseAuth.instance.currentUser!.uid;
      UserEmail = FirebaseAuth.instance.currentUser!.email;
      UserPhonenumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    }

    FirebaseFirestore.instance
        .collection('appointments')
        .where('serviceId', isEqualTo: widget.docId)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        var end = DateTime.parse(element.data()['bookingEnd']);
        var start = DateTime.parse(element.data()['bookingStart']);
        converted.add(DateTimeRange(
          end: end,
          start: start,
        ));
      });
    });
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return Stream.value([]);
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    BookingService book = BookingService(
      bookingStart: newBooking.bookingStart,
      bookingEnd: newBooking.bookingEnd,
      serviceName: widget.Services,
      serviceDuration: newBooking.serviceDuration,
      userId: UserId,
      serviceId: widget.docId,
      servicePrice: widget.amount.toInt(),
      userName: widget.docName,
      userEmail: UserEmail,
      userPhoneNumber: UserPhonenumber,
    );
    try {
      await PaymentManager.makePayment(widget.amount, "egp");

      await Future.delayed(const Duration(seconds: 1));
      converted.add(DateTimeRange(
          start: newBooking.bookingStart, end: newBooking.bookingEnd));
      print(newBooking.bookingEnd.toString() +
          '+++++++....' +
          newBooking.bookingStart.toString());
      print('${book.toJson()} has been uploaded');

      await FirebaseFirestore.instance
          .collection('appointments')
          .add(book.toJson());
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    // DateTime first = now;
    // DateTime tomorrow = now.add(const Duration(days: 1));
    // DateTime second = now.add(const Duration(minutes: 55));
    // DateTime third = now.subtract(const Duration(minutes: 240));
    // DateTime fourth = now.subtract(const Duration(minutes: 500)); //booked
    // converted.add(
    //     DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    // converted.add(DateTimeRange(
    //     start: second, end: second.add(const Duration(minutes: 23))));
    // converted.add(DateTimeRange(
    //     start: third, end: third.add(const Duration(minutes: 15))));
    // converted.add(DateTimeRange(
    //     start: fourth, end: fourth.add(const Duration(minutes: 30)))); //booked

    // //book whole day example
    // converted.add(DateTimeRange(
    //     start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
    //     end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    return converted;
  }

  @override
  Widget build(BuildContext context) {
    print(daysInt.toString() + "build context");
    var controller = Get.put(AppointmnetController());
    return Scaffold(
      appBar: AppBarWidget(
        showBackArrow: true,
        leadingOnPress: () => Get.back(),
        title: Text(
          "Dr ${widget.docName}",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('doctors')
              .where('docId', isEqualTo: widget.docId)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
              timefromto(snapshot.data.docs[0]['docTimingto'],
                  snapshot.data.docs[0]['docTimingfrom']);
            } else {
              // Handle the case where data is not available
              return const Text('No data available');
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: BookingCalendar(
                  bookingService: BookingService(
                      serviceName: 'Mock Service',
                      serviceDuration: 15,
                      bookingEnd: DateTime(
                          now.year, now.month, now.day, tohour ?? 0, 0),
                      bookingStart: DateTime(
                          now.year, now.month, now.day, fromhour ?? 0, 0)),
                  convertStreamResultToDateTimeRanges: convertStreamResultMock,
                  getBookingStream: getBookingStreamMock,
                  uploadBooking: uploadBookingMock,
                  pauseSlots: generatePauseSlots(),
                  pauseSlotText: 'LUNCH',
                  hideBreakTime: false,
                  loadingWidget: const Text('Fetching data...'),
                  uploadingWidget:
                  Center(child: const CircularProgressIndicator.adaptive()),
                  locale: 'en',
                  startingDayOfWeek: StartingDayOfWeek.saturday,
                  wholeDayIsBookedWidget:
                  const Text('Sorry, for this day everything is booked'),
                  disabledDays: numbers ?? [],
                ),
              ),
            );
          }),
    );
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      // DateTimeRange(
      //     start: DateTime(now.year, now.month, now.day, 12, 0),
      //     end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }
}


// import 'package:booking_calendar/booking_calendar.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:graduateproject/features/App/screens/chat/firebase/fire_auth.dart';
//
// import 'package:graduateproject/utils/constants/sizes.dart';
// import 'package:graduateproject/views/payment/stripe_payment/payment_manager.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:intl/intl.dart';
//
// import '../../common/widgets/app_bar/appbar.dart';
// import '../../utils/consts/consts.dart';
// import '../../features/App/controllers/appointment_controller.dart';
//
// class BookAppointmentView extends StatefulWidget {
//   final String docId;
//   final String docName;
//   final double amount;
//
//   final String Services;
//
//   const BookAppointmentView(
//       {super.key,
//       required this.docName,
//       required this.docId,
//       required this.amount,
//       required this.Services});
//
//   @override
//   State<BookAppointmentView> createState() => _BookAppointmentViewState();
// }
//
// class _BookAppointmentViewState extends State<BookAppointmentView> {
//   final now = DateTime.now();
//   late BookingService mockBookingService;
//
//   List<String> days = [];
//   List<int>? numbers;
//
//   List<int>? daysInt;
//   DateTime? from = DateTime.now(),
//       to = DateTime.now().add(Duration(minutes: 15));
//   DateTime Now = DateTime.now();
//   var Date = DateFormat("yyyy-MM-dd").format(DateTime.now());
//   String datefrom = '';
//   String dateto = '';
//   int? fromhour, tohour;
//   String? Username;
//   String? UserId, UserEmail, UserPhonenumber;
//
//   void timefromto(var docto, var docfrom) async {
//     datefrom = '$Date ${docfrom.toString()}';
//
//     from = DateTime.parse(datefrom);
//
//     dateto = '$Date ${docto.toString()}';
//
//     to = DateTime.parse(dateto);
//
//     fromhour = from!.hour;
//     tohour = to!.hour;
//
//     print(from!.hour.toString() + " ......" + to!.hour.toString());
//
//     print(from.toString() + " ......" + to.toString());
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // DateTime.now().startOfDay
//     // DateTime.now().endOfDay
//
//     FirebaseFirestore.instance
//         .collection('doctors')
//         .doc(widget.docId)
//         .get()
//         .then((value) {
//       setState(() {
//         days = value.data()!['availableDays'].cast<String>();
//       });
//     }).then((value) {
//       numbers = List<int>.filled(days.length, 0);
//       for (int i = 0; i < days.length; i++) {
//         if (days[i] == 'Sunday') {
//           numbers![i] = 7;
//         }
//         if (days[i] == 'Monday') {
//           numbers![i] = 1;
//         }
//         if (days[i] == 'Tuesday') {
//           numbers![i] = 2;
//         }
//         if (days[i] == 'Wednesday') {
//           numbers![i] = 3;
//         }
//         if (days[i] == 'Thursday') {
//           numbers![i] = 4;
//         }
//         if (days[i] == 'Friday') {
//           numbers![i] = 5;
//         }
//         if (days[i] == 'Saturday') {
//           numbers![i] = 6;
//         }
//       }
//
//       print(numbers.toString() + "hhhhhhhhhhhhhhhhh");
//
//       daysInt = List<int>.filled(7 - days.length, 0);
//       int count = 0;
//       for (int i = 0; i < 7; i++) {
//         if (numbers!.contains(i)) {
//         } else {
//           // daysInt?.add(i);
//           setState(() {
//             daysInt![count] = i;
//             count++;
//           });
//         }
//       }
//     });
//     // daysInt!.sort();
//
//     // timefromto();
//
//     UserId = FirebaseAuth.instance.currentUser!.uid;
//     Username = FirebaseAuth.instance.currentUser!.displayName;
//     UserEmail = FirebaseAuth.instance.currentUser!.email;
//     UserPhonenumber = FirebaseAuth.instance.currentUser!.phoneNumber;
//
//     FirebaseFirestore.instance
//         .collection('appointments')
//         .where('serviceId', isEqualTo: widget.docId)
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         var end = DateTime.parse(element.data()['bookingEnd']);
//         var start = DateTime.parse(element.data()['bookingStart']);
//         converted.add(DateTimeRange(
//           end: end,
//           start: start,
//         ));
//       });
//     });
//   }
//
//   Stream<dynamic>? getBookingStreamMock(
//       {required DateTime end, required DateTime start}) {
//     return Stream.value([]);
//   }
//
//   Future<dynamic> uploadBookingMock(
//       {required BookingService newBooking}) async {
//     BookingService book = BookingService(
//       bookingStart: newBooking.bookingStart,
//       bookingEnd: newBooking.bookingEnd,
//       serviceName: widget.Services,
//       serviceDuration: newBooking.serviceDuration,
//       userId: UserId,
//       serviceId: widget.docId,
//       servicePrice: widget.amount.toInt(),
//       userName: widget.docName,
//       userEmail: UserEmail,
//       userPhoneNumber: UserPhonenumber,
//     );
//     try {
//       await PaymentManager.makePayment(widget.amount, "egp");
//
//       await Future.delayed(const Duration(seconds: 1));
//       converted.add(DateTimeRange(
//           start: newBooking.bookingStart, end: newBooking.bookingEnd));
//       print(newBooking.bookingEnd.toString() +
//           '+++++++....' +
//           newBooking.bookingStart.toString());
//       print('${book.toJson()} has been uploaded');
//
//       await FirebaseFirestore.instance
//           .collection('appointments')
//           .add(book.toJson());
//     } on FirebaseException catch (e) {
//       throw e;
//     }
//   }
//
//   List<DateTimeRange> converted = [];
//
//   List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
//     ///here you can parse the streamresult and convert to [List<DateTimeRange>]
//     ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
//     ///disabledDays will properly work with real data
//     // DateTime first = now;
//     // DateTime tomorrow = now.add(const Duration(days: 1));
//     // DateTime second = now.add(const Duration(minutes: 55));
//     // DateTime third = now.subtract(const Duration(minutes: 240));
//     // DateTime fourth = now.subtract(const Duration(minutes: 500)); //booked
//     // converted.add(
//     //     DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
//     // converted.add(DateTimeRange(
//     //     start: second, end: second.add(const Duration(minutes: 23))));
//     // converted.add(DateTimeRange(
//     //     start: third, end: third.add(const Duration(minutes: 15))));
//     // converted.add(DateTimeRange(
//     //     start: fourth, end: fourth.add(const Duration(minutes: 30)))); //booked
//
//     // //book whole day example
//     // converted.add(DateTimeRange(
//     //     start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
//     //     end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
//     return converted;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print(daysInt.toString() + "build context");
//     var controller = Get.put(AppointmnetController());
//     return Scaffold(
//       appBar: AppBarWidget(
//         showBackArrow: true,
//         leadingOnPress: () => Get.back(),
//         title: Text(
//           "Dr ${widget.docName}",
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//       ),
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('doctors')
//               .where('docId', isEqualTo: widget.docId)
//               .snapshots(),
//           builder: (context, AsyncSnapshot snapshot) {
//             // timefromto(snapshot);
//
//             if (snapshot.hasData) {
//               timefromto(snapshot.data.docs[0]['docTimingto'],
//                   snapshot.data.docs[0]['docTimingfrom']);
//             }
//             return snapshot.connectionState == ConnectionState.waiting
//                 ? const Center(child: CircularProgressIndicator())
//                 : Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: SizedBox(
//                       height: double.infinity,
//                       width: double.infinity,
//                       child: BookingCalendar(
//                         bookingService: BookingService(
//                             serviceName: 'Mock Service',
//                             serviceDuration: 15,
//                             bookingEnd: DateTime(
//                                 now.year, now.month, now.day, tohour!, 0),
//                             bookingStart: DateTime(
//                                 now.year, now.month, now.day, fromhour!, 0)),
//                         convertStreamResultToDateTimeRanges:
//                             convertStreamResultMock,
//                         getBookingStream: getBookingStreamMock,
//                         uploadBooking: uploadBookingMock,
//                         pauseSlots: generatePauseSlots(),
//                         pauseSlotText: 'LUNCH',
//                         hideBreakTime: false,
//                         loadingWidget: const Text('Fetching data...'),
//                         uploadingWidget: Center(
//                             child: const CircularProgressIndicator.adaptive()),
//                         locale: 'en',
//                         startingDayOfWeek: StartingDayOfWeek.saturday,
//                         wholeDayIsBookedWidget: const Text(
//                             'Sorry, for this day everything is booked'),
//                         // disabledDates: [DateTime(2024, 1, 20)],
//                         disabledDays: numbers,
//
//                       ),
//                     ),
//                   );
//           }),
//     );
//   }
//
//   List<DateTimeRange> generatePauseSlots() {
//     return [
//       // DateTimeRange(
//       //     start: DateTime(now.year, now.month, now.day, 12, 0),
//       //     end: DateTime(now.year, now.month, now.day, 13, 0))
//     ];
//   }
// }
