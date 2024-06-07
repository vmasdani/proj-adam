import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchItems() async {
  try {
    final res =
        await http.get(Uri.parse('${dotenv.get('BASE_URL')}/api/items'));

    if (res.statusCode != 200) {
      throw res.body;
    }

    return jsonDecode(res.body) as List<dynamic>;
  } catch (e) {
    print('[Error items] $e');
    return [];
  }
}

Future<dynamic> fetchItem(dynamic? id) async {
  try {
    final res =
        await http.get(Uri.parse('${dotenv.get('BASE_URL')}/api/items/${id}'));

    if (res.statusCode != 200) {
      throw res.body;
    }

    // print(res.body);
    return jsonDecode(res.body) as dynamic;
  } catch (e) {
    print('[Error items] $e');
    return [];
  }
}

Future<List<dynamic>> fetchInventoryList() async {
  try {
    final res =
        await http.get(Uri.parse('${dotenv.get('BASE_URL')}/api/inventory'));

    if (res.statusCode != 200) {
      throw res.body;
    }

    return jsonDecode(res.body) as List<dynamic>;
  } catch (e) {
    print('[Error items] $e');
    return [];
  }
}

Future<dynamic> fetchInventory(dynamic? id) async {
  try {
    final res = await http
        .get(Uri.parse('${dotenv.get('BASE_URL')}/api/inventory/${id}'));

    if (res.statusCode != 200) {
      throw res.body;
    }

    return jsonDecode(res.body) as dynamic;
  } catch (e) {
    print('[Error items] $e');
    return [];
  }
}

double calculateStock(List<dynamic> transactions) =>
    transactions.fold(0.0, (acc, t) {
      if (t?['in_out_type'] == 'in') {
        return acc + (t?['qty'] ?? 0.0);
      } else if (t?['in_out_type'] == 'out') {
        return acc - (t?['qty'] ?? 0.0);
      } else {
        return acc;
      }
    });

Future<List<dynamic>> fetchBorrows() async {
  try {
    final res =
        await http.get(Uri.parse('${dotenv.get('BASE_URL')}/api/borrows'));

    if (res.statusCode != 200) {
      throw res.body;
    }

    return jsonDecode(res.body) as List<dynamic>;
  } catch (e) {
    print('[Error items] $e');
    return [];
  }
}

Future<dynamic> fetchBorrow(dynamic? id) async {
  try {
    final res = await http
        .get(Uri.parse('${dotenv.get('BASE_URL')}/api/borrows/${id}'));

    if (res.statusCode != 200) {
      throw res.body;
    }

    return jsonDecode(res.body) as dynamic;
  } catch (e) {
    print('[Error items] $e');
    return [];
  }
}

Future<List<dynamic>> fetchPurchaseRequests() async {
  try {
    final res = await http
        .get(Uri.parse('${dotenv.get('BASE_URL')}/api/purchaserequests'));

    if (res.statusCode != 200) {
      throw res.body;
    }

    return jsonDecode(res.body) as List<dynamic>;
  } catch (e) {
    print('[Error items] $e');
    return [];
  }
}

Future<dynamic> fetchPurchaseRequest(dynamic? id) async {
  try {
    final res = await http
        .get(Uri.parse('${dotenv.get('BASE_URL')}/api/purchaserequests/${id}'));

    if (res.statusCode != 200) {
      throw res.body;
    }

    return jsonDecode(res.body) as dynamic;
  } catch (e) {
    print('[Error items] $e');
    return [];
  }
}

Widget checkApprovalStatus(int status) {
  switch (status) {
    case 0:
      return Text(
        'WAITING',
        style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold),
      );
    case 1:
      return Text(
        'APPROVED',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      );
    case 2:
      return Text(
        'CANCELLED',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      );
    case 3:
      return Text(
        'RETURNED',
        style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      );

    default:
      return Text('');
  }
}
