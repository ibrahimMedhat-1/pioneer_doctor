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
      Column(children: [Text('الدكتور', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('اسم المعمل', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('تاريخ استلام التركيبه', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('تاريخ الطبعه', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
    ]),
  ];

  void getAllFixtures() {
    FirebaseFirestore.instance.collection('doctors').doc(drName!).collection('fixtures').orderBy('printDate', descending: true).get().then((value) {
      for (var element in value.docs) {
        fixtures.add(FixtureModel.fromJson(element.data()));
        setTable();
        emit(GetAllFixturesSuccessfully());
      }
    }).catchError((onError) {});
  }

  void setTable() {
    tableRows = [
      const TableRow(children: [
        Column(children: [Text('الدكتور', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('اسم المعمل', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('تاريخ استلام التركيبه', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('تاريخ الطبعه', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('الاسم', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      ]),
    ];
    for (var element in fixtures) {
      tableRows.add(TableRow(children: [
        Column(children: [Text(element.drName.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.labName.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.receiveDate.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.printDate.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.patientName.toString(), style: const TextStyle(fontSize: 20.0))]),
      ]));
      emit(GetAllFixturesSuccessfully());
    }
  }
}
