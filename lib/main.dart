import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';

void main() {
  runApp(kalkulator());
}

class kalkulator extends StatelessWidget {
  const kalkulator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: demo(),
    );
  }
}

class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  _demo createState() => _demo();
}

class _demo extends State<demo> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        result = "";
        equation = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        expression = expression.replaceAll('%', '/100');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid)),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(

        // key: _innerDrawerKey,
        onTapClose: true, // default false
        swipe: true, // default true
        colorTransitionChild: Colors.blue, // default Color.black54
        colorTransitionScaffold: Colors.black54, // default Color.black54

        //When setting the vertical offset, be sure to use only top or bottom
        offset: IDOffset.only(bottom: 0.00, right: 0.00, left: 0.00),
        scale: IDOffset.horizontal(1), // set the offset in both directions

        proportionalChildArea: true, // default true // default 0
        leftAnimationType: InnerDrawerAnimation.static, // default static
        rightAnimationType: InnerDrawerAnimation.quadratic,
        backgroundDecoration: BoxDecoration(
            color:
                Colors.red[200]), // default  Theme.of(context).backgroundColor

        //when a pointer that is in contact with the screen and moves to the right or left
        onDragUpdate: (double val, InnerDrawerDirection? direction) {
          // return values between 1 and 0
          print(val);
          // check if the swipe is to the right or to the left
          print(direction == InnerDrawerDirection.start);
        },
        innerDrawerCallback: (a) =>
            print(a), // return  true (open) or false (close)

        leftChild: Material(
          child: Container(
            color: Colors.blueAccent,
            child: ListView(
              children: <Widget>[
                const SizedBox(height: 20),
                ListTile(
                  title: Text(
                    "Kalkulator",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                )
              ],
            ),
          ),
        ),

        // required if rightChild is not set
        rightChild: Container(), // required if leftChild is not set

        //  A Scaffold is generally used but you are free to use other widgets
        // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar

        scaffold: Scaffold(
          appBar: AppBar(
              title: Text("Kalkulator"), automaticallyImplyLeading: true),
          body: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Text(
                  equation,
                  style: TextStyle(fontSize: equationFontSize),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Text(
                  result,
                  style: TextStyle(fontSize: resultFontSize),
                ),
              ),
              Expanded(child: Divider()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .70,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("C", 1, Colors.grey),
                          buildButton("⌫", 1, Colors.grey),
                          buildButton("÷", 1, Colors.grey),
                        ]),
                        TableRow(children: [
                          buildButton("7", 1, Colors.blueGrey),
                          buildButton("8", 1, Colors.blueGrey),
                          buildButton("9", 1, Colors.blueGrey),
                        ]),
                        TableRow(children: [
                          buildButton("4", 1, Colors.blueGrey),
                          buildButton("5", 1, Colors.blueGrey),
                          buildButton("6", 1, Colors.blueGrey),
                        ]),
                        TableRow(children: [
                          buildButton("1", 1, Colors.blueGrey),
                          buildButton("2", 1, Colors.blueGrey),
                          buildButton("3", 1, Colors.blueGrey)
                        ]),
                        TableRow(children: [
                          buildButton(".", 1, Colors.blueGrey),
                          buildButton("0", 1, Colors.blueGrey),
                          buildButton("00", 1, Colors.blueGrey),
                        ]),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Table(
                      children: [
                        TableRow(children: [
                          buildButton("×", 1, Colors.grey),
                        ]),
                        TableRow(children: [
                          buildButton("-", 1, Colors.grey),
                        ]),
                        TableRow(children: [
                          buildButton("+", 1, Colors.grey),
                        ]),
                        TableRow(children: [
                          buildButton("%", 1, Colors.grey),
                        ]),
                        TableRow(children: [
                          buildButton("=", 1, Colors.orangeAccent),
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          /* OR
            CupertinoPageScaffold(                
                navigationBar: CupertinoNavigationBar(
                    automaticallyImplyLeading: false
                ),
            ), 
            */
        ));
  }
}

//  Current State of InnerDrawerState
final GlobalKey<InnerDrawerState> _innerDrawerKey =
    GlobalKey<InnerDrawerState>();

void _toggle() {
  _innerDrawerKey.currentState?.toggle(
      // direction is optional
      // if not set, the last direction will be used
      //InnerDrawerDirection.start OR InnerDrawerDirection.end
      direction: InnerDrawerDirection.end);
}
