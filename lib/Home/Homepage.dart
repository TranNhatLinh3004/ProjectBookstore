
import 'package:de_mo/Register/register.dart';
import 'package:de_mo/Sign%20In/signin.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home() : super();
  static const routeName = '/homepage';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/picture.png', width: 250, height: 200,),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Image.asset('images/logo.png'),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Color Store ", style: TextStyle(
                  fontSize: 50,
                  fontFamily: "DancingScript",
                  color: Colors.red
              ),),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Read your favorite book',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        'A library of bite-sized business eBooks on soft skils '
                            'and access to 30+ millions books in various '
                            'languages with an easy and simple monthly subscription'
                            ' and read anywhere, any devices.',
                        style: TextStyle(
                          height: 2,
                          fontSize: 13,
                          color: Colors.black,

                        ),
                          textAlign: TextAlign.center

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Register.routeName);
                    },
                    child: Container(
                      height: 50,
                      width: 130,
                      decoration: BoxDecoration(
                          color: const Color(0xff42C83C), // Color(0xffF05945),
                          borderRadius: BorderRadius.circular(28.0)),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SignIn.routeName);
                    },
                    child: Text(
                      'Sing In',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
