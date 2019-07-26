import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import 'login_page.dart';

class HomePage extends StatefulWidget {
  final name;
  final picUrl;

  HomePage({this.name,this.picUrl});


  @override
  _HomePageState createState() => _HomePageState(
      name: name,
      picUrl: picUrl
  );
}

class _HomePageState extends State<HomePage> {
  final name;
  final picUrl;
  _HomePageState({this.name,this.picUrl});

  var facebookLogin = FacebookLogin();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Facebook Login"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () =>  _logout(context) ,
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 200.0,
                width: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      picUrl,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28.0),
              Text(
                "Logged in as: $name",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  _logout(BuildContext  context) async {
    await facebookLogin.logOut();
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context) {
      return LoginPage();
    }),);
    print("Logged out");
  }
}
