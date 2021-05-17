import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_words/random_words.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build (BuildContext context){
  return MaterialApp(
    title:'Shuffle Word Game',
    home: Home()
  );
  }
}
class Home extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Scaffold(
        body: Center(
            child:Column(
                mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                children:
                [ Text('Shuffle Word Game',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      onPressed: (){Navigator.push(context , MaterialPageRoute(builder: ((context) {return GameScreen();})));},
                      child:Padding(padding:const EdgeInsets.all(5),child: Text('Game start',style:TextStyle(fontSize: 30)))
                  )]
            )
        )
    );
  }
}

class GameScreen extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Shuffle word Games')),
      body: MainGameingSection()
      );
  }
}

class MainGameingSection extends StatefulWidget{
  @override
  _MainGameingSectionState createState() => _MainGameingSectionState();
}

class _MainGameingSectionState extends State<MainGameingSection>{
  String _words =  generateNoun().take(1).first.toString();
  final textController = TextEditingController();
  final _infoFont = const TextStyle(fontSize: 18);
  var _score = 0;
  var _question = 1;

  void getNewString(){
  _words =  generateNoun().take(1).first.toString();
      }
  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) + newChar + oldString.substring(index + 1);
  }

  String shuffle (String str) {
    var rng = new Random();
    var shuffledString = str;
    for (var i = 0;i<str.length;i++){
      int index = rng.nextInt(str.length - 1);
      var temp = shuffledString[i] ;
      shuffledString = replaceCharAt(shuffledString, i, shuffledString[index]);
      shuffledString = replaceCharAt(shuffledString, index, temp);
    }
    return shuffledString;
  }
  Widget buildScorebar(){
    return Padding(
        padding:const EdgeInsets.all(5),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[Text('Your Score : $_score', style:_infoFont),
            Text('Question : $_question/10',style:_infoFont)],
        )
    );
  }

  Widget buildbuttons(){
    return Container(
        margin: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
          ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 150, height: 50),
          child:ElevatedButton(
              onPressed: (){setState(() {
                if (_question==10){
                  buildGameOver();
                }else {
                  _question++;
                  textController.clear();
                }
              });},
              child:Padding(padding:const EdgeInsets.all(5),child: Text('Skip',style:TextStyle(fontSize: 30)))
          )
      ),
          ConstrainedBox(
          constraints: BoxConstraints.tightFor(width:150, height: 50),
          child:ElevatedButton(
              onPressed: (){setState((){if (_question==10){
                if (_words==textController.text){
                  _score+=10;
                }
                buildGameOver();
              }else {
                _question++;
                if (_words==textController.text){
                  _score+=10;
                }
                getNewString();
                textController.clear();
              }

              });},
              child:Padding(padding:const EdgeInsets.all(5),child: Text('Submit',style:TextStyle(fontSize: 30)))
          )
      )
    ]
    )
    );
  }
  Widget buildGame(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(shuffle(_words) ,style:TextStyle(fontSize: 50 , letterSpacing: 2.0),),
        Container(width: 300,
            margin: const EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
            child: TextField(obscureText: false ,controller: textController,
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Your Answer',))
        ),
        buildbuttons()
      ],
    );
  }
  void buildGameOver(){
    showDialog<void>(context: context,barrierDismissible: false,builder: (BuildContext context){return CupertinoAlertDialog(
      title: const Text('Congratulations!'),
      content:  Text('You get $_score in this game.'),
      actions: [
        TextButton(
          child: Text('Restart'),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      ],
    );});}

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: [buildScorebar(),Spacer(),buildGame(),Spacer()],
    );
  }
}