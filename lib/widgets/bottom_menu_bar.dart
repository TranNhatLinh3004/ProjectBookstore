import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import '../bookstore.dart';
import '../setting.dart';
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
                      .pushReplacementNamed(Bookstore.routeName);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.bookmark, color: Colors.pink),
                onPressed: () {

                  Navigator.of(context)
                      .pushReplacementNamed(Bookstore.routeName);
                },
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.settings, color: Colors.pink),
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SettingsPage.routeName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
