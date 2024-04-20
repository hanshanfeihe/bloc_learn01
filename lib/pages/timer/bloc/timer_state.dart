import 'package:equatable/equatable.dart';

sealed class TimerState extends Equatable{
  const TimerState(this.duration);
  final int duration;

  @override
  List<Object> get props {
    return [duration];
  }
}
final class TimerInitial extends TimerState{
  const TimerInitial(super.duration);
  @override
  String toString() {
    // TODO: implement toString
    return 'TimerInitial { duration:$duration }';
  }
}
final class TimerRunPause extends TimerState{
  const TimerRunPause(super.duration);
  @override
  String toString() {
    // TODO: implement toString
    return 'TimerRunPause { duration:$duration }';
  }
}
final class TimerRunInProgress extends TimerState{
  const TimerRunInProgress(super.duration);
  @override
  String toString() {
    // TODO: implement toString
    return 'TimerRunInProgress { duration:$duration }';
  }
}
final class TimerRunComplete extends TimerState{
  const TimerRunComplete():super(0);
}