import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/patient_model.dart';

part 'daily_report_state.dart';

class DailyReportCubit extends Cubit<DailyReportState> {
  DailyReportCubit() : super(DailyReportInitial());

  static DailyReportCubit get(context) => BlocProvider.of(context);
  List<PatientModel> patients = [];
  List<TableRow> tableRows = [
    const TableRow(children: [
      Column(children: [Text('الدكتور', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
    ]),
  ];
  double profit = 0;
  double waheed = 0;
  double qadi = 0;
  double hossam = 0;
  double heba = 0;
  double lamiaa = 0;
  double waheedFixtures = 0;
  double hossamFixtures = 0;
  double qadiFixtures = 0;
  double hebaFixtures = 0;
  double lamiaaFixtures = 0;
  double waheedPercentage = 0;
  double qadiPercentage = 0;
  double hossamPercentage = 0;
  double hebaPercentage = 0;
  double lamiaaPercentage = 0;
  double allExpenses = 0;
  double totalAmountVar = 0.0;

  void getAllDoctorPrices() {
    FirebaseFirestore.instance.collection('allDatesDoctor').orderBy('date', descending: true).get().then((value) {
      for (var element in value.docs) {
        patients.add(PatientModel.fromJson(element.data()));
        setTable();
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
  }

  Future<void> getAllDates() async {
    waheed = 0;
    qadi = 0;
    hossam = 0;
    heba = 0;
    lamiaa = 0;
    await FirebaseFirestore.instance.collection('allDatesDoctor').orderBy('date', descending: true).get().then((value) {
      for (var element in value.docs) {
        if (element.data()['drName'] == "د حسام ابو الحلقان") {
          hossam += int.parse(element.data()['price'].toString());
          emit(GetAllPatientsSuccessfully());
        } else if (element.data()['drName'] == "د محمد وحيد ") {
          waheed += int.parse(element.data()['price'].toString());
          emit(GetAllPatientsSuccessfully());
        } else if (element.data()['drName'] == "د محمد خالد القاضي") {
          qadi += int.parse(element.data()['price'].toString());
          emit(GetAllPatientsSuccessfully());
        } else if (element.data()['drName'] == "د هبة ممدوح") {
          heba += int.parse(element.data()['price'].toString());
          emit(GetAllPatientsSuccessfully());
        } else if (element.data()['drName'] == "د لمياء خليفة") {
          lamiaa += int.parse(element.data()['price'].toString());
          emit(GetAllPatientsSuccessfully());
        }
        emit(GetAllPatientsSuccessfully());
      }

      emit(GetAllPatientsSuccessfully());
    }).catchError((onError) {});
  }

  Future<void> totalAmount(context) async {
    totalAmountVar = 0;
    profit = 0;
    waheedPercentage = 0;
    qadiPercentage = 0;
    hossamPercentage = 0;
    hebaPercentage = 0;
    lamiaaPercentage = 0;
    await getAllDates();
    await getAllExpenses();
    await getWaheedFixtures();
    await getQadiFixtures();
    await getHossamFixtures();
    await getHebaFixtures();
    await getLamiaaFixtures();
    for (var element in patients) {
      totalAmountVar += element.price!.toDouble();
      emit(GetAllPatientsSuccessfully());
    }
    waheedPercentage = (waheed - waheedFixtures) * 0.50;
    qadiPercentage = (qadi - qadiFixtures) * 0.50;
    hossamPercentage = (hossam - hossamFixtures) * 0.50;
    hebaPercentage = (heba - hebaFixtures) * 0.35;
    lamiaaPercentage = (lamiaa - lamiaaFixtures) * 0.35;
    double allPercentages = waheedPercentage + qadiPercentage + hossamPercentage + hebaPercentage + lamiaaPercentage;
    profit = totalAmountVar - (allExpenses + allPercentages);
    print(hossam);
    print(waheed);
    print(qadi);
    print(heba);
    print(lamiaa);
    print(allExpenses);
    print(waheedFixtures);
    print(qadiFixtures);
    print(hossamFixtures);
    print(hebaFixtures);
    print(lamiaaFixtures);
    print(waheedPercentage);
    print(qadiPercentage);
    print(hossamPercentage);
    print(hebaPercentage);
    print(lamiaaPercentage);
    print(allPercentages);
    print(profit);
    emit(GetAllPatientsSuccessfully());
  }

  List<PatientModel> amountPatients = [];

  Future<void> getWaheedFixtures() async {
    waheedFixtures = 0;
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc("د محمد وحيد ")
        .collection('fixtures')
        .orderBy('printDate', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        waheedFixtures += int.parse(element.data()['price'].toString());
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
  }

  Future<void> getHossamFixtures() async {
    hossamFixtures = 0;
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc("د حسام ابو الحلقان")
        .collection('fixtures')
        .orderBy('printDate', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        hossamFixtures += int.parse(element.data()['price'].toString());
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
  }

  Future<void> getQadiFixtures() async {
    qadiFixtures = 0;
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc("د محمد خالد القاضي")
        .collection('fixtures')
        .orderBy('printDate', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        qadiFixtures += int.parse(element.data()['price'].toString());
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
  }

  Future<void> getHebaFixtures() async {
    hebaFixtures = 0;
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc("د هبة ممدوح")
        .collection('fixtures')
        .orderBy('printDate', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        hebaFixtures += int.parse(element.data()['price'].toString());
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
  }

  Future<void> getLamiaaFixtures() async {
    lamiaaFixtures = 0;
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc("د لمياء خليفة")
        .collection('fixtures')
        .orderBy('printDate', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        lamiaaFixtures += int.parse(element.data()['price'].toString());
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
  }

  Future<void> getAllExpenses() async {
    allExpenses = 0;
    await FirebaseFirestore.instance.collection('Expenses').orderBy('date', descending: true).get().then((value) {
      for (var element in value.docs) {
        allExpenses += int.parse(element.data()['price'].toString());
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
    emit(GetAllPatientsSuccessfully());
  }

  Future<void> getProfit(context) async {}

  void delete(context) {
    FirebaseFirestore.instance.collection('allDatesDoctor').get().then((value) {
      for (var element in value.docs) {
        element.reference.delete();
        tableRows = [
          const TableRow(children: [
            Column(children: [Text('الدكتور', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
            Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
            Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
          ]),
        ];
        emit(DeleteAllPatients());
      }
    });
  }

  void deleteTable(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('حذف الجدول'),
              content: const Text('هل انت متاكد ؟ '),
              actions: [
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        delete(context);
                      },
                      child: const Text(
                        'نعم',
                        style: TextStyle(color: Colors.green),
                      ),
                    )),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'لا',
                        style: TextStyle(color: Colors.red),
                      ),
                    )),
                  ],
                )
              ],
            ));
  }

  void setTable() {
    tableRows = [
      const TableRow(children: [
        Column(children: [Text('الدكتور', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      ]),
    ];
    for (var element in patients) {
      tableRows.add(TableRow(children: [
        Column(children: [Text(element.drName.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.price.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.name.toString(), style: const TextStyle(fontSize: 20.0))]),
      ]));
      emit(GetAllPatientsSuccessfully());
    }
  }
}
