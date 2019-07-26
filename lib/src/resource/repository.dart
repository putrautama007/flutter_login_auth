import 'package:flutter_login_auth/src/model/login_status.dart';

import 'api_provider.dart';
class Repository{
  final apiProvider = ApiProvider();

  Future<LoginStatus> facebookLogin() => apiProvider.initiateFacebookLogin();
}