import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project3/screens/Home/edit_form.dart';
import 'package:project3/screens/Home/home.dart';
import 'package:project3/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project3/services/auth.dart';
import 'package:project3/screens/authenticate/sign_in.dart';
import 'package:project3/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project3/screens/Home/about.dart';
import 'package:project3/screens/Home/upload_yoga.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project3/screens/Home/useruploads.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileInfo(),
    );
  }
}

class ProfileInfo extends StatefulWidget {
  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo>
    with TickerProviderStateMixin {
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
    void _showEditForm() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: EditForm(),
            );
          });
    }

    User user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData userData = snapshot.data;

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
              body: Container(
                width: double.infinity,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 64,
                    ), //just for spacing

                    userData.imageLink != null
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
                              size: 100,
                            ),
                            radius: 100,
                          ),

                    SizedBox(
                      height: 16,
                    ), //just for spacing

                    FlatButton(
                      child: Text("Change Image"),
                      onPressed: () async {
                        _image = await ImagePicker.pickImage(
                            source: ImageSource.gallery);

                        FirebaseStorage fs = FirebaseStorage.instance;

                        StorageReference rootReference = fs.ref();

                        StorageReference pictureFolderRef = rootReference
                            .child("pictures")
                            .child(userData.email);

                        pictureFolderRef
                            .putFile(_image)
                            .onComplete
                            .then((storageTask) async {
                          String link = await storageTask.ref.getDownloadURL();
                          print("uploaded");
                          setState(() {
                            imageLink = link;
                          });
                          await DatabaseService(uid: user.uid).updateUserData(
                              userData.email,
                              userData.mobile,
                              userData.address,
                              userData.username,
                              imageLink,
                              userData.register);
                        });
                        print(imageLink);
                      },
                      color: Colors.pinkAccent,
                      textColor: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Username : ' + userData.username,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'AndikaNewBasic-Regular',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Email : ' + userData.email,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'AndikaNewBasic-Regular',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Contact Number : ' + userData.mobile,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'AndikaNewBasic-Regular',
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Address : ' + userData.address,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontFamily: 'AndikaNewBasic-Regular',
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    new FlatButton(
                      color: Colors.pinkAccent,
                      child: new Text(
                        "Edit Profile",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        _showEditForm();
                      },
                    ),
                    FlatButton(
                      child: Text("Delete Your Account"),
                      onPressed: () async {
                        // Remove the tapped document here - how?
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Are you sure?"),
                              content:
                                  new Text("you want to delete your account?"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                new FlatButton(
                                  child: new Text("Delete"),
                                  onPressed: () async {
                                    print(user.uid);
                                    Navigator.of(context).pop();
                                    dynamic result = await _auth.signOut();

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignIn()),
                                    );
                                    await AuthService()
                                        .deleteUser(userData.email);
                                    // docRef.delete();
                                    //snapshot.data.documents[index].delete();
                                    Firestore.instance
                                        .collection("user")
                                        .document(user.uid)
                                        .delete();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
