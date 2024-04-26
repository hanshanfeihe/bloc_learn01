import 'package:bloc/bloc.dart';
import 'package:bloc_learn01/pages/login/bloc/login_event.dart';
import 'package:bloc_learn01/pages/login/bloc/login_state.dart';
import 'package:bloc_learn01/pages/login/model/password.dart';
import 'package:bloc_learn01/pages/login/repository/authentication_repository.dart';
import 'package:formz/formz.dart';

import '../model/username.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  LoginBloc({ required AuthenticationRepository authenticationRepository,}):_authenticationRepository =authenticationRepository,super(const LoginState()){
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }
  final AuthenticationRepository _authenticationRepository;
  void _onUsernameChanged(LoginUsernameChanged event,Emitter<LoginState> emit){
    final username = Username.dirty(event.username);
    emit(state.copyWith(username: username,isValid: Formz.validate([state.password,username])));
  }
  void _onPasswordChanged(LoginPasswordChanged event,Emitter<LoginState> emit){
    final password = Password.dirty(event.password);
    emit(state.copyWith(password: password,isValid: Formz.validate([state.username,password])));
  }
  Future<void> _onSubmitted(LoginSubmitted event,Emitter<LoginState> emit) async{
    if(state.isValid){
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try{
        await _authenticationRepository.logIn(username: state.username.value, password: state.password.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      }catch(err){
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}