import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/layout_type.dart';

class PageNetworking extends StatefulWidget implements HasLayoutGroup {
  PageNetworking({Key? key, this.layoutGroup, this.onLayoutToggle})
      : super(key: key);

  @override
  final LayoutGroup? layoutGroup;
  @override
  final VoidCallback? onLayoutToggle;

  @override
  _PageNetworkingState createState() => _PageNetworkingState();
}

class _PageNetworkingState extends State<PageNetworking> {
  String result = '';

  Future<void> httpGet() async {
    var url = Uri.http('210.129.22.215', 'getip.php');
    await http.get(url).then((res) => {
          if (res.statusCode != HttpStatus.ok)
            throw Exception('StatusCode=' + res.statusCode.toString())
          else
            setState(() {
              result = res.body;
            })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(layoutNames[LayoutType.network] ?? ''),
        ),
        body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      httpGet().catchError((err) {
                        setState(() => {result = err.toString()});
                      });
                    },
                    child: Text('API Call', style: TextStyle(fontSize: 40.0))),
                Text(
                  '\nCaution:\nNot woking on web browser.\nreason is cors.\n\nResult: $result',
                  style: const TextStyle(fontSize: 30.0),
                )
              ],
            )));
  }
}
