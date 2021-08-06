import 'package:flutter/material.dart';
import 'package:twitter/searched.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'getData.dart';

class ItemSearchScreen extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Column(
            children: [
              // RecentItems(recent),
            ],
          )
        : FutureBuilder<dynamic>(
            future: getData(query),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.brown,
                ));
              } else {
                return Searched(snapshot);
              }
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Column(
            children: [
              // RecentItems(recent),
            ],
          )
        : FutureBuilder<dynamic>(
            future: getData(query),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data.isEmpty) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.brown,
                ));
              } else {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Colors.white,
                                    iconTheme:
                                        IconThemeData(color: Colors.black),
                                    title: Text(
                                      '@' + snapshot.data[0].screenName,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  body: Searched(snapshot),
                                )));
                    // Searched(snapshot);
                  },
                  leading: Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      //  color: const Color(0xff7c94b6),
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data[0].imgUrl),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      border: Border.all(
                        color: Colors.orange[800] ?? Colors.orange,
                        width: 2.0,
                      ),
                    ),
                  ),
                  title: Text(
                    snapshot.data[0].name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                      'Followers: ' + snapshot.data[0].followers.toString()),
                );
              }
            });
  }
}
