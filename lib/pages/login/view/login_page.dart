import 'package:bloc_learn01/pages/login/bloc/login_bloc.dart';
import 'package:bloc_learn01/pages/login/bloc/login_event.dart';
import 'package:bloc_learn01/pages/login/bloc/login_state.dart';
import 'package:bloc_learn01/pages/login/repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static Route<void> route() => MaterialPageRoute(builder: (_)=>const LoginPage());
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (_)=>LoginBloc(authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context)),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc,LoginState>(listener: (context,state){
      if (state.status.isFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Authentication Failure')),
          );
      }
    },child: const Align(  alignment: Alignment.center,child: Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _UsernameInput(),
          Padding(padding: EdgeInsets.all(12)),
          _PasswordInput(),
          Padding(padding: EdgeInsets.all(12)),
          _LoginButton(),
        ],
      ),
    ),),);
  }
}
class _UsernameInput extends StatefulWidget {
  const _UsernameInput({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  _UsernameInputState();
  }
}
class _UsernameInputState extends State<_UsernameInput>{
  final FocusNode _focusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
      return Listener(
        child: TextFormField(
          controller: _controller,
          key: const ValueKey('loginForm_usernameInput_textField'),
          onChanged: (v){
            context.read<LoginBloc>().add(LoginUsernameChanged(v));
          },
          focusNode: _focusNode,
          decoration: InputDecoration(
              hintText: 'username',
              errorText: state.username.displayError!=null?'invalid username':null
          ),
        ),
        onPointerDown: (v){
          if(_focusNode.hasFocus)return;
          FocusScope.of(context).requestFocus(_focusNode);
        },
      );
    },buildWhen: (previous,current)=>previous.username!=current.username,);
  }
}

class _PasswordInput extends StatefulWidget {
  const _PasswordInput({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PasswordInputState();
  }


}
class _PasswordInputState extends State<_PasswordInput>{
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
      return Listener(
        child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          key: const ValueKey('loginForm_passwordInput_textField'),
          onChanged: (v){
            context.read<LoginBloc>().add(LoginPasswordChanged(v));
          },
          obscureText: true,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'password',
            errorText: state.password.displayError!=null?'invalid password':null
          ),
        ),
        onPointerDown: (v){
          if(_focusNode.hasFocus)return;
          print("点击了");
          FocusScope.of(context).requestFocus(_focusNode);
        },
      );
    },buildWhen: (previous,current)=>previous.password!=current.password,);
  }
}
class _LoginButton extends StatelessWidget {
  const _LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc,LoginState>(builder: (context,state){
      return state.status.isInProgress?const CircularProgressIndicator():ElevatedButton(onPressed: state.isValid?(){
        context.read<LoginBloc>().add(const LoginSubmitted());
      }:null, child: const Text('Login'));
    });
  }
}
