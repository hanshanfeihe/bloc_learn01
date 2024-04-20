import 'package:bloc_learn01/pages/timer/bloc/timer_bloc.dart';
import 'package:bloc_learn01/pages/timer/bloc/timer_event.dart';
import 'package:bloc_learn01/pages/timer/bloc/timer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../ticker.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>TimerBloc(const Ticker()),child: const TimerView(),);
  }
}
class TimerView extends StatelessWidget {
  const TimerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Timer"),),
      body: const Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(child: TimerText()),
              ),
              TimerActions()
            ],
          )
        ],
      ),
    );
  }
}
class TimerText extends StatelessWidget {
  const TimerText({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc,TimerState>(builder: (BuildContext context, state) {
      final duration = state.duration;
      final minutesStr = ((duration/60)%60).floor().toString().padLeft(2,'0');
      final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
      return Text(
        '$minutesStr:$secondsStr',
        style: Theme.of(context).textTheme.displayLarge,
      );
    },);
  }
}
class TimerActions extends StatelessWidget {
  const TimerActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc,TimerState>(builder: (BuildContext context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...switch(state){
          TimerInitial() => [
            FloatingActionButton(
              child: const Icon(Icons.play_arrow),
              onPressed: () => context
                  .read<TimerBloc>()
                  .add(TimerStartedEvent(duration: state.duration)),
            ),
          ],
            // TODO: Handle this case.
          TimerRunPause() => [
              FloatingActionButton(
                child: const Icon(Icons.play_arrow),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerResumedEvent()),
              ),
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerResetEvent()),
              ),
          ],
            // TODO: Handle this case.
          TimerRunInProgress() => [
              FloatingActionButton(
                child: const Icon(Icons.pause),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerPausedEvent()),
              ),
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerResetEvent()),
              ),
            ],
            // TODO: Handle this case.
          TimerRunComplete() => [
              FloatingActionButton(
                child: const Icon(Icons.replay),
                onPressed: () =>
                    context.read<TimerBloc>().add(const TimerResetEvent()),
              ),
            ],
          }
        ],
      );
    },buildWhen: (prev,state){
      return prev.runtimeType!=state.runtimeType;
    },);
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade500,
          ],
        ),
      ),
    );
  }
}
