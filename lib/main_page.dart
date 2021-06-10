import 'package:flutter/material.dart';
import 'package:test_app/layout_type.dart';
import 'package:test_app/page_row_column.dart';
import 'package:test_app/page_calculation.dart';
import 'package:test_app/page_networking.dart';

class MainPage extends StatefulWidget {
  MainPage({required Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  LayoutGroup _layoutGroup = LayoutGroup.noneScrollable;
  LayoutType _layoutSelection = LayoutType.layout;

  void _onLayoutGroupToggle() {
    setState(() {
      _layoutGroup = _layoutGroup == LayoutGroup.noneScrollable
          ? LayoutGroup.scrollable
          : LayoutGroup.noneScrollable;
    });
  }

  Widget _buildBody() {
    return <LayoutType, WidgetBuilder>{
      LayoutType.layout: (_) => PageRowColumn(
          layoutGroup: LayoutGroup.noneScrollable,
          onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.calculate: (_) => PageCalculation(
          layoutGroup: LayoutGroup.noneScrollable,
          onLayoutToggle: _onLayoutGroupToggle),
      LayoutType.network: (_) => PageNetworking(
          layoutGroup: LayoutGroup.noneScrollable,
          onLayoutToggle: _onLayoutGroupToggle),
    }[_layoutSelection]!(context);
  }

  BottomNavigationBarItem _buildItem({IconData? icon, LayoutType? type}) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          //color: _colorChanging(type: type),
        ),
        label: layoutNames[type]);
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        _buildItem(icon: Icons.house, type: LayoutType.layout),
        _buildItem(icon: Icons.house, type: LayoutType.calculate),
        _buildItem(icon: Icons.house, type: LayoutType.network),
      ],
      selectedItemColor: Colors.green,
      currentIndex: _selectedIndex,
      onTap: _onTapTab,
    );
  }

  void _onTapTab(int index) {
    setState(() {
      _selectedIndex = index;
      _layoutSelection = LayoutType.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
