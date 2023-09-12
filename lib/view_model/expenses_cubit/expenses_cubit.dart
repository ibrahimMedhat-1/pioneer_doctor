import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/expenses_model.dart';

part 'expenses_state.dart';

class ExpensesCubit extends Cubit<ExpensesState> {
  ExpensesCubit() : super(ExpensesInitial());
  static ExpensesCubit get(context) => BlocProvider.of(context);
  List<ExpensesModel> expenses = [];
  List<TableRow> tableRows = [
    const TableRow(children: [
      Column(children: [Text('التاريخ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      Column(children: [Text('المصروفات', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
    ]),
  ];

  void getAllExpenses() {
     Firestore.instance.collection('ExpensesDoctor').orderBy('date', descending: true).get().then((value) {
      for (var element in value) {
        expenses.add(ExpensesModel.fromJson(element.map));
        setTable();
        emit(GetAllExpensesSuccessfully());
      }
    }).catchError((onError) {});
  }

  void delete(context) {
    Firestore.instance.collection('ExpensesDoctor').get().then((value) {
      value.forEach((element) {
        element.reference.delete();
        tableRows = [
          const TableRow(children: [
            Column(children: [Text('التاريخ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
            Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
            Column(children: [Text('المصروفات', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
          ]),
        ];
        emit(DeleteAllExpenses());
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

  void setTable() {
    tableRows = [
      const TableRow(children: [
        Column(children: [Text('التاريخ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('المبلغ', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
        Column(children: [Text('المصروفات', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold))]),
      ]),
    ];
    for (var element in expenses) {
      tableRows.add(TableRow(children: [
        Column(children: [Text(element.date.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.price.toString(), style: const TextStyle(fontSize: 20.0))]),
        Column(children: [Text(element.details.toString(), style: const TextStyle(fontSize: 20.0))]),
      ]));
      emit(GetAllExpensesSuccessfully());
    }
  }

  void totalAmount(context) {
    double totalAmountVar = 0.0;
    expenses.forEach((element) {
      totalAmountVar += int.parse(element.price!).toDouble();
    });
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text("النسبه الكليه : ${totalAmountVar.toString()}"),
            ));
  }
}
