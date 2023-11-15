// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, non_constant_identifier_names

//import 'dart:ffi';
//import 'dart:html';

import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/services.dart';
import 'CalculatorButton.dart';
import 'contactPage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Color(0xFF222831),
          appBar: AppBar(
            title: Text("Calculator"),
            backgroundColor: Color(0xFF393E46),
          ),
          body: MyWidget()),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  InterstitialAd? interstitialAd;

  final adUnitid = "ca-app-pub-9259420202065395/8433252735";

  void loadAd() {
    InterstitialAd.load(
      adUnitId: adUnitid,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
        print("$ad loaded");
        interstitialAd = ad;
      }, onAdFailedToLoad: (LoadAdError error) {
        print("error accured $error");
      }),
    );
  }

  var input = '';
  var output = 'op';
  var textToDisplay = '';
  var lastChar = '';
  var cur = '';
  var validChars = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    'AC',
    '=',
    '00',
    '<'
  ];
  int count = 0;

  bool isOperator(String val) {
    return ['-', '+', 'X', '/', '^', '%'].contains(val);
  }

  void OnButtonClick(String text) {
    count++;
    if (count == 3) {
      loadAd();
      count = 0;
    }
    if (input.length % 4 == 0) {
      interstitialAd?.show();
    }
    String cur = text;

    if (cur.contains(RegExp(r'[0-9]'))) {
      input += cur;
      lastChar = cur;
    } else if (input.isNotEmpty && isOperator(cur) && !isOperator(lastChar)) {
      input += " $cur ";
      lastChar = cur;
    } else if (cur == 'AC') {
      input = '';
      lastChar = "";
    } else if (input.isNotEmpty && cur == '<') {
      if (input.length > 2 && isOperator(input[input.length - 2])) {
        lastChar = input[input.length - 2];
        input = input.substring(0, input.length - 3);
      } else {
        input = input.substring(0, input.length - 1);
      }
    }
    print(input.length);

    if (input.length > 40) {
      input = "Too larger Input";
    }

    /*
    cur = lastButtonPressed;

    print(validChars.contains(text));
    if (text == "AC") {
      input = '';
      lastButtonPressed = '';
    } else if (input.isNotEmpty && text == "<") {
      input = input.substring(0, input.length - 1);
    } else if (input.isNotEmpty && !validChars.contains(cur)) {
      input = input;
    } else if (text == '/' ||
        text == '%' ||
        text == 'X' ||
        text == '+' ||
        text == '-' ||
        text == '^') {
      input += " $text ";
    } else if (text == '=') {
      input = output;
    } else if (text != '<') {
      input += text;
    }

    print(input.length);
    lastButtonPressed = text;

    setState(() {
      if (input.length > 44) {
        textToDisplay = "input limit exced";
      } else {
        textToDisplay = input;
      }
    });
    */

    setState(() {
      if (cur == '=') {
        textToDisplay = output;
        input = "";
        lastChar = "";
      } else {
        textToDisplay = input;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment(1, 1),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              textToDisplay,
              style: TextStyle(
                color: Color(0xFFE8EBEA),
                fontSize: 44,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              text: 'AC',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 26,
              buttonColor: 0xFF00ADB5,
            ),
            CalculatorButton(
              text: '<',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 34,
              buttonColor: 0xFF00ADB5,
            ),
            CalculatorButton(
              text: '%',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 34,
              buttonColor: 0xFF00ADB5,
            ),
            CalculatorButton(
              text: '/',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 34,
              buttonColor: 0xFF00ADB5,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              text: '9',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: '8',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: '7',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: 'X',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 30,
              buttonColor: 0xFF00ADB5,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              text: '6',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: '5',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: '4',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: '+',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 36,
              buttonColor: 0xFF00ADB5,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              text: '3',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: '2',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: '1',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            CalculatorButton(
              text: '-',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 36,
              buttonColor: 0xFF00ADB5,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CalculatorButton(
              text: '0',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 32,
              buttonColor: 0xFFEEEEEE,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: SizedBox(
                width: 66,
                height: 66,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFFEEEEEE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => OnButtonClick('00'),
                  onLongPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Contactpage(),
                      ),
                    ).then((value) {
                      print(value);
                      output = value ?? 'none';
                    });
                  },
                  child: Text(
                    "00",
                    style: TextStyle(
                      fontSize: 32,
                      color: Color(0xFF393E46),
                    ),
                  ),
                ),
              ),
            ),
            CalculatorButton(
              text: '^',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 36,
              buttonColor: 0xFF00ADB5,
            ),
            CalculatorButton(
              text: '=',
              onPressed: OnButtonClick,
              textColor: 0xFF393E46,
              textSize: 34,
              buttonColor: 0xFF00ADB5,
            ),
          ],
        ),
      ],
    );
  }
}
