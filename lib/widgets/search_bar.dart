import 'package:flutter/material.dart';

import '../constants.dart';
import '../search_book.dart';

class SearchBar extends StatelessWidget {
  // const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color(0xFF1C1F3F),
        //     title: Container(
        //       width: double.infinity,
        //       height: 40,
        //       decoration: BoxDecoration(
        //           color: Colors.white, borderRadius: BorderRadius.circular(5)),
        //       child: Center(
        //         child: TextField(
        //           onChanged: (value) => updateList(value),
        //           decoration: InputDecoration(
        //               prefixIcon: const Icon(
        //                 Icons.search,
        //               ),
        //               suffixIcon: IconButton(
        //                 icon: const Icon(Icons.clear),
        //                 onPressed: () {
        //                   /* Clear the search field */
        //                 },
        //               ),
        //               hintText: 'Search for a book',
        //               border: InputBorder.none),
        //         ),
        //       ),
        //     )
        // ),
        body: SearchBook()
    );

  }
}

