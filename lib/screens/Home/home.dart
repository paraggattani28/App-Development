import 'package:flutter/material.dart';
import 'package:project3/screens/Home/add.dart';
import 'package:project3/screens/Home/akhada.dart';
import 'package:project3/screens/Home/cardio.dart';
import 'package:project3/screens/Home/circuit.dart';
import 'package:project3/screens/Home/crossfit.dart';
import 'package:project3/screens/Home/flexibility.dart';
import 'package:project3/screens/Home/hiit.dart';
import 'package:project3/screens/Home/judo.dart';
import 'package:project3/screens/Home/profile.dart';
import 'package:project3/screens/Home/karate.dart';
import 'package:project3/screens/Home/resistance.dart';
import 'package:project3/screens/Home/strength.dart';
import 'package:project3/screens/Home/useruploads.dart';
import 'package:project3/screens/Home/zumba.dart';
import 'package:project3/services/database.dart';
import 'package:provider/provider.dart';
import 'package:project3/services/auth.dart';
import 'package:project3/screens/authenticate/sign_in.dart';
import 'package:project3/models/user.dart';
import 'package:project3/screens/Home/about.dart';
import 'package:project3/screens/Home/yoga.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController tabController;
  int selectedIndex = 0;
  bool register = false;

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

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title:
              new Text("Are you sure? You want to register for this package?"),
          content: new Text(
              "The amount will be collected by our personal trainer at your place."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                child: ListView(
                  children: <Widget>[
                    Container(
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
                          SizedBox(
                            height: 30,
                          ),
                          IndexedStack(
                            children: <Widget>[
                              Visibility(
                                child: Container(
                                  padding: const EdgeInsets.all(7),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Karate()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/karate.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Karate',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Judo()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/judo.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Judo',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Yoga()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/yoga.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Yoga',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Akhada()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/akhada.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Akhada',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Cardio()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/cardio.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Cardio',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Circuit()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(10.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/circuit.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Circuit',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Crossfit()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(9.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/crossfit.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Cross-fit',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Resistance()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(9.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/resistance.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Resistance',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Zumba()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(9.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/zumba.png'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Zumba',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Hiit()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(9.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/hiit.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'HIIT \n',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Flexibility()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(9.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/flexibility training.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Flexibility \n Training',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Card(
                                                child: InkWell(
                                                  splashColor:
                                                      Colors.blue.withAlpha(30),
                                                  onTap: () {
                                                    print('Card tapped.');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Strength()),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(9.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        CircleAvatar(
                                                          radius: 52,
                                                          backgroundColor:
                                                              Colors.black,
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                AssetImage(
                                                                    'images/strength training.jpg'),
                                                            backgroundColor:
                                                                Colors.white,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Strength \n Training',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Pacifico',
                                                            fontSize: 15.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 2.0,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                maintainState: true,
                                visible: selectedIndex == 0,
                              ),
                              Visibility(
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          userData.register != true
                                              ? Column(
                                                  children: [
                                                    Text(
                                                      'Hello ' +
                                                          userData.username +
                                                          '! \nPersonal Training will help you stay fit, by motivating you daily. Our Personal Trainers will come at your doorstep at your suitable timings, according to the package chosen by you.\nSelect one plan from the plans below and enjoy regular workout and stay fit & healthy.',
                                                      style: TextStyle(
                                                        fontSize: 17.0,
                                                        fontFamily:
                                                            'AndikaNewBasic-Regular',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 30,
                                                    ),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.attach_money,
                                                      ),
                                                      title: Text(
                                                        '5000/month',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      subtitle:
                                                          Text('for 6 months'),
                                                      trailing:
                                                          Icon(Icons.more_vert),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            // return object of type Dialog
                                                            return AlertDialog(
                                                              title: new Text(
                                                                  "Are you sure? You want to register for this package?"),
                                                              content: new Text(
                                                                  "The amount will be collected by our personal trainer at your place."),
                                                              actions: <Widget>[
                                                                // usually buttons at the bottom of the dialog
                                                                new FlatButton(
                                                                  child: new Text(
                                                                      "Cancel"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                new FlatButton(
                                                                  child: new Text(
                                                                      "Register"),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      register =
                                                                          true;
                                                                    });
                                                                    await DatabaseService(uid: user.uid).updateUserData(
                                                                        userData
                                                                            .email,
                                                                        userData
                                                                            .mobile,
                                                                        userData
                                                                            .address,
                                                                        userData
                                                                            .username,
                                                                        userData
                                                                            .imageLink,
                                                                        register);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        // return object of type Dialog
                                                                        return AlertDialog(
                                                                          title:
                                                                              new Text("Congratulations !!"),
                                                                          content:
                                                                              new Text("You have registered successfully to this package"),
                                                                          actions: <
                                                                              Widget>[
                                                                            // usually buttons at the bottom of the dialog
                                                                            new FlatButton(
                                                                              child: new Text("Close"),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                    print(
                                                                        'True');
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.attach_money,
                                                      ),
                                                      title: Text(
                                                        '4000/month',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      subtitle:
                                                          Text('for 9 months'),
                                                      trailing:
                                                          Icon(Icons.more_vert),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            // return object of type Dialog
                                                            return AlertDialog(
                                                              title: new Text(
                                                                  "Are you sure? You want to register for this package?"),
                                                              content: new Text(
                                                                  "The amount will be collected by our personal trainer at your place."),
                                                              actions: <Widget>[
                                                                // usually buttons at the bottom of the dialog
                                                                new FlatButton(
                                                                  child: new Text(
                                                                      "Cancel"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                new FlatButton(
                                                                  child: new Text(
                                                                      "Register"),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      register =
                                                                          true;
                                                                    });
                                                                    await DatabaseService(uid: user.uid).updateUserData(
                                                                        userData
                                                                            .email,
                                                                        userData
                                                                            .mobile,
                                                                        userData
                                                                            .address,
                                                                        userData
                                                                            .username,
                                                                        userData
                                                                            .imageLink,
                                                                        register);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        // return object of type Dialog
                                                                        return AlertDialog(
                                                                          title:
                                                                              new Text("Congratulations !!"),
                                                                          content:
                                                                              new Text("You have registered successfully to this package"),
                                                                          actions: <
                                                                              Widget>[
                                                                            // usually buttons at the bottom of the dialog
                                                                            new FlatButton(
                                                                              child: new Text("Close"),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                    print(
                                                                        'True');
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.attach_money,
                                                      ),
                                                      title: Text(
                                                        '3000/month',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      subtitle:
                                                          Text('for 12 months'),
                                                      trailing:
                                                          Icon(Icons.more_vert),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            // return object of type Dialog
                                                            return AlertDialog(
                                                              title: new Text(
                                                                  "Are you sure? You want to register for this package?"),
                                                              content: new Text(
                                                                  "The amount will be collected by our personal trainer at your place."),
                                                              actions: <Widget>[
                                                                // usually buttons at the bottom of the dialog
                                                                new FlatButton(
                                                                  child: new Text(
                                                                      "Cancel"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                new FlatButton(
                                                                  child: new Text(
                                                                      "Register"),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      register =
                                                                          true;
                                                                    });
                                                                    await DatabaseService(uid: user.uid).updateUserData(
                                                                        userData
                                                                            .email,
                                                                        userData
                                                                            .mobile,
                                                                        userData
                                                                            .address,
                                                                        userData
                                                                            .username,
                                                                        userData
                                                                            .imageLink,
                                                                        register);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        // return object of type Dialog
                                                                        return AlertDialog(
                                                                          title:
                                                                              new Text("Congratulations !!"),
                                                                          content:
                                                                              new Text("You have registered successfully to this package"),
                                                                          actions: <
                                                                              Widget>[
                                                                            // usually buttons at the bottom of the dialog
                                                                            new FlatButton(
                                                                              child: new Text("Close"),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                    print(
                                                                        'True');
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: Icon(
                                                        Icons.attach_money,
                                                      ),
                                                      title: Text(
                                                        '2500/month',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                        ),
                                                      ),
                                                      subtitle:
                                                          Text('for 24 months'),
                                                      trailing:
                                                          Icon(Icons.more_vert),
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            // return object of type Dialog
                                                            return AlertDialog(
                                                              title: new Text(
                                                                  "Are you sure? You want to register for this package?"),
                                                              content: new Text(
                                                                  "The amount will be collected by our personal trainer at your place."),
                                                              actions: <Widget>[
                                                                // usually buttons at the bottom of the dialog
                                                                new FlatButton(
                                                                  child: new Text(
                                                                      "Cancel"),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                                new FlatButton(
                                                                  child: new Text(
                                                                      "Register"),
                                                                  onPressed:
                                                                      () async {
                                                                    setState(
                                                                        () {
                                                                      register =
                                                                          true;
                                                                    });
                                                                    await DatabaseService(uid: user.uid).updateUserData(
                                                                        userData
                                                                            .email,
                                                                        userData
                                                                            .mobile,
                                                                        userData
                                                                            .address,
                                                                        userData
                                                                            .username,
                                                                        userData
                                                                            .imageLink,
                                                                        register);
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        // return object of type Dialog
                                                                        return AlertDialog(
                                                                          title:
                                                                              new Text("Congratulations !!"),
                                                                          content:
                                                                              new Text("You have registered successfully to this package"),
                                                                          actions: <
                                                                              Widget>[
                                                                            // usually buttons at the bottom of the dialog
                                                                            new FlatButton(
                                                                              child: new Text("Close"),
                                                                              onPressed: () {
                                                                                Navigator.of(context).pop();
                                                                              },
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                    print(
                                                                        'True');
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    Text(
                                                      'You are currently registered to our package',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'AndikaNewBasic-Regular',
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                        ],
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
                      ),
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
