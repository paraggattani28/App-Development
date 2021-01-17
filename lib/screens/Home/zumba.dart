import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
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
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project3/screens/Home/upload_zumba.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project3/screens/Home/useruploads.dart';

class Zumba extends StatefulWidget {
  @override
  _ZumbaState createState() => _ZumbaState();
}

class _ZumbaState extends State<Zumba> with TickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;
  VideoPlayerController playerController;
  VoidCallback listener;

  final AuthService _auth = AuthService();
  @override
  void initState() {
    super.initState();
    listener = () {
      setState(() {});
    };
    tabController =
        new TabController(vsync: this, initialIndex: selectedIndex, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void createVideo(link) {
    if (playerController == null) {
      playerController = VideoPlayerController.network(link)
        ..addListener(listener)
        ..setVolume(1.0)
        ..initialize()
        ..play();
    } else {
      if (playerController.value.isPlaying) {
        playerController.pause();
      } else {
        playerController.initialize();
        playerController.play();
      }
    }
  }

  @override
  void deactivate() {
    playerController.setVolume(0.0);
    playerController.removeListener(listener);
    super.deactivate();
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
          return StreamBuilder<QuerySnapshot>(
              stream: DatabaseHome().zumbaData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  QuerySnapshot upload = snapshot.data;
                  List titles = snapshot.data.documents
                      .map((doc) => doc["title"])
                      .toList();
                  List details = snapshot.data.documents
                      .map((doc) => doc["details"])
                      .toList();
                  List videoLink = snapshot.data.documents
                      .map((doc) => doc["videoLink"])
                      .toList();
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
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
                                currentAccountPicture: userData.imageLink !=
                                        null
                                    ? CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        child: ClipOval(
                                          child:
                                              Image.network(userData.imageLink),
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
                                    colors: [
                                      Color(0XFF292C36),
                                      Color(0xFF696D77)
                                    ],
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.accessibility),
                                title: Text('Home'),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage()),
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.upload_rounded),
                                title: Text('Your Uploads'),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Uploads()),
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.account_circle_rounded),
                                title: Text('Profile'),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile()),
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.account_balance_rounded),
                                title: Text('About'),
                                onTap: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => About()),
                                  );
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                    Icons.airline_seat_flat_angled_outlined),
                                title: Text('signout'),
                                onTap: () async {
                                  dynamic result = await _auth.signOut();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignIn()),
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
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: Container(
                            child: (playerController != null
                                ? VideoPlayer(
                                    playerController,
                                  )
                                : Container(
                                    padding: EdgeInsets.all(15.0),
                                    child: ListView.builder(
                                        itemCount: titles.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Card(
                                              margin: EdgeInsets.fromLTRB(
                                                  20.0, 6.0, 20.0, 0.0),
                                              child: ListTile(
                                                onTap: () {
                                                  print('Card presses');
                                                  createVideo(
                                                      '${videoLink[index]}');
                                                  playerController.play();
                                                },
                                                leading: Icon(
                                                  Icons.video_label,
                                                ),
                                                title: Text('${titles[index]}'),
                                                subtitle:
                                                    Text('${details[index]}'),
                                                trailing: Icon(
                                                  Icons.play_arrow,
                                                  color: Colors.pinkAccent,
                                                ),
                                                isThreeLine: true,
                                              ),
                                            ),
                                          );
                                        }),
                                  )),
                          ),
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        backgroundColor: Colors.pinkAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadZumbavideo()),
                          );
                        },
                        child: Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                  );
                }
              });
        }
      },
    );
  }
}
