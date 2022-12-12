// import 'package:baicuoiki/screens/signin_screen.dart';
// import 'package:baicuoiki/widgets/bottom_menu_bar.dart';
import 'package:bookstore/widgets/bottom_menu_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SettingsPage extends StatefulWidget {
  static const routeName = '/setting';

  // const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool valNotify1 = true;
  bool valNotify2 = false;
  bool valNotify3 = false;

  onChangeFunction1(bool val){
    setState(() {
      valNotify1 = val;
    });

  }
  onChangeFunction2(bool val){
    setState(() {
      valNotify2 = val;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("Setting",style: TextStyle(fontSize: 25,color: Color(0xFFEC3133),fontWeight: FontWeight.bold),),
        leading: IconButton(
          onPressed: (){
           Navigator.pop(context);
          },
            icon: Icon(
              Icons.arrow_back
                  ,color: Colors.white,
            ),
        ),
        backgroundColor: Colors.white54,
      ),
      bottomNavigationBar: BottomMenuBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            // const Text(
            //   "Settings",
            //   style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
            // ),
            // 0xFFEC3133
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Color(0xFFEC3133),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Edit profile"),
            buildAccountOptionRow(context, "Change password"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.volume_up_outlined,
                  color: Color(  0xFFEC3133
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildNotificationOptionRow("Account activity", valNotify1, onChangeFunction1),
            buildNotificationOptionRow("Opportunity",valNotify2,onChangeFunction2),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: const [
                Icon(
                  Icons.more_horiz_outlined,
                  color: Color(             0xFFEC3133
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "More",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 15,
              thickness: 2,
            ),
            const SizedBox(
              height: 10,
            ),
            buildMoreOptionRow(context, "language"),
            buildMoreOptionRow(context, "country"),
            const SizedBox(
              height: 40,
            ),
            Center(
              // child: OutlinedButton(
              //   padding: const EdgeInsets.symmetric(horizontal: 100),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20)),
              //     onPressed: () {
              //     Navigator.of(context)
              //         .pushReplacementNamed(LoginScreen.routeName);
              //   },
              //   child: const Text("SIGN OUT",
              //       style: TextStyle(
              //           fontSize: 18,
              //           letterSpacing: 2.2,
              //           color: Colors.black,
              //           fontWeight: FontWeight.bold)),
              // ),
            )
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title, bool isActive,Function onChangeState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]),
        ),
        Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(
              activeColor: Color(0xFFEC3133),
              trackColor: Colors.grey,
              value: isActive,
              onChanged: (bool val) {
                onChangeState(val);
              },
            ))
      ],
    );
  }

  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap:(){
        showDialog(context: context, builder: (BuildContext content){

          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min
              ,
              children: [
                Text("Option 1"),
              Text("Option 2")

          ],

            ),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(content).pop();
          }, child: Text("Close"))
          ]);
        }
        );
      } ,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector buildMoreOptionRow(BuildContext context, String title) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
