/*************************************************************/
/*                      Flutter example                      */
/*************************************************************/
/* Following code shows the example of using Bloc pattern     *
*  in Flutter to seperate Business logic and update           *
*  User Interface.                                            *
*                                                             *
*  This project shows the basic usage of Bloc including       *
*  BlocProvider,BlocBuilder and BlocListener's implementation * 
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_practice/cubit/counter_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* Wrap the Material app widget with Bloc provider 
     * This makes BlocProvider the root widget of whole APP
     * makes the children widgets able to listen to stream 
    */
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if (state.Incremented){
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('incremented'),
              duration:Duration(milliseconds:300),
            )
          );}
          if (!state.Incremented){
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('decremented'),
              duration:Duration(milliseconds:300),
            )
          );}
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              /* When receiving new State from the stream  
                  *  Bloc Builder rebuild the widget then update User Interface
                  */
              BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                      onPressed: () {
                        /*Push new State to the stream when state change */
                        BlocProvider.of<CounterCubit>(context).decrement();
                        /*also works with 
                            context.bloc<CounterCubit>().decrement()
                            */
                      },
                      tooltip: "Decrement",
                      child: Icon(Icons.remove)),
                  FloatingActionButton(
                      onPressed: () {
                        /*Push new State to the stream when state change */
                        BlocProvider.of<CounterCubit>(context).increment();
                        /*also works with 
                            context.bloc<CounterCubit>().increment()
                            */
                      },
                      tooltip: 'Increment',
                      child: Icon(Icons.add))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
