import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pioneer_doctor/view_model/fixtures_cubit/fixtures_cubit.dart';

class Fixtures extends StatelessWidget {
  const Fixtures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FixturesCubit()..getAllFixtures(),
      child: BlocConsumer<FixturesCubit, FixturesState>(
        listener: (context, state) {},
        builder: (context, state) {
          FixturesCubit cubit = FixturesCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'التركيبات'),
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
                    ]))
                  ]))));
        },
      ),
    );
  }
}
