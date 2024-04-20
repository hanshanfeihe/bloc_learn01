import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_learn01/pages/timer/bloc/timer_event.dart';
import 'package:bloc_learn01/pages/timer/bloc/timer_state.dart';

import '../ticker.dart';

class TimerBloc extends Bloc<TimerEvent,TimerState>{
  static const int _duration = 60;
  final Ticker _ticker;
  StreamSubscription<int>? _streamSubscription;
  TimerBloc(Ticker ticker):_ticker = ticker,super(const TimerInitial(_duration)){
    //implement event handler
    on<TimerStartedEvent>(onStarted);
    on<TimerTickedEvent>(onTicked);
    on<TimerPausedEvent>(onPaused);
    on<TimerResumedEvent>(onResumed);
    on<TimerResetEvent>(onReset);
  }
  void onStarted(TimerStartedEvent event,Emitter<TimerState> emit,){
    emit(TimerRunInProgress(event.duration));
    _streamSubscription?.cancel();
    _streamSubscription = _ticker.tick(ticks: event.duration).listen((duration) {
      add(TimerTickedEvent(duration: duration));
    });
  }
  void onTicked(TimerTickedEvent event,Emitter<TimerState> emit){
    emit(event.duration>0?TimerRunInProgress(event.duration):const TimerRunComplete());
  }
  void onPaused(TimerPausedEvent event,Emitter<TimerState> emit){
    if(state is TimerRunInProgress){
      _streamSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }
  void onResumed(TimerResumedEvent event,Emitter<TimerState> emit){
    if(state is TimerRunPause){
      _streamSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }
  onReset(TimerResetEvent event,Emitter<TimerState> emit){
    _streamSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }
  @override
  Future<void> close() {
    // TODO: implement close
    _streamSubscription?.cancel();
    return super.close();
  }
}