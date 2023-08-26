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

  void getAllDates() {
    FirebaseFirestore.instance.collection('allDatesDoctor').orderBy('date', descending: true).get().then((value) {
      for (var element in value.docs) {
        patients.add(PatientModel.fromJson(element.data()));
        setTable();
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
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
              content: Text("النسبه الكليه : ${totalAmountVar.toString()}"),
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
}
