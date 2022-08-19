import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class CategoryModelFirst {
//   CategoryModelFirst(
//       {required this.title, required this.image, required this.color});
//
//   String title;
//   String image;
//   String color;
// }
//
// List<CategoryModelFirst> categoryFirst = <CategoryModelFirst>[
//   CategoryModelFirst(
//     title: 'Games',
//     image: 'assets/images/football.png',
//     color: '0xffFFE2AB',
//   ),
//   CategoryModelFirst(
//       title: 'Grocery',
//       image: 'assets/images/grocery.png',
//       color: '0xffFFDFCD',),
//   CategoryModelFirst(
//       title: 'Education',
//       image: 'assets/images/education.png',
//       color: '0xffFFA2C0',),
//   CategoryModelFirst(
//     title: 'Search',
//     image: 'assets/images/search.png',
//     color: '0xffF6F6F6',
//   ),
// ];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // TextEditingController editingController = TextEditingController();
  // String query = '';
  // List<CategoryModelFirst>? searchItems;

  // void searchItemss(String query) {
  //   final searchItems = categoryFirst.where((searchItems) {
  //     final titleLower = searchItems.title.toLowerCase();
  //     final searchLower = query.toLowerCase();
  //
  //     return titleLower.contains(searchLower);
  //   }).toList();
  //
  //   setState(() {
  //     this.query = query;
  //     this.searchItems = searchItems;
  //   });
  // }

  late String title = '';
  List<Map<String, dynamic>> data = [
    {
      'title': 'Games',
      'image': 'assets/images/football.png',
      'color': '0xffFFE2AB',
    },
    {
      'title': 'Games',
      'image': 'assets/images/football.png',
      'color': '0xffFFE2AB',
    },
    {
      'title': 'Education',
      'image': 'assets/images/education.png',
      'color': '0xffFFA2C0',
    },
    {
      'title': 'Search',
      'image': 'assets/images/search.png',
      'color': '0xffF6F6F6',
    },
  ];

  // addData() {
  //   for (var element in data) {
  //     FirebaseFirestore.instance.collection('category').add(element);
  //   }
  //   print('element');
  // }
  //
  // @override
  // void initState() {
  //   addData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FireStore'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 10),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: TextField(
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xffFFBE78),
                  size: 25,
                ),
                hintText: 'Category',
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 15, left: 15),
              ),
              onChanged: (val) {
                setState(() {
                  title = val;
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('category').snapshots(),
              builder: (context, snapshots) {
                return (snapshots.connectionState == ConnectionState.waiting)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshots.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data = snapshots.data!.docs[index].data()
                              as Map<String, dynamic>;
                          if (title.isNotEmpty) {
                            print('object');
                            return ListTile(
                              title: Text(
                                data[title],
                              ),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Color(int.parse(data['color'])),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(data[
                                      'image']), //child: Image.asset(data['image']),
                                ),
                              ),
                            );
                          }

                          if (data['title']
                              .toString()
                              .toLowerCase()
                              .startsWith(title.toLowerCase()))
                            print('object');
                          {
                            return ListTile(
                              title: Text(
                                data['title'],
                              ),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor:
                                    Color(int.parse(data['color'])),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    data['image'],
                                  ), //child: Image.asset(data['image']),
                                ),
                              ),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Container(
//   margin: EdgeInsets.only(top: 15, left: 15, right: 10),
//   width: double.infinity,
//   height: 50,
//   decoration: BoxDecoration(
//       color: Colors.white, borderRadius: BorderRadius.circular(30)),
//   child: TextField(
//     controller: editingController,
//     decoration: InputDecoration(
//         suffixIcon: Icon(
//           Icons.search,
//           color: Color(0xffFFBE78),
//           size: 25,
//         ),
//         hintText: 'Category',
//         border: InputBorder.none,
//         contentPadding: EdgeInsets.only(top: 15, left: 15)),
//   ),
// ),

// Expanded(
//   child: ListView.builder(
//     itemCount: categoryFirst.length,
//     itemBuilder: (context, index) {
//       final searchItems = categoryFirst[index];
//       return ListTile(
//         title: Text(searchItems.title),
//         leading: CircleAvatar(
//           radius: 25,
//           backgroundColor: Color(int.parse(searchItems.color)),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(30),
//             child: Image.asset(searchItems.image),
//           ),
//         ),
//       );
//     },
//   ),
// ),
