import 'package:bloc_learn01/pages/login/repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';

import '../model/user.dart';

class AuthenticationState extends Equatable{
  final User user;
  final AuthenticationStatus status;
  const AuthenticationState._({this.user = User.empty,this.status = AuthenticationStatus.unKnown});
  const AuthenticationState.unknown():this._();
  const AuthenticationState.authenticated(User user): this._(user: user,status: AuthenticationStatus.authenticated);
  const AuthenticationState.unauthenticated():this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object> get props {
    return [user,status];
  }
}