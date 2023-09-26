import 'package:flutter/material.dart';

class RouteItem {
  final String path;
  final Widget screen;

  RouteItem({required this.path, required this.screen});
}

class NavItem extends RouteItem {
  final IconData icon;
  final String label;

  NavItem(
      {required super.path,
      required super.screen,
      required this.icon,
      required this.label});
}
