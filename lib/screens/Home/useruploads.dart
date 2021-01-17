import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project3/screens/Home/home.dart';
import 'package:project3/screens/Home/userakhada.dart';
import 'package:project3/screens/Home/usercardio.dart';
import 'package:project3/screens/Home/usercircuit.dart';
import 'package:project3/screens/Home/usercrossfit.dart';
import 'package:project3/screens/Home/userflexibility.dart';
import 'package:project3/screens/Home/userhiit.dart';
import 'package:project3/screens/Home/userjudo.dart';
import 'package:project3/screens/Home/userkarate.dart';
import 'package:project3/screens/Home/userresistance.dart';
import 'package:project3/screens/Home/userstrength.dart';
import 'package:project3/screens/Home/useryoga.dart';
import 'package:project3/screens/Home/userzumba.dart';
import 'package:project3/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project3/services/auth.dart';
import 'package:project3/screens/authenticate/sign_in.dart';
import 'package:project3/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/screens/Home/profile.dart';
import 'package:project3/screens/Home/upload_yoga.dart';
import 'package:project3/screens/Home/about.dart';
import 'package:project3/screens/Home/useruploads.dart';

class UserUploads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Uploads(),
    );
  }
}

class Uploads extends StatefulWidget {
  @override
  _UploadsState createState() => _UploadsState();
}

class _UploadsState extends State<Uploads> with TickerProviderStateMixin {
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
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Playlists',
                        style: TextStyle(
                          fontFamily: 'AndikaNewBasic-Regular',
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserAkhada()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Akhada'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserCardio()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Cardio'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserCircuit()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Circuit'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserCrossfit()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('CrossFit'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserFlexibility()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Flexibility'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserHiit()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('HIIT'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserJudo()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Judo'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserKarate()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Karate'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserResistance()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Resistance'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserStrength()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Strength'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserYoga()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Yoga'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserZumba()),
                          );
                        },
                        leading: Icon(
                          Icons.videocam,
                        ),
                        title: Text('Zumba'),
                        subtitle:
                            Text('Click here to see your uploaded videos.'),
                        trailing: Icon(
                          Icons.more_vert,
                          color: Colors.pinkAccent,
                        ),
                      ),
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
