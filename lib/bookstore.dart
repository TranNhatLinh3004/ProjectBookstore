import 'package:bookstore/search_book.dart';
import 'package:bookstore/widgets/bottom_menu_bar.dart';
import 'package:bookstore/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookstore/data.dart';
import 'package:bookstore/constants.dart';
import 'package:bookstore/book_detail.dart';

class Bookstore extends StatefulWidget {
  static const routeName = '/bookstore';

  @override
  _BookstoreState createState() => _BookstoreState();
}

class _BookstoreState extends State<Bookstore> {

  List<Filter> filters = getFilterList();
  Filter selectedFilter;

  // List<NavigationItem> navigationItems = getNavigationItemList();
  // NavigationItem selectedItem;

  List<Book> books = getBookList();
  List<Author> authors = getAuthorList();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedFilter = filters[0];
      // selectedItem = navigationItems[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          brightness: Brightness.light,
          leading: Icon(
            Icons.sort,
            color: kPrimaryColor,
            size: 28,
          ),
          actions: [
            // Navigate to the Search Screen
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) =>  SearchBook())),
                icon: const Icon(Icons.search,color: Color(0xFFEC3133),))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Container(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 8,
                    blurRadius: 12,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Discover books",
                    style: GoogleFonts.catamaran(
                      fontWeight: FontWeight.w900,
                      fontSize: 40,
                      height: 1,
                    ),
                  ),

                  // SizedBox(
                  //   height: 5,
                  // ),
                  // Padding(child: Container(
                  //   width: double.infinity,
                  //   height: 40,
                  //   color: Colors.white,
                  //   child: const Center(
                  //     child: TextField(
                  //       decoration: InputDecoration(
                  //           hintText: 'Search for something',
                  //           prefixIcon: Icon(Icons.search),
                  //           suffixIcon: Icon(Icons.camera_alt)),
                  //     ),
                  //   ),
                  // ),
                  // ),

                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                  //   child: Container(
                  //     padding: EdgeInsets.only(top:0),
                  //     height: 45,
                  //     // width: MediaQuery.of(context).size.width * 0.755,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: Color(0xffC4C4C4),
                  //     ),
                  //     child: TextField(
                  //       // obscureText: false,
                  //
                  //       decoration: InputDecoration(
                  //         // border: OutlineInputBorder(
                  //         //   borderSide: BorderSide(
                  //         //       color: Colors.white
                  //         //   ),
                  //         // ),
                  //         enabledBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.white),
                  //           borderRadius: BorderRadius.circular(20),
                  //         ),
                  //         hintText: "Search keyboards",
                  //         prefixIcon: Icon(Icons.search),
                  //         // contentPadding: EdgeInsets.all(10),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // Form(
                  //     key: _formKey,
                  //     child: SearchField(
                  //       suggestions: _statesOfIndia.map((e) =>
                  //           SearchFieldListItem(e)).toList(),
                  //       suggestionState: Suggestion.expand,
                  //       textInputAction: TextInputAction.next,
                  //       hint: 'SearchField Example 2',
                  //       hasOverlay: false,
                  //       searchStyle: TextStyle(
                  //         fontSize: 18,
                  //         color: Colors.black.withOpacity(0.8),
                  //       ),
                  //       validator: (x) {
                  //         if (!_statesOfIndia.contains(x) || x!.isEmpty) {
                  //           return 'Please Enter a valid State';
                  //         }
                  //         return null;
                  //       },
                  //       searchInputDecoration: InputDecoration(
                  //         focusedBorder: OutlineInputBorder(
                  //           borderSide: BorderSide(
                  //             color: Colors.black.withOpacity(0.8),
                  //           ),
                  //         ),
                  //         border: OutlineInputBorder(
                  //           borderSide: BorderSide(color: Colors.red),
                  //         ),
                  //       ),
                  //       maxSuggestionsInViewPort: 6,
                  //       itemHeight: 50,
                  //       onTap: (x) {},
                  //     )
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 75),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: buildFilters(),
                    ),
                  ),

                ],
              ),
            ),

            Expanded(

              child: Container(
                // height: 1500,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: buildBooks(),
                ),
              ),
            ),


            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [

                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          "Authors to follow",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        Row(
                          children: [

                            Text(
                              "Show all",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor,
                              ),
                            ),

                            SizedBox(
                              width: 8,
                            ),

                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: kPrimaryColor,
                            ),

                          ],
                        ),

                      ],
                    ),
                  ),

                  Container(
                    height: 100,
                    margin: EdgeInsets.only(bottom: 16),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: buildAuthors(),
                    ),
                  ),

                ],
              ),
            ),

          ],
        ),
        bottomNavigationBar: BottomMenuBar()

      // Container(
      //   height: 70,
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(25),
      //       topRight: Radius.circular(25),
      //     ),
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.2),
      //         spreadRadius: 8,
      //         blurRadius: 12,
      //         offset: Offset(0, 3),
      //       ),
      //     ],
      //   ),
      //   // child: Row(
      //   //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   //   children: BottomMenuBar(),
      //   //   ,
      //   // ),
      // ),
    );
  }

  List<Widget> buildFilters(){
    List<Widget> list = [];
    for (var i = 0; i < filters.length; i++) {
      list.add(buildFilter(filters[i]));
    }
    return list;
  }

  Widget buildFilter(Filter item){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = item;
        });
      },
      child: Container(
        height: 50,
        child: Stack(
          children: <Widget>[

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 30,
                height: 3,
                color: selectedFilter == item ? kPrimaryColor : Colors.transparent,
              ),
            ),

            Center(
              child: Text(
                item.name,
                style: GoogleFonts.catamaran(
                  color: selectedFilter == item ? kPrimaryColor : Colors.grey[400],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
  List<Widget> buildBooks(){
    List<Widget> list = [];
    for (var i = 0; i < books.length; i++) {
      list.add(buildBook(books[i], i));
    }
    return list;
  }

  Widget buildBook(Book book, int index){
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookDetail(book: book)),
          );
        },
      child: Container(
        margin: EdgeInsets.only(right: 32, left: index == 0 ? 16 : 0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 12,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 16, top: 24,),
                child: Hero(
                  tag: book.title,
                  child: Image.asset(
                    book.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),

            Text(
              book.title,
              style: GoogleFonts.catamaran(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              book.author.fullname,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),

          ],
        ),
      ),
    );
  }


  List<Widget> buildAuthors(){
    List<Widget> list = [];
    for (var i = 0; i < authors.length; i++) {
      list.add(buildAuthor(authors[i], i));
    }
    return list;
  }

  Widget buildAuthor(Author author, int index){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
      width: 255,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          Card(
            elevation: 4,
            margin: EdgeInsets.all(0),
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(author.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(
            width: 12,
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                author.fullname,
                style: GoogleFonts.catamaran(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                children: [

                  Icon(
                    Icons.library_books,
                    color: Colors.grey,
                    size: 14,
                  ),

                  SizedBox(
                    width: 8,
                  ),

                  Text(
                    author.books.toString() + " books",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),

            ],
          ),

        ],
      ),
    );
  }
//
// List<Widget> buildNavigationItems(){
//   List<Widget> list = [];
//   for (var navigationItem in navigationItems) {
//     list.add(buildNavigationItem(navigationItem));
//   }
//   return list;
// }

// Widget buildNavigationItem(NavigationItem item){
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         selectedItem = item;
//       });
//     },
//     child: Container(
//       width: 50,
//       child: Center(
//         child: Icon(
//           item.iconData,
//           color: selectedItem == item ? kPrimaryColor : Colors.grey[400],
//           size: 28,
//         ),
//       ),
//     ),
//   );
// }

}