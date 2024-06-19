import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/patient.dart';

class PatientProvider with ChangeNotifier {
  List<Patient> _patients = [];

  List<Patient> get patients {
    return [..._patients];
  }

  Future<void> fetchPatients(String token) async {
    final url = 'https://flutter-amr.noviindus.in/api/PatientList';
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        _patients = data.map((item) => Patient.fromJson(item)).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load patients');
      }
    } catch (error) {
      throw error;
    }
  }

  Future<void> registerPatient({
    required String token,
    required String name,
    required String executive,
    required String payment,
    required String phone,
    required String address,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required double balanceAmount,
    required String dateTime,
    required String id,
    required List<int> maleTreatments,
    required List<int> femaleTreatments,
    required int branch,
    required List<int> treatments,
  }) async {
    const url = 'https://flutter-amr.noviindus.in/api/PatientUpdate';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'excecutive': executive,
          'payment': payment,
          'phone': phone,
          'address': address,
          'total_amount': totalAmount,
          'discount_amount': discountAmount,
          'advance_amount': advanceAmount,
          'balance_amount': balanceAmount,
          'date_nd_time': dateTime,
          'id': id,
          'male': maleTreatments.join(','),
          'female': femaleTreatments.join(','),
          'branch': branch,
          'treatments': treatments.join(','),
        }),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to register patient');
      }
    } catch (error) {
      throw error;
    }
  }
}
