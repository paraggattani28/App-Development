import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            // centerTitle: true,
            leading: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.menu_rounded,
                size: 30.0,
                color: Colors.black,
              ),
            ),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                  height: 300.0,
                  child: Column(
                    children: <Widget>[
                      TabBar(
                        // controller: TabController(
                        //     length: 3, vsync: this, initialIndex: 0),
                        unselectedLabelColor: Colors.black,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.lightBlue[100],
                        ),
                        tabs: <Widget>[
                          Tab(
                            text: "PT",
                          ),
                          Tab(
                            text: "Online",
                          )
                        ],
                      ),
                      Expanded(child: TabBarView(children: [null]))
                    ],
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(
              Icons.search,
              color: Colors.black,
              size: 30.0,
            ),
            backgroundColor: Colors.lightBlue[100],
          ),
        ),
      ),
    ));

// children: <Widget>[
//       Text('all my cards and listView'),
//       TabBarView(children: [
//         Icon(Icons.car_rental),
//         Icon(Icons.bike_scooter),
//       ]),
//     ],

// // menu_outlined → const IconData
// // menu — material icon named "menu outlined".
// // IconData(58056, fontFamily: 'MaterialIcons')

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return HomeState();
//   }
// }

// class HomeState extends State<Home> with SingleTickerProviderStateMixin {
//   TabController tabController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     tabController = TabController(length: 3, vsync: this, initialIndex: 0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: ListView(
//         children: <Widget>[
//           DummySection(
//             height: 100.0,
//             color: Colors.red,
//           ),
//           DummySection(
//             height: 150.0,
//             color: Colors.yellow,
//           ),
//           Container(
//             height: 350.0,
//             color: Colors.blue,
//             child: Column(
//               children: <Widget>[
//                 TabBar(
//                   unselectedLabelColor: Colors.blue[100],
//                   indicator: BoxDecoration(color: Colors.lightBlue),
//                   controller: tabController,
//                   tabs: <Widget>[
//                     Tab(
//                       text: "Home",
//                     ),
//                     Tab(
//                       text: "Fav",
//                     ),
//                     Tab(
//                       text: "Star",
//                     )
//                   ],
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                       controller: tabController,
//                       children: [DummyList(), DummyList(), DummyList()]),
//                 )
//               ],
//             ),
//           ),
//           DummySection(
//             height: 100.0,
//             color: Colors.red,
//           ),
//           DummySection(
//             height: 100.0,
//             color: Colors.pink,
//           )
//         ],
//       ),
//     );
//   }
// }

// // Dummy List Container
// class DummySection extends StatelessWidget {
//   Color color;
//   double height;
//   DummySection({this.color, this.height});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Container(
//       color: color,
//       height: height,
//     );
//   }
// }

// // Dummy Listing for tab
// class DummyList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return ListView(
//       children: <Widget>[
//         Card(
//           child: Container(
//             height: 200.0,
//             alignment: Alignment.center,
//             child: Text("hello"),
//           ),
//         ),
//         Card(
//           child: Container(
//             height: 200.0,
//             alignment: Alignment.center,
//             child: Text("hello"),
//           ),
//         ),
//       ],
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(new MyApp());
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
//   TabController tabController;
//   int selectedIndex = 0;
//   @override
//   void initState() {
//     super.initState();
//     tabController =
//         new TabController(vsync: this, initialIndex: selectedIndex, length: 2);
//   }

//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.transparent,
//           elevation: 0,
//           // centerTitle: true,
//           leading: GestureDetector(
//             onTap: () {},
//             child: Icon(
//               Icons.menu_rounded,
//               size: 30.0,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         body: ListView(
//           children: <Widget>[
//             Container(
//                 height: 300.0,
//                 child: Column(
//                   children: <Widget>[
//                     Container(height: 30),
//                     TabBar(
//                       controller: tabController,
//                       unselectedLabelColor: Colors.black,
//                       indicator: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         color: Colors.pinkAccent[100],
//                       ),
//                       tabs: <Widget>[
//                         Tab(
//                           text: "Online",
//                         ),
//                         Tab(
//                           text: "PT",
//                         ),
//                       ],
//                       onTap: (int index) {
//                         setState(() {
//                           selectedIndex = index;
//                           tabController.animateTo(index);
//                         });
//                       },
//                     ),
//                     Divider(height: 0),
//                     IndexedStack(
//                       children: <Widget>[
//                         Visibility(
//                           child: Container(
//                             height: 200,
//                             child: Text(
//                               "You haven't signed up for any courses",
//                               style: TextStyle(fontSize: 30.0),
//                             ),
//                           ),
//                           maintainState: true,
//                           visible: selectedIndex == 0,
//                         ),
//                         Visibility(
//                           child: Container(
//                             height: 200,
//                             child: Center(
//                               child: Center(
//                                 child: Text(
//                                   'personal trainer content',
//                                   style: TextStyle(fontSize: 30.0),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           maintainState: true,
//                           visible: selectedIndex == 1,
//                         ),
//                       ],
//                       index: selectedIndex,
//                     ),
//                   ],
//                 ))
//           ],
//         ),
//       ),
//     );
//   }
// }
