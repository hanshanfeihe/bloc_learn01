import 'package:bloc_learn01/pages/login/model/password.dart';
import 'package:bloc_learn01/pages/login/model/username.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

final class LoginState extends Equatable {
  final FormzSubmissionStatus status;
  final Username username;
  final Password password;
  final bool isValid;

  const LoginState(
      {this.password = const Password.pure(),
      this.username = const Username.pure(),
      this.status = FormzSubmissionStatus.initial,
      this.isValid = false});

  LoginState copyWith(
      {FormzSubmissionStatus? status,
      Username? username,
      Password? password,
      bool? isValid}) {
    return LoginState(
        password: password ?? this.password,
        username: username ?? this.username,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [username,password,status];
}
