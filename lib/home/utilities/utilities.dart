import 'package:flutter/material.dart';

class ProjectSizes {
  static const double cardImageHeight = 200;
  static const double cardImageWidth = 200;
  static const double cardListTileHeight = 40;
}

class ProjectPaddings {
  final EdgeInsets cardPaddings =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 15);
  final EdgeInsets cardItemPaddings =
      const EdgeInsets.symmetric(horizontal: 20, vertical: 30);
  final EdgeInsets paddingBetweenItems = const EdgeInsets.only(bottom: 50.0);

  final EdgeInsets textFormFieldPaddings =
      const EdgeInsets.symmetric(vertical: 15);
}

class ProjectRadiuses {
  final BorderRadius generalBorderRadius = BorderRadius.circular(30.0);
  final Radius generalRadiusOnly = const Radius.circular(30);
}
