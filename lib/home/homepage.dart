import 'package:calculator/controller/themeController.dart';
import 'package:calculator/home/buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];
  var usersQust = " ";
  var usersAns = " ";
  final ThemeController _themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        bottomOpacity: 0,
        title: Center(
          child: Obx(() {
            return IconButton(
              icon: Icon(_themeController.isDarkMode.value
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: _themeController.toggleTheme,
            );
          }),
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      usersQust,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    )),
                Container(
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.centerRight,
                    child: Text(usersAns,
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)))
              ],
            ),
          )),
          Expanded(
              flex: 2,
              child: Container(
                child: Center(
                    child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          // clear button
                          if (index == 0) {
                            return MyButton(
                                color: Colors.green[400],
                                textColor: Colors.white,
                                buttonText: buttons[index],
                                buttonTapped: () {
                                  setState(() {
                                    usersQust = " ";
                                    usersAns = " ";
                                  });
                                });
                          }
                          // delete button
                          else if (index == 1) {
                            return MyButton(
                              color: Colors.red[400],
                              textColor: Colors.white,
                              buttonText: buttons[index],
                              buttonTapped: () {
                                setState(() {
                                  usersQust = usersQust.substring(
                                      0, usersQust.length - 1);
                                });
                              },
                            );
                          }
                          // equal  button
                          else if (index == buttons.length - 1) {
                            return MyButton(
                              color: Colors.red[400],
                              textColor: Colors.white,
                              buttonText: buttons[index],
                              buttonTapped: () {
                                setState(() {
                                  isEqual();
                                });
                              },
                            );
                          }
                          // Rest of the buttons
                          else {
                            return MyButton(
                                buttonTapped: () {
                                  setState(() {
                                    usersQust += buttons[index];
                                  });
                                },
                                color: isOperator(buttons[index])
                                    ? Colors.blue
                                    : Colors.grey[200],
                                textColor: isOperator(buttons[index])
                                    ? Colors.white
                                    : Colors.black,
                                buttonText: buttons[index]);
                          }
                        })),
              ))
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "x" || x == "-" || x == "+" || x == "=") {
      return true;
    }
    return false;
  }

  void isEqual() {
    String finalQues = usersQust;
    finalQues = finalQues.replaceAll("x", "*");
    Parser p = Parser();
    Expression exp = p.parse(finalQues);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    usersAns = eval.toString();
  }
}
