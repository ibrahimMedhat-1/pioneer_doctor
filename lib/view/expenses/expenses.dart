import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pioneer_doctor/view_model/expenses_cubit/expenses_cubit.dart';

class Expenses extends StatelessWidget {
  const Expenses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExpensesCubit()..getAllExpenses(),
      child: BlocConsumer<ExpensesCubit, ExpensesState>(
        listener: (context, state) {},
        builder: (context, state) {
          ExpensesCubit cubit = ExpensesCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'المصروفات'),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Center(
                        child: Column(children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Table(
                            defaultColumnWidth: const FixedColumnWidth(300.0),
                            border: TableBorder.all(color: Colors.black, style: BorderStyle.solid, width: 2),
                            children: cubit.tableRows,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                cubit.totalAmount(context);
                              },
                              child: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'اجمالي المصروفات')),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                cubit.deleteTable(context);
                              },
                              child: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'حذف الجدول')),
                        ],
                      ),
                    ]))
                  ]))));
        },
      ),
    );
  }
}
