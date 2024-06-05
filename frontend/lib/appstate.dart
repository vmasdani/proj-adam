import 'dart:collection';

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  void setCurrentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }
}
