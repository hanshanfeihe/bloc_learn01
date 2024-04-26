import 'dart:async';

/// managing the authentication domain
enum AuthenticationStatus { unKnown, authenticated, unauthenticated }

class AuthenticationRepository {
  final StreamController<AuthenticationStatus> _streamController =
      StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _streamController.stream;
  }

  Future<void> logIn(
      {required String username, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 300),()=>_streamController.add(AuthenticationStatus.authenticated));
  }
  void logOut(){
    _streamController.add(AuthenticationStatus.unauthenticated);
  }
  void dispose(){
    _streamController.close();
  }
}
