import 'dart:convert';
import 'package:de_mo/Home/Homepage.dart';
import 'package:de_mo/Register/register.dart';
import 'package:de_mo/History/history.dart';

import 'package:de_mo/Sign%20In/signin.dart';
import 'package:de_mo/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'BookItems/listBook.dart';
import 'Home/home.dart';
void main() async {
  var url = Uri.parse('https://6382330e9842ca8d3ca3bce2.mockapi.io/api/users');
  var rs = await http.get(url);
  var data = jsonDecode(utf8.decode(rs.bodyBytes));
  runApp(MyApp(data),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  dynamic data;

  MyApp(this.data);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //
      //   primarySwatch: Colors.blue,
      // ),
      // home:  HomePage(data),
      //   home: SignIn(data),
        home: Home(),
        routes: {
          Home.routeName: (ctx) => Home(),
          HomePage.routeName: (ctx) => HomePage(data),
          History.routeName: (ctx) =>   History(data),
          ListBook.routeName: (ctx) => ListBook(title: '',),

          Profile.routeName: (ctx) => Profile(data),



          SignIn.routeName: (ctx) => SignIn(data),

            Register.routeName: (ctx) => Register(data),

          }
    );
  }
}