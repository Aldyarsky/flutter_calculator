import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(Calculator());
}
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {

  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText){
    setState(() {
      if(buttonText == "C"){
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      }

      else if(buttonText == "\u00B1"){
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        try{
          equation = (double.parse(equation) * (-1)).toString();
        }catch(e){
          result = "Error";
        }
      }
      else if(buttonText == "="){
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%','%');

        try{
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "Error";
        }

      }

      else{
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if(equation == "0"){
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText, double buttonHeight, Color buttonColor){
    return Container(
      width: MediaQuery.of(context).size.width *0.25,
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.black54,
                  width: 1,
                  style: BorderStyle.solid
              )
          ),
          padding: EdgeInsets.all(16.0),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          )
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hexToColor("#3e3d3f"),
      body:
      Column(

        children: <Widget>[
          Expanded(
            child: Divider(),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(equation, style: TextStyle(fontSize: equationFontSize,color: hexToColor("#ffffff")), ),
          ),


          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(result, style: TextStyle(fontSize: resultFontSize, color: hexToColor("#ffffff"))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 1,
                child: Table(
                  children: [
                    TableRow(
                        children: [
                          buildButton("C", 1, hexToColor("#505152")),
                          buildButton("\u00B1", 1, hexToColor("#505152")),
                          buildButton("%", 1, hexToColor("#505152")),
                          buildButton("÷", 1, hexToColor("#ff9f09")),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("7", 1, hexToColor("#787978")),
                          buildButton("8", 1, hexToColor("#787978")),
                          buildButton("9", 1, hexToColor("#787978")),
                          buildButton("×", 1, hexToColor("#ff9f09")),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("4", 1, hexToColor("#787978")),
                          buildButton("5", 1, hexToColor("#787978")),
                          buildButton("6", 1, hexToColor("#787978")),
                          buildButton("-", 1, hexToColor("#ff9f09")),
                        ]
                    ),

                    TableRow(
                        children: [
                          buildButton("1", 1, hexToColor("#787978")),
                          buildButton("2", 1, hexToColor("#787978")),
                          buildButton("3", 1, hexToColor("#787978")),
                          buildButton("+", 1, hexToColor("#ff9f09")),
                        ]
                    ),
                  ],
                ),

              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width * 1,
                child: Row(
                  children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.1 * 1,
                    color: hexToColor("#6e6f6f"),
                    child: FlatButton(
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                    side: BorderSide(
                    color: Colors.black54,
                    width: 1,
                    style: BorderStyle.solid
                    )
                    ),
                    padding: EdgeInsets.all(16.0),
                    onPressed: () => buttonPressed("0"),
                    child: Text(
                    "0",
                    style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white
                    ),
                    )
                    ),
                    ),
                          buildButton(".", 1, hexToColor("#6e6f6f")),
                          buildButton("=", 1,  hexToColor("#ff9f09")),
                  ],
                ),
              )

            ],
          ),

        ],
      ),
    );
  }
}

