
import 'package:flutter_login_auth/src/model/login_status.dart';
import 'package:flutter_login_auth/src/resource/repository.dart';
import 'package:rxdart/rxdart.dart';

import 'base_bloc.dart';

class FacebookLoginBloc extends BaseBloc{
  final _repository = Repository();
  final _facebookLoginfetcher = PublishSubject<LoginStatus>();
  
  Observable<LoginStatus> get facebookProfile => _facebookLoginfetcher.stream;

  getFacebookData() async{
    LoginStatus loginStatus = await _repository.facebookLogin();
    _facebookLoginfetcher.sink.add(loginStatus);
  }
  
  @override
  dispose() {
    _facebookLoginfetcher.close();
  }

}