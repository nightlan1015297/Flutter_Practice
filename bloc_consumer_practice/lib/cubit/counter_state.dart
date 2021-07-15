part of 'counter_cubit.dart';

/* Create new State class to storage the state information*/

class CounterState {
  
  /*Declare variable to storage state information*/
  int  counterValue;
  bool Incremented;
  
  /* Initialization constructor*/
  CounterState({
    @required this.counterValue,
    this.Incremented,
  });
  
}
