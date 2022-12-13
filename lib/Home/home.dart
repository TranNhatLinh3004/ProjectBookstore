import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:de_mo/BookItems/listBook.dart';
import 'package:de_mo/History/history.dart';
import 'package:de_mo/profile/introduce/introduce.dart';
import 'package:de_mo/profile/profile.dart';
import '../model/post.dart';
import '../support/support.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:de_mo/network/network_request.dart';

import '../widgets/bottom_menu.dart';

void main() async {
  var url = Uri.parse('https://6382330e9842ca8d3ca3bce2.mockapi.io/api/users');
  var rs = await http.get(url);
  var data = jsonDecode(utf8.decode(rs.bodyBytes));
  runApp(MyApp(data),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key, }) : super(key: key);
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
      home:  HomePage(data),
    );
  }
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.0)),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$publishDate - $readDuration',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class CustomListItemTwo extends StatelessWidget {
  const CustomListItemTwo({
    super.key,
    required this.thumbnail,
    required this.title,
    required this.subtitle,
    required this.author,
    required this.publishDate,
    required this.readDuration,
  });

  final Widget thumbnail;
  final String title;
  final String subtitle;
  final String author;
  final String publishDate;
  final String readDuration;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: thumbnail,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: title,
                  subtitle: subtitle,
                  author: author,
                  publishDate: publishDate,
                  readDuration: readDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  // const HomePage({Key? key, required this.title, }) : super(key: key);
  //
  // final String title;
  dynamic data;
  static const routeName = '/bookstore';


  HomePage(this.data);
  @override
  State<HomePage> createState() => _MyHomePageState(data);
}


class _MyHomePageState extends State<HomePage>
    with TickerProviderStateMixin {
  dynamic data;

  _MyHomePageState(this.data);
  static List<Post> postData = [];
  List<Post> display = List.from(postData);

  int currentIndex = 0;
  int activePage = 1;
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    NetworkRequest.fetchPosts().then((dataFromServer) {
      setState(() {
        postData = dataFromServer;
      });
    });
    _pageController = PageController(viewportFraction: 0.8,initialPage: 1);
    _tabController = TabController(length: 3, vsync: this);
  }

  void updateList(String value){
    setState(() {
      display = postData.where((item) => item.name!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  void showPopupMenu1() async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(40, 160, 70, 100),  //position where you want to show the menu on screen
      items: [
        PopupMenuItem<String>(
            child: const Text('Language Settings'), value: '1'),
        PopupMenuItem<String>(
            child: const Text('Application Management'), value: '2'),
        PopupMenuItem<String>(
            child: const Text('Application Information'), value: '3'),
      ],
      elevation: 8.0,
    )
        .then<void>((itemSelected) async {

      if (itemSelected == null) return;

      if(itemSelected == "1"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Support()));
      }else if(itemSelected == "2"){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Support()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => Support()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {



    Widget head = Container(
        child: Column(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, size: 40,),
                    color: Colors.black,
                    onPressed: () async {
                      showPopupMenu1();
                    },
                    splashRadius: 17,
                    splashColor: Colors.lightBlueAccent,
                  ),

                  Container(
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(data)));
                          },
                          child: Text('Soroushnrz',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        SizedBox(width: 15,),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(200.0),
                          child: CircleAvatar(
                            backgroundImage:
                            NetworkImage("images/avata.jpg"),
                            radius: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
    );

    Widget content1 = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Keep exploring",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),),
          SizedBox(height: 15,),
          TextFormField(
            onChanged: (value) => updateList(value),
            decoration: InputDecoration(
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.black,
                  onPressed: ()  {
                    // showSearch(
                    //     context: context,
                    //     delegate: CustomSearch()
                    // );
                  },
                  splashRadius: 17,
                  splashColor: Colors.lightBlueAccent,
                ),
                filled: true,
                fillColor: Colors.black12,
                hintText: 'Search ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                )
            ),
          ),
          SizedBox(height: 15,),
          CarouselSlider(
            items: [
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage('images/content1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: DecorationImage(
                    image: AssetImage('images/sach.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('images/back3.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('images/back4.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 250.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 500),
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );

    Widget content2 = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Popular Authors",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              TextButton(
                onPressed: (){
                },
                child: Text("View All", style: TextStyle(
                    fontSize: 18,
                    color: Colors.green
                ),),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: const Image(image: AssetImage('images/author1.png'), width: 70,),
                  ),
                  SizedBox(height: 10,),
                  Text("J.K. Rowling", style: TextStyle(
                    fontSize: 14,
                    fontFamily: "UMT1",
                    color: Color(0xfff44336),
                  ),)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: const Image(image: AssetImage('images/author2.png'), width: 70,),
                  ),
                  SizedBox(height: 10,),
                  Text("Virginia", style: TextStyle(
                    fontSize: 14,
                    fontFamily: "UMT1",
                    color: Color(0xfff44336),
                  ),)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: const Image(image: AssetImage('images/author3.png'), width: 70,),
                  ),
                  SizedBox(height: 10,),
                  Text("Charles", style: TextStyle(
                    fontSize: 14,
                    fontFamily: "UMT1",
                    color: Color(0xfff44336),
                  ),)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(200),
                    child: const Image(image: AssetImage('images/author4.png'), width: 70,),
                  ),
                  SizedBox(height: 10,),
                  Text("James", style: TextStyle(
                    fontSize: 14,
                    fontFamily: "UMT1",
                    color: Color(0xfff44336),
                  ),)
                ],
              ),
            ],
          ),

          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Continue Reading",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListBook(title: '',)));
                },
                child: Text("View All", style: TextStyle(
                    fontSize: 18,
                    color: Colors.green
                ),),
              ),
            ],
          ),
          SizedBox(height: 15,),
          DefaultTabController(
            length: 5,
            child: Column(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      unselectedLabelStyle: TextStyle(color: Colors.grey[500], fontSize: 17,),
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(left: 20, right: 20),
                      tabs: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:  Image.asset('${postData[0].avatar}', width: 170,)
                                  ),
                                  SizedBox(height: 10,),
                                  Text('${postData[0].name}', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 7,),
                                  Text('${postData[0].author}', style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:  Image.asset('${postData[1].avatar}', width: 170,)
                                  ),
                                  SizedBox(height: 10,),
                                  Text('${postData[1].name}', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 7,),
                                  Text('${postData[1].author}', style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:  Image.asset('${postData[2].avatar}', width: 170,)
                                  ),
                                  SizedBox(height: 10,),
                                  Text('${postData[2].name}', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 7,),
                                  Text('${postData[2].author}', style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:  Image.asset('${postData[3].avatar}', width: 170,)
                                  ),
                                  SizedBox(height: 10,),
                                  Text('${postData[3].name}', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 7,),
                                  Text('${postData[3].author}', style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child:  Image.asset('${postData[4].avatar}', width: 170,)
                                  ),
                                  SizedBox(height: 10,),
                                  Text('${postData[4].name}', style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  SizedBox(height: 7,),
                                  Text('${postData[4].author}', style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),)
                                ],
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),

          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Trending books",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListBook(title: "")));
                },
                child: Text("View All", style: TextStyle(
                    fontSize: 18,
                    color: Colors.green
                ),),
              ),
            ],
          ),
          SizedBox(height: 18,),
          DefaultTabController(
            length: 5,
            child: Column(
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      indicator: ShapeDecoration (
                          shape: UnderlineInputBorder (
                            borderRadius: BorderRadius.circular(60),
                            borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 70,
                                style: BorderStyle.solid
                            ),
                          ),
                          gradient: LinearGradient(colors: [Color(0xff0081ff), Color(0xff01ff80)])
                      ),
                      unselectedLabelStyle: TextStyle(color: Colors.grey[500], fontSize: 17,),
                      unselectedLabelColor: Colors.grey[500],
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(left: 20, right: 20),
                      tabs: [
                        Row(children: [Text("Fantasy")],),
                        Row(children: [Text("Comedy")],),
                        Row(children: [Text("Horror")],),
                        Row(children: [Text("Fiction")],),
                        Row(children: [Text("Action")],),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 17,),
                SizedBox(
                  height: 400.0,
                  child: TabBarView(
                    children:  <Widget>[
                      Container(
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index)  {
                                for (var item in display) {
                                  if (display[index].category == "Fantasy") {
                                    return Column(
                                      children: [
                                        CustomListItemTwo(
                                          thumbnail: Container(
                                            child: Image.asset('${display[index].avatar}'),),
                                          title: '${display[index].name}',
                                          subtitle: '${display[index].review}',
                                          author: '${display[index].author}',
                                          publishDate: 'Dec 28',
                                          readDuration: '5 mins',
                                        ),
                                      ],
                                    );
                                  }
                                }

                                return CustomListItemTwo(
                                          thumbnail: Container(
                                            child: Image(image: AssetImage('images/book4.png'),),
                                          ),
                                          title: 'Great Expectations',
                                          subtitle: 'Flutter continues to improve and expand its horizons. '
                                              'This text should max out at two lines and clip',
                                          author: 'Charies Dickens',
                                          publishDate: 'Dec 28',
                                          readDuration: '5 mins',
                                        );
                              }
                              )
                      ),
                      Container(
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index)  {
                                for (var item in postData) {
                                  if (item.category == "Comedy") {
                                    return Column(
                                      children: [
                                        CustomListItemTwo(
                                          thumbnail: Container(
                                            child: Image.asset('${item.avatar}'),),
                                          title: '${item.name}',
                                          subtitle: '${item.review}',
                                          author: '${item.author}',
                                          publishDate: 'Dec 28',
                                          readDuration: '5 mins',
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return CustomListItemTwo(
                                  thumbnail: Container(
                                    child: Image(image: AssetImage('images/book4.png'),),
                                  ),
                                  title: 'Great Expectations',
                                  subtitle: 'Flutter continues to improve and expand its horizons. '
                                      'This text should max out at two lines and clip',
                                  author: 'Charies Dickens',
                                  publishDate: 'Dec 28',
                                  readDuration: '5 mins',
                                );
                              }
                          )
                      ),
                      Container(
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index)  {
                                for (var item in postData) {
                                  if (item.category == "Horror") {
                                    return Column(
                                      children: [
                                        CustomListItemTwo(
                                          thumbnail: Container(
                                            child: Image.asset('${item.avatar}'),),
                                          title: '${item.name}',
                                          subtitle: '${item.review}',
                                          author: '${item.author}',
                                          publishDate: 'Dec 28',
                                          readDuration: '5 mins',
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return CustomListItemTwo(
                                  thumbnail: Container(
                                    child: Image(image: AssetImage('images/book4.png'),),
                                  ),
                                  title: 'Great Expectations',
                                  subtitle: 'Flutter continues to improve and expand its horizons. '
                                      'This text should max out at two lines and clip',
                                  author: 'Charies Dickens',
                                  publishDate: 'Dec 28',
                                  readDuration: '5 mins',
                                );
                              }
                          )
                      ),
                      Container(
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index)  {
                                for (var item in postData) {
                                  if (item.category == "Fiction") {
                                    return Column(
                                      children: [
                                        CustomListItemTwo(
                                          thumbnail: Container(
                                            child: Image.asset('${item.avatar}'),),
                                          title: '${item.name}',
                                          subtitle: '${item.review}',
                                          author: '${item.author}',
                                          publishDate: 'Dec 28',
                                          readDuration: '5 mins',
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return CustomListItemTwo(
                                  thumbnail: Container(
                                    child: Image(image: AssetImage('images/book4.png'),),
                                  ),
                                  title: 'Great Expectations',
                                  subtitle: 'Flutter continues to improve and expand its horizons. '
                                      'This text should max out at two lines and clip',
                                  author: 'Charies Dickens',
                                  publishDate: 'Dec 28',
                                  readDuration: '5 mins',
                                );
                              }
                          )
                      ),
                      Container(
                          child: ListView.builder(
                              itemCount: 3,
                              itemBuilder: (context, index)  {
                                for (var item in postData) {
                                  if (item.category == "Action") {
                                    return Column(
                                      children: [
                                        CustomListItemTwo(
                                          thumbnail: Container(
                                            child: Image.asset('${item.avatar}'),),
                                          title: '${item.name}',
                                          subtitle: '${item.review}',
                                          author: '${item.author}',
                                          publishDate: 'Dec 28',
                                          readDuration: '5 mins',
                                        ),
                                      ],
                                    );
                                  }
                                }
                                return CustomListItemTwo(
                                  thumbnail: Container(
                                    child: Image(image: AssetImage('images/book4.png'),),
                                  ),
                                  title: 'Great Expectations',
                                  subtitle: 'Flutter continues to improve and expand its horizons. '
                                      'This text should max out at two lines and clip',
                                  author: 'Charies Dickens',
                                  publishDate: 'Dec 28',
                                  readDuration: '5 mins',
                                );
                              }
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
        ],
      ),
    );

    Widget content3 = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Coming Soon",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),),
              TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ListBook(title: "")));
                },
                child: Text("View All", style: TextStyle(
                    fontSize: 18,
                    color: Colors.green
                ),),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child:  TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(image: AssetImage('images/book9.png'), width: 130,),
                      ),
                      SizedBox(height: 10,),
                      Text("Đọc Vị Bất Kỳ Ai    ", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 7,),
                      Text("TS.David J.Lieberman", style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),)
                    ],
                  ),
                ),

              ),
              Container(
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(image: AssetImage('images/book10.png'), width: 130,),
                      ),
                      SizedBox(height: 10,),
                      Text("Tâm Lý Học ", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 7,),
                      Text("Morgan Housel", style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),)
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child:  TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(image: AssetImage('images/book11.png'), width: 130,),
                      ),
                      SizedBox(height: 10,),
                      Text("Sapiens Lược Sử  ", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 7,),
                      Text("Yuval Noah Harari", style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),)
                    ],
                  ),
                ),


              ),
              Container(
                child:  TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Introduce(title: "")));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const Image(image: AssetImage('images/book12.png'), width: 130,),
                      ),
                      SizedBox(height: 10,),
                      Text("Đắc Nhân Tâm      ", style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 7,),
                      Text("Dale Carnegie", style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),)
                    ],
                  ),
                ),


              )
            ],
          ),
        ],
      ),
    );

    Widget content4 = SizedBox(
      height: 200,
      child: ListView.builder(
        padding: EdgeInsets.all(10),
          itemCount: postData.length,
          itemBuilder: (context, index){
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${postData[index].name}'),
                    SizedBox(height: 20,),
                    Image.asset('${postData[index].avatar}'),
                    Text('${postData[index].avatar}')
                  ],
                ),
              ),

            );
          })
    );


    return Scaffold(
      // appBar: AppBar(
      //  title: Text(widget.title),
      //   actions: [],
      // ),
      body: new ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                head,
                SizedBox(height: 25,),
                content1,
                SizedBox(height: 30,),
                content2,
                content3,
                SizedBox(height: 30,),

              ],
            ),
          )
        ],
      ),

      bottomNavigationBar: BottomMenuBar()
      // BottomNavigationBar(
      //   backgroundColor: Color(0xffe0e0e0),
      //   // selectedItemColor: Color(0xffc62828),
      //   // unselectedItemColor: Colors.black38,
      //   currentIndex: this.currentIndex,
      //   onTap: (index) => setState(() {
      //     currentIndex = index;
      //     if(index == 1) {
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => History(data)));
      //     } else if (index == 2){
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => ListBook(title: "")));
      //     } else if (index == 3){
      //       Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(data)));
      //     }
      //   }),
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home,),
      //         label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.history, ),
      //         label: 'History'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.bookmark, ),
      //         label: 'Favorite',),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_circle, ),
      //         label: 'User',
      //     ),
      //   ],
      // ),
    );
  }
}

class CustomSearch extends SearchDelegate {
  List<Post> postData = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){
            query = '';
          },
          icon: Icon(Icons.clear)
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context)  {
    List<String> matchQuery = [];
    for (var item in postData) {
      if (item.name!.toLowerCase().contains(query.toLowerCase())) {
        print(item.name.toString());
        matchQuery.add(item.name.toString());
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result)
          );
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var item in postData) {
      if (item.name!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item.name.toString());
      }
    }

    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
              title: Text(result)
          );
        });
  }
}

