import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter/bio.dart';
import 'package:twitter/getData.dart';
import 'package:twitter/searched.dart';

class FavBios extends StatefulWidget {
  @override
  _FavBiosState createState() => _FavBiosState();
}

class _FavBiosState extends State<FavBios> {
  getListFavs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    listFavs = prefs.getStringList('listFavsKey') ?? [];
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print(listFavs);
    print('FavBios');
    getListFavs();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            'Favorites:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Divider(
            height: 10,
            color: Colors.white,
          ),
        ),
        Container(
            height: MediaQuery.of(context).size.height * 0.714,
            child: FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (c, s) => s.connectionState != ConnectionState.done
                  ? Center(child: Text("Loading..."))
                  : Scrollbar(
                      isAlwaysShown: true,
                      child: ListView.builder(
                        itemCount: listFavs.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<dynamic>(
                              future: getData(listFavs[index]),
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
                                                      backgroundColor:
                                                          Colors.white,
                                                      iconTheme: IconThemeData(
                                                          color: Colors.black),
                                                      title: Text(
                                                        '@' +
                                                            snapshot.data[0]
                                                                .screenName,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    body: Searched(snapshot),
                                                  ))).then((value) {
                                        setState(() {});
                                      });
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
                                          // elevation: 10,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Bio(snapshot),
                                          ),
                                        )),
                                  );
                                }
                              });
                        },
                      ),
                    ),
            ))
      ],
    );
  }
}
