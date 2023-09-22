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
  int waheed = 0;
  int qadi = 0;
  int hossam = 0;
  int heba = 0;
  int lamiaa = 0;

  void getAllDates() {
    FirebaseFirestore.instance.collection('allDatesDoctor').orderBy('date', descending: true).get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['drName'] == "د حسام ابو الحلقان") {
          print(element.data()['drName']);
          hossam += int.parse(element.data()['price'].toString());

          patients.add(PatientModel.fromJson(element.data()));
          setTable();
          emit(GetAllPatientsSuccessfully());
        } else if (element.data()['drName'] == "د محمد وحيد ") {
          print(element.data()['drName']);
          waheed += int.parse(element.data()['price'].toString());

          patients.add(PatientModel.fromJson(element.data()));
          setTable();
          emit(GetAllPatientsSuccessfully());
        } else if (element.data()['drName'] == "د محمد خالد القاضي") {
          print(element.data()['drName']);
          qadi += int.parse(element.data()['price'].toString());

          patients.add(PatientModel.fromJson(element.data()));
          setTable();
          emit(GetAllPatientsSuccessfully());
        } else if (element.data()['drName'] == "د هبة ممدوح") {
          print(element.data()['drName']);
          heba += int.parse(element.data()['price'].toString());

          patients.add(PatientModel.fromJson(element.data()));
          setTable();
          emit(GetAllPatientsSuccessfully());
        } else if (element.data()['drName'] == "د لمياء خليفة") {
          print(element.data()['drName']);
          print(int.parse(element.data()['price'].toString()));
          lamiaa += int.parse(element.data()['price'].toString());
          print(lamiaa);
          patients.add(PatientModel.fromJson(element.data()));
          setTable();
          emit(GetAllPatientsSuccessfully());
        }
      });
    }).catchError((onError) {
      print(onError);
    });
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

  void totalAmount(context) {
    double totalAmountVar = 0.0;
    patients.forEach((element) {
      totalAmountVar += element.price!.toDouble();
    });
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                children: [
                  Text("د حسام ابو الحلقان : $hossam"),
                  Text("د محمد وحيد : $waheed"),
                  Text("د محمد خالد القاضي : $qadi"),
                  Text("د هبة ممدوح : $heba"),
                  Text("د لمياء خليفه : $lamiaa"),
                  Text("النسبه الكليه : ${totalAmountVar.toString()}"),
                  // Text("الريح : ${}"),
                ],
              ),
            ));
  }

  void delete(context) {
    FirebaseFirestore.instance.collection('allDatesDoctor').get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
        tableRows = [
          const TableRow(children: [
            Column(children: [Text('الدكتور', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
            Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
            Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
          ]),
        ];
        emit(DeleteAllPatients());
      });
    });
  }

  void deleteTable(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('حذف الجدول'),
              content: Text('هل انت متاكد ؟ '),
              actions: [
                Row(
                  children: [
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        delete(context);
                      },
                      child: Text(
                        'نعم',
                        style: TextStyle(color: Colors.green),
                      ),
                    )),
                    Expanded(
                        child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'لا',
                        style: TextStyle(color: Colors.red),
                      ),
                    )),
                  ],
                )
              ],
            ));
  }

  List<PatientModel> amountPatients = [];
  void getAmountDates() {
    FirebaseFirestore.instance.collection('doctors').get().then((value) {
      for (var element in value.docs) {
        amountPatients.add(PatientModel.fromJson(element.data()));
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
  }

  void findProfit(context) {
    double totalAmountVar = 0.0;
    for (var element in amountPatients) {
      totalAmountVar += element.price!.toDouble();
    }

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("النسبه الكليه : ${totalAmountVar.toString()}"),
            ));
  }
}
