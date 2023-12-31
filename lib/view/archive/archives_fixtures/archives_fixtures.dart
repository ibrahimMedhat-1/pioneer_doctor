import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../archive_fixtures_cubit/archive_fixtures_cubit.dart';

class ArchivesFixtures extends StatelessWidget {
  const ArchivesFixtures({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchiveFixturesCubit()..getAllFixture(),
      child: BlocConsumer<ArchiveFixturesCubit, ArchiveFixturesState>(
        listener: (context, state) {},
        builder: (context, state) {
          ArchiveFixturesCubit cubit = ArchiveFixturesCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blue,
                centerTitle: true,
                title: const Text(style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), 'الارشيف'),
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
