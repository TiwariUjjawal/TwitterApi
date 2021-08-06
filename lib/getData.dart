import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<String> listFavs = [];
Future<List<TweetData>> getData(query) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.clear();
  listFavs = prefs.getStringList('listFavsKey') ?? [];
  // print('called me');
  final token =
      'AAAAAAAAAAAAAAAAAAAAADIiSQEAAAAA%2BtiGa2BWt6VhwajDC6CeU0HAmfE%3DegAPMl7m3wJPLjubUKNRwH0GO0wyjKRPEIooir8TvQZzg0ODhQ';
  Uri uri = Uri.parse(
      'https://api.twitter.com/1.1/statuses/user_timeline.json?count=100&screen_name=$query');
  String host = uri.host;
  String path = uri.path;
  Map<String, String> queryParameters = uri.queryParameters;
  // print(host);
  // print(path);
  // print(queryParameters);
  var response =
      await http.get(Uri.https(host, path, queryParameters), headers: {
    'Authorization': 'Bearer $token',
  });
  var jsonData = jsonDecode(response.body);
  // print(jsonData);
  List<TweetData> tweets = [];
  if (jsonData.length != 0) {
    for (var data in jsonData) {
      String createdAt = data['created_at'];
      // print(createdAt);
      String idStr = data['id_str'];
      // print(idStr);
      String text = data['text'];
      // print(text);
      int retweetCount = data['retweet_count'];
      // print(retweetCount);
      int favoriteCount = data['favorite_count'];
      // print(favoriteCount);
      String tweetUrl;
      if (data['entities']['urls'].length != 0) {
        tweetUrl = data['entities']['urls'][0]['expanded_url'];
      } else {
        tweetUrl = '';
      }

      String imgUrl = data['user']['profile_image_url_https'];
      // print(tweetUrl);
      String name = data['user']['name'];
      // print(name);
      String screenName = data['user']['screen_name'];
      // print(screenName);
      String description = data['user']['description'] ?? '';
      // print(description);
      bool verified = data['user']['verified'];
      // print(verified);
      int followers = data['user']['followers_count'];
      int following = data['user']['friends_count'];
      String accCreatedAt = data['user']['created_at'];
      // print(followers);
      // bool isFav;
      TweetData tweetData = new TweetData(
        name: name,
        screenName: screenName,
        text: text,
        tweetUrl: tweetUrl,
        description: description,
        idStr: idStr,
        imgUrl: imgUrl,
        createdAt: createdAt,
        favoriteCount: favoriteCount,
        followers: followers,
        following: following,
        retweetCount: retweetCount,
        accCreatedAt: accCreatedAt,
        verified: verified,
      );

      tweets.add(tweetData);
    }
  }
  // print(tweets[0].text);
  // print(tweets.length);
  return tweets;
}

class TweetData {
  final String createdAt;
  final String idStr;
  final String text;
  final int retweetCount;
  final int favoriteCount;
  final String tweetUrl;
  final String screenName;
  final String imgUrl;
  final String name;
  final String description;
  final int followers;
  final int following;
  final bool verified;
  final String accCreatedAt;

  TweetData({
    required this.name,
    required this.screenName,
    required this.text,
    required this.tweetUrl,
    required this.description,
    required this.idStr,
    required this.createdAt,
    required this.favoriteCount,
    required this.followers,
    required this.following,
    required this.retweetCount,
    required this.verified,
    required this.imgUrl,
    required this.accCreatedAt,
  });
}
