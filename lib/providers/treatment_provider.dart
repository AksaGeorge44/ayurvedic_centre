import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/treatment.dart';

class TreatmentProvider with ChangeNotifier {
  List<Treatment> _treatments = [];

  List<Treatment> get treatments => _treatments;

  Future<void> fetchTreatments(String token) async {
    const url = 'https://flutter-amr.noviindus.in/api/TreatmentList';
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

  Future<void> updateTreatment(String token, Treatment treatment) async {
    const url = 'https://flutter-amr.noviindus.in/api/TreatmentUpdate';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
      body: {
        'id': treatment.id.toString(),
        'name': treatment.name,
        'duration': treatment.duration,
        'price': treatment.price,
        'is_active': treatment.isActive.toString(),
        'created_at': treatment.createdAt.toIso8601String(),
        'updated_at': treatment.updatedAt.toIso8601String(),
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final index = _treatments.indexWhere((t) => t.id == treatment.id);
      if (index != -1) {
        _treatments[index] = treatment;
        notifyListeners();
      }
    } else {
      throw Exception('Failed to update treatment');
    }
  }

}