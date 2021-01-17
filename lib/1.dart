import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    tabController =
        new TabController(vsync: this, initialIndex: selectedIndex, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
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
                    Container(height: 30),
                    TabBar(
                      controller: tabController,
                      unselectedLabelColor: Colors.black,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.pinkAccent[100],
                      ),
                      tabs: <Widget>[
                        Tab(
                          text: "Online",
                        ),
                        Tab(
                          text: "PT",
                        ),
                      ],
                      onTap: (int index) {
                        setState(() {
                          selectedIndex = index;
                          tabController.animateTo(index);
                        });
                      },
                    ),
                    Divider(height: 0),
                    IndexedStack(
                      children: <Widget>[
                        Visibility(
                          child: Container(
                            height: 200,
                            child: Text(
                              "You haven't signed up for any courses",
                              style: TextStyle(fontSize: 30.0),
                            ),
                          ),
                          maintainState: true,
                          visible: selectedIndex == 0,
                        ),
                        Visibility(
                          child: Container(
                            height: 200,
                            child: Center(
                              child: Center(
                                child: Text(
                                  'personal trainer content',
                                  style: TextStyle(fontSize: 30.0),
                                ),
                              ),
                            ),
                          ),
                          maintainState: true,
                          visible: selectedIndex == 1,
                        ),
                      ],
                      index: selectedIndex,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
