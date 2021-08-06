// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twitter/getData.dart';

class Bio extends StatefulWidget {
  final AsyncSnapshot<dynamic> snapshot;

  Bio(this.snapshot);

  @override
  _BioState createState() => _BioState();
}

class _BioState extends State<Bio> {
  // List<String> favoriteList = [];
  // // bool _isFavorite = false;
  // getFav() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   favoriteList = prefs.getStringList('favoriteList') ?? [];
  //   print(favoriteList);
  //   return favoriteList;
  // }

  setFav(setFavoriteList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listFavsKey', setFavoriteList);
  }

  // List<BioCard> bioCard = [];
  // bool isFav = false;

  void _makeFavorite(screenName) {
    bool isFav = listFavs.contains(screenName);
    // print('before');
    // print(listFavs);
    if (isFav == false) {
      listFavs.add(screenName);
      setFav(listFavs);
    } else {
      listFavs.remove(screenName);
      setFav(listFavs);
    }
    // print('after');
    // print(listFavs);
    // print(favoriteList);
    // print(_alreadyFav(screenName));
  }

  @override
  Widget build(BuildContext context) {
    print(listFavs);
    String imgUrl = widget.snapshot.data?[0].imgUrl;
    String revImg = imgUrl.split('').reversed.join('');
    imgUrl = revImg.substring(0, 4) +
        '004x004' +
        revImg.substring(10, revImg.length);
    imgUrl = imgUrl.split('').reversed.join('');
    String name = widget.snapshot.data?[0].name;
    bool verified = widget.snapshot.data[0].verified;
    String description = widget.snapshot.data[0].description;
    String screenName = widget.snapshot.data[0].screenName;
    String accCreatedAt = widget.snapshot.data[0].accCreatedAt;
    accCreatedAt = 'Joined ' +
        accCreatedAt.substring(4, 10) +
        ', ' +
        accCreatedAt.substring(26, 30);
    int following = widget.snapshot.data[0].following;
    String following_str;
    (following >= 1000 && following <= 1000000)
        ? following_str = (following / 1000).toStringAsFixed(1) + 'k'
        : following_str = following.toString();
    int followers = widget.snapshot.data[0].followers;
    String followers_str;
    (followers >= 1000000)
        ? followers_str = (followers / 1000000).toStringAsFixed(1) + 'm'
        : followers_str = followers.toString();
    // print(_favorite);
    // print(_alreadyFav(screenName));
    return Container(
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(10),
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                //  color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: NetworkImage(imgUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: Colors.orange[800] ?? Colors.orange,
                  width: 2.0,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 30)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.44,
                    child: Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  IconButton(
                      icon: new Icon(
                        listFavs.contains(screenName)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: listFavs.contains(screenName)
                            ? Colors.red
                            : Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _makeFavorite(screenName);
                          // isFav = !isFav;
                        });
                      })
                ]),
                Text(
                  '@' + screenName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ]),
          Divider(
            height: 20,
          ),
          Text(description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              )),
          Divider(
            height: 10,
          ),
          Row(
            children: [
              Icon(
                Icons.calendar_today_sharp,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 12),
              ),
              Text(
                accCreatedAt,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Divider(
            height: 15,
          ),
          Row(children: [
            Text(
              following_str,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' Following',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25),
            ),
            Text(
              followers_str,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              ' Followers',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.normal,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
