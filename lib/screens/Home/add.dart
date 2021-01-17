import 'package:flutter/material.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project3/screens/Home/home.dart';
import 'package:project3/screens/Home/profile.dart';
import 'package:project3/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project3/services/auth.dart';
import 'package:project3/screens/authenticate/sign_in.dart';
import 'package:project3/models/user.dart';
import 'package:project3/screens/Home/about.dart';
import 'package:project3/screens/Home/useruploads.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AddVideos extends StatefulWidget {
  @override
  _AddVideosState createState() => _AddVideosState();
}

class _AddVideosState extends State<AddVideos> with TickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;
  String videoLink;
  File _video;

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
    final _uploadKey = GlobalKey<FormState>();

    String details;
    String title;
    String error_upload;

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;
          return MaterialApp(
            home: Scaffold(
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
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: AssetImage('images/cardio.jpg'),
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
                        title: Text('profile'),
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
                        leading: Icon(Icons.add),
                        title: Text('Upload'),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddVideos()),
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
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _uploadKey,
                      child: Column(
                        children: [
                          TextFormField(
                            maxLines: 10,
                            minLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter Title',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter Title of video' : null,
                            onChanged: (val) {},
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            maxLines: 10,
                            minLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter details',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Enter Details of video' : null,
                            onChanged: (val) {
                              setState(() => details = val);
                            },
                          ),
                        ],
                      ),
                    ),
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
