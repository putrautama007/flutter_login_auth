import 'package:flutter/material.dart';
import 'package:flutter_login_auth/src/bloc/facebook_login_bloc.dart';
import 'package:flutter_login_auth/src/model/profile.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final facebookLoginBloc = FacebookLoginBloc();
  bool _load = false;


  setLoading(){
    setState(() {
      _load =false;
    });
  }

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    facebookLoginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_load?  Container(
      child:  Padding(padding:  EdgeInsets.all(5.0),child:  Center(child:  CircularProgressIndicator(
        backgroundColor: Colors.red,
      ))),
    ): Container();
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Facebook Login"),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: loginButton(),
            ),
          ),
          Align(child: loadingIndicator,alignment: FractionalOffset.center,),
        ],
      )
    );
  }

  Widget loginButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: Colors.blue
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "LOGIN",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Transform.translate(
                  offset: Offset(15.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.only(right: 20.0),
                    padding: EdgeInsets.all(10.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(28.0)),
                          color: Colors.white
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            setState((){
              _load=true;
            });
            facebookLoginBloc.getFacebookData();
            facebookLoginBloc.facebookProfile.listen((data){
              if(data.profile != null)
                openDetailPage(data.profile);
              else setLoading();
            });
          },
        ),
      ],
    );
  }

  openDetailPage(Profile data) {
    setLoading();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return HomePage(
          name: data.name,
          picUrl: data.picture.data.url,
        );
      }),
    );
  }
}
