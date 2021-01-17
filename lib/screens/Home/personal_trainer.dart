import 'package:flutter/material.dart';
import 'package:project3/services/auth.dart';
import 'package:project3/screens/Home/courses.dart';
import 'package:project3/screens/Home/home.dart';
import 'package:project3/screens/Home/profile.dart';
import 'package:project3/screens/Home/useruploads.dart';

class Personal extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PersonalTrainer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PersonalTrainer extends StatefulWidget {
  @override
  _PersonalTrainer createState() => _PersonalTrainer();
}

class _PersonalTrainer extends State<PersonalTrainer> {
  @override
  final AuthService _auth = AuthService();
  int _currentIndex = 1;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Stay.fit'),
        backgroundColor: Colors.black,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.person),
            label: Text(
              'logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.beenhere_rounded),
            title: Text('Courses'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new_outlined),
            title: Text('Personal Trainer'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          switch (_currentIndex) {
            case 0:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Home()));
              break;
            case 1:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Personal()));
              break;
            case 2:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Courses()));
              break;
            case 3:
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Profile()));
              break;
          }
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: SingleChildScrollView(
          child: Text(
            'Welcome to our Stay.fit \n this is personal trainer page',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 20.0,
              letterSpacing: 2.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
