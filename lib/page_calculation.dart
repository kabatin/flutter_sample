import 'dart:async';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:test_app/layout_type.dart';

class PageCalculation extends StatefulWidget implements HasLayoutGroup {
  PageCalculation({Key? key, this.layoutGroup, this.onLayoutToggle})
      : super(key: key);

  @override
  final LayoutGroup? layoutGroup;
  @override
  final VoidCallback? onLayoutToggle;

  @override
  _PageCalculationState createState() => _PageCalculationState();
}

class _PageCalculationState extends State<PageCalculation> {
  final KeyStream controller = KeyStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(layoutNames[LayoutType.calculate] ?? ''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextField(stream: controller.stream),
          Keyboard(sink: controller.sink),
        ],
      ),
    );
  }
}

class KeyStream {
  final StreamController<String> _controller = StreamController<String>();

  Stream<String> get stream => _controller.stream;
  StreamSink<String> get sink => _controller.sink;

  void closeStream() {
    _controller.close();
  }
}

class TextField extends StatefulWidget {
  final Stream<String>? stream;
  TextField({this.stream});

  _TextFieldState createState() => _TextFieldState(stream: stream);
}

class _TextFieldState extends State<TextField> {
  final Stream<String>? stream;
  _TextFieldState({this.stream});

  String expression = '';
  String display = '0';
  bool isResult = false;

  void _updateText(String letter) {
    setState(() {
      if (isResult) {
        isResult = false;
        expression = '';
        display = '0';
      }

      switch (letter) {
        case 'C':
          display = '0';
          expression = '';
          break;
        case '=':
          isResult = true;
          try {
            final Parser p = Parser();
            final Expression exp = p.parse(expression);
            final ContextModel cm = ContextModel();

            dynamic result = exp.evaluate(EvaluationType.REAL, cm);
            display += ' \n\n' + result.toString();
          } catch (e) {
            display = 'Error';
          }

          expression = '';
          break;
        case '+':
        case '-':
        case '×':
        case '÷':
          if (display == '0') {
            return;
          }
          if (letter == '×') {
            expression += '*';
          } else if (letter == '÷') {
            expression += '/';
          } else {
            expression += letter;
          }
          display += letter;
          break;
        default:
          if (display == '0') {
            display = '';
          }
          expression += letter;
          display += letter;
      }
    });
  }

  @override
  void initState() {
    stream!.listen((String event) => _updateText(event));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(display, style: const TextStyle(fontSize: 60.0))),
        ));
  }
}

class Keyboard extends StatelessWidget {
  final StreamSink<String>? sink;
  Keyboard({this.sink});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 2,
        child: Center(
            child: Container(
                color: Colors.green,
                child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 3.0,
                  children: const <String>[
                    '7',
                    '8',
                    '9',
                    '÷',
                    '4',
                    '5',
                    '6',
                    '×',
                    '1',
                    '2',
                    '3',
                    '-',
                    'C',
                    '0',
                    '=',
                    '+',
                  ].map((String key) {
                    return GridTile(
                      child: ElevatedButton(
                        onPressed: () {
                          sink!.add(key);
                        },
                        child: Text(
                          key,
                          style: const TextStyle(fontSize: 80.0),
                        ),
                      ),
                    );
                  }).toList(),
                ))));
  }
}
