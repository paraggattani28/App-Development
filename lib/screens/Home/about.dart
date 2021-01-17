import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project3/screens/Home/home.dart';
import 'package:project3/screens/Home/useruploads.dart';
import 'package:project3/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project3/services/auth.dart';
import 'package:project3/screens/authenticate/sign_in.dart';
import 'package:project3/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/screens/Home/profile.dart';
import 'package:project3/screens/Home/upload_yoga.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AboutPage(),
    );
  }
}

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;
  String imageLink;
  File _image;

  final AuthService _auth = AuthService();
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

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomPadding: false,
              drawer: Drawer(
                child: Container(
                  color: Colors.white,
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 0,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(userData.username),
                        accountEmail: Text(userData.email),
                        currentAccountPicture: userData.imageLink != null
                            ? CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: ClipOval(
                                  child: Image.network(userData.imageLink),
                                ),
                                radius: 100,
                              )
                            : CircleAvatar(
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                ),
                                radius: 100,
                              ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0XFF292C36), Color(0xFF696D77)],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.accessibility),
                        title: Text('Home'),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.upload_rounded),
                        title: Text('Your Uploads'),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Uploads()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle_rounded),
                        title: Text('Profile'),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_balance_rounded),
                        title: Text('About'),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => About()),
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.airline_seat_flat_angled_outlined),
                        title: Text('Signout'),
                        onTap: () async {
                          dynamic result = await _auth.signOut();

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignIn()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.pinkAccent,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                // centerTitle: true,
              ),
              body: Center(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Stay.fit is a preventive and curative healthcare & fitness company in Bengaluru, India.It provides online training sessions to people according to their needs and requirements, they can choose what do they want to go for. It also provides Personal Home training sessions to people who wants personal trainer for assisstance at home. \n Stay.fit believes in healthy, nutritious and fit life and so here are we.',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'AndikaNewBasic-Regular',
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.location_city,
                            ),
                            title: Text(
                              'Bengaluru',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.people,
                            ),
                            title: Text(
                              '3',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.money,
                            ),
                            title: Text(
                              'Null',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.flag,
                            ),
                            title: Text(
                              'Private',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.map,
                            ),
                            title: Text(
                              'stayfit.com',
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: 40,
                      // ),
                      // Image.asset(
                      //   'images/boxing.jpg',
                      //   fit: BoxFit.cover,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
