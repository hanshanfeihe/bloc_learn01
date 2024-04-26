import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static Route<void> route(){
    return MaterialPageRoute(builder: (_)=>const SplashPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Image.asset("img/splash.webp",fit: BoxFit.fill,),
      ),
    );
  }
}
