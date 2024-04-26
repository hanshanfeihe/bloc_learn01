import 'package:equatable/equatable.dart';

sealed class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props {
    return [];
  }
}
final class LoginUsernameChanged extends LoginEvent{
  final String username;
  const LoginUsernameChanged(this.username);
  @override
  // TODO: implement props
  List<Object> get props => [username];
}
final class LoginPasswordChanged extends LoginEvent{
  final String password;
  const LoginPasswordChanged(this.password);
  @override
  // TODO: implement props
  List<Object> get props => [password];
}
final class LoginSubmitted extends LoginEvent{
  const LoginSubmitted();
}