import 'package:bloc_learn01/pages/login/bloc/authentication_event.dart';
import 'package:bloc_learn01/pages/login/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Builder(builder: (context){
              final userId = context.select((AuthenticationBloc bloc)=>bloc.state.user.id);
              return Text("UserID:$userId");
            }),
            ElevatedButton(onPressed: (){
              context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
            }, child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
