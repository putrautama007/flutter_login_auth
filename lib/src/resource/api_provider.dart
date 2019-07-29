import 'dart:convert';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_login_auth/src/model/login_status.dart';
import 'package:flutter_login_auth/src/model/profile.dart';
import 'package:http/http.dart' as http;

class ApiProvider{
  var facebookLogin = FacebookLogin();

   Future<LoginStatus> initiateFacebookLogin() async {
    var facebookLoginResult =
    await facebookLogin.logInWithReadPermissions(['email']);

    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
      return LoginStatus(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        return LoginStatus(false);
        break;
      case FacebookLoginStatus.loggedIn:
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult
                .accessToken.token}');

        print("${facebookLoginResult
            .accessToken.token}");
        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        return LoginStatus(true, profile: Profile.fromJson(profile));
        break;
    }
    return LoginStatus(false);
  }

}