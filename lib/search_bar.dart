import 'package:flutter/material.dart';

import './item_search_screen.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.075,
      padding: EdgeInsets.only(
        top: 20,
        left: 15,
        right: 15,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              color: Colors.black,
              alignment: Alignment.centerLeft,
              onPressed: () {
                showSearch(context: context, delegate: ItemSearchScreen())
                    .then((value) => null);
              },
              icon: Icon(
                Icons.search,
                color: Colors.black,
                size: 28,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Search Username',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
          ],
        ),
        onPressed: () {
          showSearch(context: context, delegate: ItemSearchScreen());
        },
      ),
    );
  }
}
