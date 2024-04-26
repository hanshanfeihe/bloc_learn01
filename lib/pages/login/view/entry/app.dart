import 'package:bloc_learn01/pages/login/bloc/authentication_bloc.dart';
import 'package:bloc_learn01/pages/login/bloc/authentication_state.dart';
import 'package:bloc_learn01/pages/login/view/entry/splash_page.dart';
import 'package:bloc_learn01/pages/login/view/home_page.dart';
import 'package:bloc_learn01/pages/login/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/authentication_repository.dart';
import '../../repository/user_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(value: _authenticationRepository,child: BlocProvider(
      create: (_)=>AuthenticationBloc(authenticationRepository: _authenticationRepository, userRepository: _userRepository),
      child: const AppView(),
    ),);
  }
}
class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: ThemeData(
        useMaterial3: true
      ),
      builder: (context,child){
        return BlocListener<AuthenticationBloc,AuthenticationState>(listener: (context,state){
          switch(state.status){
            case AuthenticationStatus.unKnown:
              // TODO: Handle this case.
              break;
            case AuthenticationStatus.authenticated:
              _navigator.pushAndRemoveUntil(HomePage.route(), (route) => false);
              // TODO: Handle this case.
            case AuthenticationStatus.unauthenticated:
              _navigator.pushAndRemoveUntil(LoginPage.route(), (route) => false);
          }
        },child:child,);
      },
      onGenerateRoute: (_)=>SplashPage.route(),
    );
  }
}
