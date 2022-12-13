import 'package:de_mo/History/history.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../BookItems/listBook.dart';
import '../Home/Homepage.dart';
import '../Home/home.dart';
import '../profile/profile.dart';

class BottomMenuBar extends StatefulWidget {
  // BottomMenuBar({Key? key}) : super(key: key);

  @override
  _BottomMenuBarState createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {

  // void nvgToSocket(BuildContext context) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(builder: (context) => ChatScreen()),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: BottomAppBar(

        child: Row(
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.home_outlined, color: Colors.pink),
                onPressed: () {

                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.history, color: Colors.pink),
                onPressed: () {

                  Navigator.of(context)
                      .pushReplacementNamed(History.routeName);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.bookmark, color: Colors.pink),
                onPressed: () {

                  Navigator.of(context)
                      .pushReplacementNamed(ListBook.routeName);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.person, color: Colors.pink),
                onPressed: () {

                  Navigator.of(context)
                      .pushReplacementNamed(Profile.routeName);
                },
              ),
            ),

          ],
        ),
      ),
    );
  }
}
