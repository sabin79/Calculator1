import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calaculator extends StatefulWidget {
  const Calaculator({super.key});

  @override
  State<Calaculator> createState() => _CalaculatorState();
}

class _CalaculatorState extends State<Calaculator> {
  String userInput = "";
  String result = "0";

  List<String> buttonlist = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF1d2630),
      body: Column(
        children: [
          SizedBox(
            height: h / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      result,
                      style: TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonlist.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                itemBuilder: (BuildContext Context, int index) {
                  return CustomButton(buttonlist[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: Color(0xFF1d2630),
      onTap: () {
        setState(() {
          handdleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.white.withOpacity(0.1),
                blurRadius: 4,
                spreadRadius: 0.9,
                offset: Offset(-3, -4))
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  getBgColor(String text) {
    if (text == "AC") {
      return Color.fromARGB(225, 252, 100, 100);
    }
    if (text == "=") {
      return Color.fromARGB(225, 2104, 204, 100);
    }
    return Color(0xFF1d26);
  }

  handdleButtons(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
      return;
    }
    if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (text == "=") {
      result = calculator();
      userInput = result;
      if (userInput.endsWith(".0")) {
        userInput = userInput.replaceAll(".0", "");
      }
      if (result.endsWith(".0")) {
        result = result.replaceAll(".0", "");
        return;
      }
    }
    userInput = userInput + text;
  }

  String calculator() {
    try {
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "error";
    }
  }
}
