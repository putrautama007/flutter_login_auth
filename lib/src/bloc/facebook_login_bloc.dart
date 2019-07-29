
import 'package:flutter_login_auth/src/model/login_status.dart';
import 'package:flutter_login_auth/src/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class FacebookLoginBloc extends BaseBloc{
  final _repository = Repository();
  final _facebookLoginFetcher = PublishSubject<LoginStatus>();
  
  Observable<LoginStatus> get facebookProfile => _facebookLoginFetcher.stream;

  getFacebookData() async{
    LoginStatus loginStatus = await _repository.facebookLogin();
    _facebookLoginFetcher.sink.add(loginStatus);
  }
  
  @override
  dispose() {
    _facebookLoginFetcher.close();
  }

}