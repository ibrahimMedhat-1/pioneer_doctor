import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pioneer_doctor/view_model/daily_report_cubit/daily_report_cubit.dart';

class DailyReport extends StatelessWidget {
  const DailyReport({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DailyReportCubit()..getAllDoctorPrices(),
      child: BlocConsumer<DailyReportCubit, DailyReportState>(
        listener: (context, state) {
          if (state is DeleteAllPatients) {
            DailyReportCubit.get(context).getAllDates();
          }
        },
        builder: (context, state) {
          DailyReportCubit cubit = DailyReportCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'التقرير الشهري'),
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
                      ElevatedButton(
                          onPressed: () async {
                            await cubit.totalAmount(context).then((value) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text("د حسام ابو الحلقان : ${(cubit.hossam)}"),
                                          Text(" نسبه د حسام ابو الحلقان : ${(cubit.hossamPercentage)}"),
                                          Text("د محمد وحيد : ${(cubit.waheed)}"),
                                          Text("نسبه د محمد وحيد : ${(cubit.waheedPercentage)}"),
                                          Text("د محمد خالد القاضي : ${(cubit.qadi)}"),
                                          Text("نسبه د محمد خالد القاضي : ${(cubit.qadiPercentage)}"),
                                          Text("د هبة ممدوح : ${(cubit.heba)}"),
                                          Text("نسبه د هبة ممدوح : ${(cubit.hebaPercentage)}"),
                                          Text("د لمياء خليفه : ${(cubit.lamiaa)}"),
                                          Text("نسبه د لمياء خليفه : ${(cubit.lamiaaPercentage)}"),
                                          Text("النسبه الكليه : ${cubit.totalAmountVar.toString()}"),
                                          Text("الربح : ${cubit.profit.toString()}"),
                                          // Text("الريح : ${}"),
                                        ],
                                      ),
                                    );
                                  });
                            });
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
