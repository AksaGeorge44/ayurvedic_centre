import 'dart:convert';
import 'package:ayurvedic_centre/screens/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/patient.dart';
import '../providers/auth_provider.dart';
import '../widgets/patient_detail.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Patient> patients = [];
  List<Patient> filteredPatients = [];

  TextEditingController searchController = TextEditingController();


  @override
  void initState() {
    super.initState();
    fetchData();
    searchController.addListener(_filterPatients);
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse('https://flutter-amr.noviindus.in/api/PatientList');
      final token = Provider.of<AuthProvider>(context, listen: false).token;
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          patients = (jsonData['patient'] as List)
              .map((item) => Patient.fromJson(item))
              .toList();
          filteredPatients = patients;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void _filterPatients() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredPatients = patients
          .where((patient) => patient.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.green.shade100,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search Patient',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Patient List',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),

            ],
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Click on each to get full details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: filteredPatients.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: filteredPatients.length,
              itemBuilder: (ctx, index) => ListTile(
                leading: Icon(Icons.person),
                title: Text('Name: ${filteredPatients[index].name}'),
                subtitle: Text('Address: ${filteredPatients[index].address}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          PatientDetailsScreen(patient: filteredPatients[index]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
