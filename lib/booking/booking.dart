import 'package:flutter/material.dart';

class Booking extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              'د / شاهر ابوحلقان'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (String value) {
                    print(value);
                  },
                  onChanged: (String value) {
                    print(value);
                  },
                  decoration: InputDecoration(
                    hintStyle:TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                      hintText: 'البحث',
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                Center(
                    child: Column(children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Table(
                            defaultColumnWidth: FixedColumnWidth(300.0),
                            border: TableBorder.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            children: [
                              TableRow( children: [
                                Column(children:[Text('المبلغ', style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold))]),
                                Column(children:[Text('الاسم', style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('200',style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('محمود احمد محمد',style: TextStyle(fontSize: 20.0))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('150',style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('ابراهيم مدحت ابراهيم',style: TextStyle(fontSize: 20.0))]),
                              ]),
                              TableRow( children: [
                                Column(children:[Text('300',style: TextStyle(fontSize: 20.0))]),
                                Column(children:[Text('محمد السبكي جيلاني',style: TextStyle(fontSize: 20.0))]),
                              ]),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(onPressed: (){},
                              child: Text(
                                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                'النسبه الكليه'
                              )),
                          SizedBox(width: 50,),
                          ElevatedButton(onPressed: (){},
                              child: Text(
                                  style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                                'نسبتي'
                              )),
                        ],
                      )
                    ])
                ),
              ],
            ),
          ),
        )  );
  }
}
