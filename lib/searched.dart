import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:twitter/bio.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Searched extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapshot;

  Searched(this.snapshot);

  @override
  Widget build(BuildContext context) {
    String imgUrl = snapshot.data?[0].imgUrl;
    String revImg = imgUrl.split('').reversed.join('');
    imgUrl = revImg.substring(0, 4) +
        '004x004' +
        revImg.substring(10, revImg.length);
    imgUrl = imgUrl.split('').reversed.join('');

    return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Bio(snapshot),
        Container(
          padding: EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Tweets',
              style: TextStyle(
                color: Colors.blue[800],
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            Divider(
              height: 10,
              color: Colors.black,
            )
          ]),
        ),
        Expanded(
          // height: MediaQuery.of(context).size.height * 0.55,
          // width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            isAlwaysShown: true,
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        splashColor: Colors.lightBlue,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          appBar: AppBar(),
                                          body: WebView(
                                            javascriptMode:
                                                JavascriptMode.unrestricted,
                                            initialUrl:
                                                snapshot.data[index].tweetUrl,
                                          ),
                                        )));
                          },
                          leading: Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                              //  color: const Color(0xff7c94b6),
                              image: DecorationImage(
                                image:
                                    NetworkImage(snapshot.data[index].imgUrl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                          ),
                          // ClipRRect(
                          //     borderRadius: BorderRadius.all(
                          //       Radius.circular(30),
                          //     ),
                          //     child: Image.network(snapshot.data[index].imgUrl)),
                          title: Text(
                            snapshot.data[index].text,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Divider(
                          height: 10,
                          color: Colors.black,
                        ),
                      )
                    ],
                  );
                }),
          ),
        )
      ]),
    );
  }
}
