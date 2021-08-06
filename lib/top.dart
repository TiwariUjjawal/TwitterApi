import 'package:flutter/material.dart';
import 'package:twitter/searched.dart';

import 'bio.dart';
import 'getData.dart';

class Top extends StatefulWidget {
  @override
  _TopState createState() => _TopState();
}

class _TopState extends State<Top> {
  List<String> topScreenNames = [
    'barackobama',
    'katyperry',
    'rihanna',
    'Cristiano',
    'taylorswift13',
    'arianagrande',
    'narendramodi',
    'kimkardashian',
    'shakira',
    'nasa',
    'imvkohli',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.67,
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 1)),
          builder: (c, s) => s.connectionState != ConnectionState.done
              ? Text("Loading...")
              : Scrollbar(
                  isAlwaysShown: true,
                  child: ListView.builder(
                    itemCount: topScreenNames.length,
                    itemBuilder: (context, index) {
                      return FutureBuilder<dynamic>(
                          future: getData(topScreenNames[index]),
                          builder: (context, snapshot) {
                            if (snapshot.data == null ||
                                snapshot.data.isEmpty) {
                              return Center(child: Text(''));
                            } else {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Scaffold(
                                                appBar: AppBar(
                                                  backgroundColor: Colors.white,
                                                  iconTheme: IconThemeData(
                                                      color: Colors.black),
                                                  title: Text(
                                                    '@' +
                                                        snapshot
                                                            .data[0].screenName,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                body: Searched(snapshot),
                                              ))).then(
                                      (value) => setState(() {}));
                                },
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: 20, left: 10, right: 10),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.orange[800] ??
                                                  Colors.orange,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      elevation: 2,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Bio(snapshot),
                                      ),
                                    )),
                              );
                            }
                          });
                    },
                  ),
                ),
        ));
  }
}
