import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/counter_cubit.dart';
class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(child: BlocBuilder<CounterCubit,int>(
        builder: (context,state){
          return Text('$state',style: textTheme.displayMedium,);
        },
      ),),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(onPressed: (){
            context.read<CounterCubit>().increment();
          },child: const Icon(Icons.add),),
          const SizedBox(height: 8),
          FloatingActionButton(onPressed: (){
            context.read<CounterCubit>().decrement();
          },child: const Icon(Icons.remove),)
        ],
      ),
    );
  }
}
