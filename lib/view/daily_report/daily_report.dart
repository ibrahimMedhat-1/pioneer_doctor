import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pioneer_doctor/view_model/daily_report_cubit/daily_report_cubit.dart';

class DailyReport extends StatelessWidget {
  const DailyReport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyReportCubit()..getAllDates(),
      child: BlocConsumer<DailyReportCubit, DailyReportState>(
        listener: (context, state) {
          if (state == DeleteAllPatients) {
            DailyReportCubit.get(context).getAllDates();
          }
        },
        builder: (context, state) {
          DailyReportCubit cubit = DailyReportCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'التقرير اليومي'),
              ),
              body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintStyle: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                          hintText: 'البحث',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                    ),
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
                      ElevatedButton(
                          onPressed: () {
                            cubit.totalAmount(context);
                          },
                          child: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'الدخل الكلي')),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            cubit.deleteTable(context);
                          },
                          child: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'حذف الجدول')),
                    ]))
                  ]))));
        },
      ),
    );
  }
}
