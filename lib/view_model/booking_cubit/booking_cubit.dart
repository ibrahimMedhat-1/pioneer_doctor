
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pioneer_doctor/core/constants.dart';

import '../../model/patient_model.dart';

part 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(BookingInitial());
  static BookingCubit get(context) => BlocProvider.of(context);
  List<PatientModel> patients = [];
  List<TableRow> tableRows = [
    const TableRow(children: [
      Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
    ]),
  ];

  void getAllDates() {
    print(drName);
    Firestore.instance.collection('doctors').document(drName!).collection('patients').orderBy('date', descending: true).get().then((value) {
      for (var element in value) {
        patients.add(PatientModel.fromJson(element.map));
        setTable();
        emit(GetAllPatientsSuccessfully());
      }
    }).catchError((onError) {});
  }

  void setTable() {
    tableRows = [
      const TableRow(children: [
        Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      ]),
    ];
    for (var element in patients) {
      tableRows.add(TableRow(children: [
        Column(children: [Text(element.price.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.name.toString(), style: const TextStyle(fontSize: 20.0))]),
      ]));
      emit(GetAllPatientsSuccessfully());
    }
  }

  void delete(context) {
   Firestore.instance.collection('doctors').document(drName!).collection('patients').get().then((value) {
      value.forEach((element) {
        element.reference.delete();
        tableRows = [
          const TableRow(children: [
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

  void myAmount(context) {
    double totalAmountVar = 0.0;
    patients.forEach((element) {
      totalAmountVar += element.price!.toDouble();
    });
    if (isFounder) {
      totalAmountVar *= 0.50;
    } else {
      totalAmountVar *= 0.35;
    }
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("النسبه الكليه : ${totalAmountVar.toString()}"),
            ));
  }
}
