import 'package:flutter/foundation.dart';

enum LayoutGroup {
  noneScrollable,
  scrollable,
}

abstract class HasLayoutGroup {
  LayoutGroup? get layoutGroup;
  VoidCallback? get onLayoutToggle;
}

enum LayoutType {
  layout,
  calculate,
  network,
}

Map<LayoutType, String> layoutNames = {
  LayoutType.layout: 'Layout Tester',
  LayoutType.calculate: 'Calculation',
  LayoutType.network: 'Networking',
};
