import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/treatment.dart';

class TreatmentProvider with ChangeNotifier {
  List<Treatment> _treatments = [];

  List<Treatment> get treatments => _treatments;

  Future<void> fetchTreatments(String token) async {
    final url = 'https://flutter-amr.noviindus.in/api/treatmentList';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      _treatments = data.map((treatmentData) => Treatment.fromJson(treatmentData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load treatments');
    }
  }
}