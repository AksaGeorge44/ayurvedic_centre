import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/treatment.dart';

class TreatmentProvider with ChangeNotifier {
  List<Treatment> _treatments = [];

  List<Treatment> get treatments => _treatments;

  Future<void> fetchTreatments(String token) async {
    final url = 'https://flutter-amr.noviindus.in/api/TreatmentList';
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> treatmentsData = jsonData['treatments'];
      _treatments = treatmentsData.map((treatmentData) => Treatment.fromJson(treatmentData)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load treatments');
    }
  }
}
