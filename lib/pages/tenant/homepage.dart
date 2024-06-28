import 'package:bhc_prop/call_reporting/request.dart';
import 'package:bhc_prop/core/colors.dart';
import 'package:bhc_prop/pages/Login&Register/login.dart';
import 'package:bhc_prop/pages/tenant/widgets(tenant)/widgets.dart';
import 'package:bhc_prop/payment/rental.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: {
      '/maintenanceRequest': (context) => RequestPage(),
      '/payrent': (context) =>  RentalPaymentPage(),
      '/login': (context) =>  const LoginPage(),

      
      // Add more routes as needed
    },
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String userName = '';

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String name = user.displayName ?? '';
      String email = user.email ?? '';
      String username = name.isNotEmpty ? name : email.split('@')[0];

      setState(() {
        userName = username;
      });
    } else {
      setState(() {
        userName = 'User';
      });
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login'); // Replace '/login' with your login route
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: bhcred,
                ),
                child: Text(
                  'Navigation Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Payments'),
                onTap: () {
                  Navigator.pushNamed(context, '/payrent');
                },
              ),
              ListTile(
                leading: Icon(Icons.document_scanner),
                title: Text('Documents'),
                onTap: () {
                  // Navigate to Documents page
                },
              ),
              ListTile(
                leading: Icon(Icons.build),
                title: Text('Maintenance Requests'),
                onTap: () {
                  Navigator.pushNamed(context, '/maintenanceRequest');
                },
              ),
              ListTile(
                leading: Icon(Icons.chat),
                title: Text('Group Chat'),
                onTap: () {
                  // Handle Group Chat navigation
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  await _signOut();
                },
              ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.black87,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // This opens the drawer
              },
            );
          },
        ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Good Morning\n$userName",
                        style: TextStyle(
                          fontFamily: "Josefin",
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            Modes(
                              background: bhcyelow,
                              flexSize: 4,
                              mgTop: 30,
                              mgLeft: 30,
                              mgRight: 10,
                              mgBottom: 10,
                              modeName: "Payments",
                              assetImage: "assets/images/pay.png",
                              buttonAsset: "assets/images/nav.png",
                              onTap: () {
                                Navigator.pushNamed(context, '/payrent');
                              },
                            ),
                            Modes(
                              background: bhcyelow,
                              flexSize: 6,
                              mgTop: 10,
                              mgLeft: 30,
                              mgRight: 10,
                              mgBottom: 30,
                              modeName: "TPS Statement",
                              assetImage: "assets/images/doc.png",
                              buttonAsset: "assets/images/nav.png",
                              onTap: () {
                                
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Column(
                          children: [
                            Modes(
                              background: bhcyelow,
                              flexSize: 6,
                              mgTop: 30,
                              mgLeft: 10,
                              mgRight: 30,
                              mgBottom: 10,
                              modeName: "Maintenance\nRequests",
                              assetImage: "assets/images/request.png",
                              buttonAsset: "assets/images/nav.png",
                              onTap: () {
                                Navigator.pushNamed(context, '/maintenanceRequest');
                              },
                            ),
                            Modes(
                              background: bhcyelow,
                              flexSize: 4,
                              mgTop: 10,
                              mgLeft: 10,
                              mgRight: 30,
                              mgBottom: 30,
                              modeName: "Group Chat",
                              assetImage: "assets/images/chat.png",
                              buttonAsset: "assets/images/nav.png",
                              onTap: () {
                                // Handle Group Chat navigation
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
