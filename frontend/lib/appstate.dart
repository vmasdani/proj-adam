import 'dart:collection';

import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  dynamic _user;
  dynamic get user => _user;

  bool? _isAdmin;
  bool? get isAdmin => _isAdmin;

  void setCurrentPage(int currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  void setUser(dynamic user) {
    _user = user;
    notifyListeners();
  }

  void setIsAdmin(bool isAdmin) {
    _isAdmin = isAdmin;
    notifyListeners();
  }
}
