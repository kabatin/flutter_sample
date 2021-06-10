import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(layoutNames[LayoutType.network] ?? ''),
        ),
        body: Container(
            constraints: const BoxConstraints.expand(),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Coming soon...',
                  style: const TextStyle(fontSize: 40.0),
                )
              ],
            )));
  }
}
