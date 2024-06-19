import 'package:ayurvedic_centre/screens/branch_screen.dart';
import 'package:ayurvedic_centre/screens/home.dart';
import 'package:ayurvedic_centre/screens/login.dart';
import 'package:ayurvedic_centre/screens/reg_patient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'providers/patient_provider.dart';
import 'providers/branch_provider.dart';
import 'providers/treatment_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => PatientProvider()),
          ChangeNotifierProvider(create: (_) => BranchProvider()),
          ChangeNotifierProvider(create: (_) => TreatmentProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ayurvedic Centre',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: LoginScreen(),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            RegisterPatientScreen.routeName: (ctx) => RegisterPatientScreen(),
            BranchScreen.routeName: (ctx) => BranchScreen(),

          },
        ),
      ),
    );
  }
}
