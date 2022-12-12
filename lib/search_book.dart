import 'package:bookstore/data.dart';
import 'package:flutter/material.dart';

import 'book_detail.dart';

class SearchBook extends StatefulWidget {
  // const SearchBook({Key? key}) : super(key: key);

  @override
  State<SearchBook> createState() => _SearchBookState();
}

class _SearchBookState extends State<SearchBook> {
   List<Book> display_list = List.from(getBookList());

  void updateList(String value){
    setState(() {
      display_list = getBookList().where((element) => element.title.toLowerCase().contains(value.toLowerCase())).toList() ??[] ;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Color(0xFF1C1F3F),
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  onChanged: (value) => updateList(value),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          /* Clear the search field */
                        },
                      ),
                      hintText: 'Search for a book',
                      border: InputBorder.none),
                ),
              ),
            )
        ),

        backgroundColor: Color(0xFF323550),
         body: Container(
           margin: EdgeInsets.only(left: 20),
           child: display_list.length == 0 ? Text("Now result found" ,style: TextStyle(color: Colors.white,fontSize: 25),): ListView.builder(

               itemCount: getBookList().length,
               itemBuilder: (context,index) => ListTile(
                 onTap: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => BookDetail(book: display_list[index])),
                   );
                 },
                 title: Text(display_list[index].title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                 subtitle: Text(display_list[index].author.fullname,style: TextStyle(color: Colors.grey),),
                 leading: Image.network(display_list[index].image ),
               )





           ),

         )


    );
  }
}
