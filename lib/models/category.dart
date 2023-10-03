import 'dart:ui';

import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange
  });

  final id;
  final String title;
  final Color color;
}
