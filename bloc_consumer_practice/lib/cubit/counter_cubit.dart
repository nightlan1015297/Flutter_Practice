import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counterValue:0));
  /*Use emit() to push new state to stream*/ 
  void increment() => emit(CounterState(counterValue: state.counterValue +1 ,Incremented: true));

  void decrement() => emit(CounterState(counterValue: state.counterValue -1 ,Incremented: false));
}
