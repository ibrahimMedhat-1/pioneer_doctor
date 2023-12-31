import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pioneer_doctor/view_model/booking_cubit/booking_cubit.dart';

import '../../core/constants.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingCubit()..getAllDates(),
      child: BlocConsumer<BookingCubit, BookingState>(
        listener: (context, state) {},
        builder: (context, state) {
          BookingCubit cubit = BookingCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), drName.toString()),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
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
                                child: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'النسبه الكليه')),
                            const SizedBox(
                              width: 50,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  cubit.myAmount(context);
                                },
                                child: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'نسبتي')),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: () {
                              cubit.deleteTable(context);
                            },
                            child: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'حذف الجدول')),
                      ])),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
