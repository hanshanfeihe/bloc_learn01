import 'package:bloc_learn01/pages/counter/counter.dart';
import 'package:flutter/material.dart';

class CounterApp extends MaterialApp{
  const CounterApp({super.key});
  @override
  // TODO: implement home
  Widget? get home => const CounterPage();
}