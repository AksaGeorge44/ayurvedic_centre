import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../providers/auth_provider.dart';
import '../widgets/patient_detail.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Patient> patients = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse('https://flutter-amr.noviindus.in/api/PatientList');
      final token = Provider.of<AuthProvider>(context, listen: false).token; // Get the authentication token
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token', // Add the token to the headers
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          patients = (jsonData['patient'] as List)
              .map((item) => Patient.fromJson(item))
              .toList();
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patients'),
      ),
      body: patients.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: patients.length,
        itemBuilder: (ctx, index) => ListTile(
          title: Text('Name:${patients[index].name}'),
          subtitle: Text('Address:${patients[index].address}'),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PatientDetailsScreen(patient: patients[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
