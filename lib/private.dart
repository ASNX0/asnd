import 'package:flutter/material.dart';

import 'package:parking/stop.dart';
import 'package:firebase_database/firebase_database.dart';

class Private extends StatefulWidget {
  @override
  State<Private> createState() => _PrivateState();
}

class _PrivateState extends State<Private> with TickerProviderStateMixin {
  late DatabaseReference database;
  bool find = false;

  List item = [];
  List parkingPos = [];
  late var empty;
  _activateListener() {
    database.child('isempty').onValue.listen((event) {
      for (final child in event.snapshot.children) {
        final data = child.value;
        item.add(data);
      }
    }, onError: (error) {
      print(error);
    });

    FirebaseDatabase.instance
        .ref('count')
        .child('empty')
        .onChildChanged
        .listen((event) {
      setState(() {
        empty = event.snapshot.value;
      });
    });
    parkingPos = item;
  }

  start() {
    List.generate(70, (i) async {
      await database.child("$i").child('isempty').get().then((snapshot) {
        setState(() {
          item.add(snapshot.value);
        });
      });
    });
    FirebaseDatabase.instance
        .ref('count')
        .child('empty')
        .onValue
        .listen((event) {
      setState(() {
        empty = event.snapshot.value;
      });
    });
    parkingPos = item;
  }

  @override
  void initState() {
    database = FirebaseDatabase.instance.ref('parking');

    start();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(113, 80, 73, 73),
      body: ListView(
        children: [
          Text(
            "$empty/${parkingPos.length}",
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          StreamBuilder(
              stream: database.onChildChanged,
              builder: (context, AsyncSnapshot snap) {
                if (parkingPos.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: parkingPos.length,
                    padding: EdgeInsets.symmetric(vertical: 30),
                    itemBuilder: (BuildContext context, int index) {
                      _activateListener();

                      return Stop(
                        find: parkingPos[index],
                        i: index,
                      );
                    },
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisExtent: 50,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 0.0,
                        crossAxisSpacing: 0.0),
                  );
                }
              }),
        ],
      ),
    );
  }
}
