import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/branch.dart';

class BranchProvider with ChangeNotifier {
  List<Branch> _branches = [];

  List<Branch> get branches => _branches;

  Future<void> fetchBranches(String token) async {
    final url = 'https://flutter-amr.noviindus.in/api/branchList';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _branches = data.map((branchData) => Branch.fromJson(branchData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load branches');
    }
  }
}
