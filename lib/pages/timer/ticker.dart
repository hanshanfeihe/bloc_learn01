class Ticker{
  const Ticker();
  Stream<int> tick({required int ticks}){
    return Stream.periodic(const Duration(seconds: 1),(remainTime){
      return ticks-remainTime-1; //剩余时间
    }).take(ticks);
  }
}