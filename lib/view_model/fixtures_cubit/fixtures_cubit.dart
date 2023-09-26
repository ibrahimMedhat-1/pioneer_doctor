import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pioneer_doctor/model/fixture_model.dart';

import '../../core/constants.dart';

part 'fixtures_state.dart';

class FixturesCubit extends Cubit<FixturesState> {
  FixturesCubit() : super(FixturesInitial());
  static FixturesCubit get(context) => BlocProvider.of(context);
  List<FixtureModel> fixtures = [];
  List<TableRow> tableRows = [
    const TableRow(children: [
      Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('اسم المعمل', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('تاريخ استلام التركيبه', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('تاريخ الطبعه', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
    ]),
  ];
  int allDoctorFixturesAmount = 0;
  int getAllDoctorFixtures() {
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(drName!)
        .collection('fixtures')
        .orderBy('printDate', descending: true)
        .get()
        .then((value) {
      for (var element in value.docs) {
        allDoctorFixturesAmount += int.parse(element.data()['price'].toString());
        fixtures.add(FixtureModel.fromJson(element.data()));
        setTable();
        emit(GetAllFixturesSuccessfully());
      }
      return allDoctorFixturesAmount;
    }).catchError((onError) {});
    return 0;
  }

  void setTable() {
    tableRows = [
      const TableRow(children: [
        Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('اسم المعمل', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(
            children: [Text('تاريخ استلام التركيبه', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('تاريخ الطبعه', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      ]),
    ];
    for (var element in fixtures) {
      tableRows.add(TableRow(children: [
        Column(children: [Text(element.price.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.labName.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.receiveDate.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.printDate.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.patientName.toString(), style: const TextStyle(fontSize: 20.0))]),
      ]));
      emit(GetAllFixturesSuccessfully());
    }
  }

  void showTotalFixturesAmount(context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("النسبه الكليه : ${allDoctorFixturesAmount.toString()}"),
            ));
  }

  void delete(context) {
    FirebaseFirestore.instance.collection('doctors').doc(drName!).collection('fixtures').get().then((value) {
      value.docs.forEach((element) {
        element.reference.delete();
        tableRows = [
          const TableRow(children: [
            Column(children: [Text('التاريخ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
            Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
            Column(children: [Text('المصروفات', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
          ]),
        ];
        emit(DeleteAllFixtures());
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
}
