import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_learn01/pages/login/bloc/authentication_event.dart';
import 'package:bloc_learn01/pages/login/bloc/authentication_state.dart';
import 'package:bloc_learn01/pages/login/repository/user_repository.dart';

import '../model/user.dart';
import '../repository/authentication_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;
  AuthenticationBloc({required AuthenticationRepository authenticationRepository,required UserRepository userRepository}):_userRepository = userRepository,_authenticationRepository = authenticationRepository,super(const AuthenticationState.unknown()){
    ///register event
    on<AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen((status) {
      add(AuthenticationStatusChanged(status));
    });
  }
  Future<void> _onAuthenticationStatusChanged(AuthenticationStatusChanged event,Emitter<AuthenticationState> emit) async{
    switch (event.status){
      case AuthenticationStatus.unKnown:
       return emit(const AuthenticationState.unknown());
        // TODO: Handle this case.
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
        // TODO: Handle this case.
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(user!=null?AuthenticationState.authenticated(user):const AuthenticationState.unauthenticated());
    }
  }
  void _onAuthenticationLogoutRequested(AuthenticationLogoutRequested event,Emitter<AuthenticationState> emit){
    _authenticationRepository.logOut();
  }
  Future<User?> _tryGetUser() async {
    try {
      final user = await _userRepository.getUser();
      return user;
    } catch (_) {
      return null;
    }
  }
  @override
  Future<void> close(){
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}