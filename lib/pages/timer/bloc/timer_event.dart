sealed class TimerEvent{
  const TimerEvent();
}
final class TimerStartedEvent extends TimerEvent{
  final int duration;
  TimerStartedEvent({required this.duration});
}
final class TimerPausedEvent extends TimerEvent{
  const TimerPausedEvent();
}
final class TimerResumedEvent extends TimerEvent{
  const TimerResumedEvent();
}
final class TimerResetEvent extends TimerEvent{
  const TimerResetEvent();
}
class TimerTickedEvent extends TimerEvent {
  const TimerTickedEvent({required this.duration});
  final int duration;
}