import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/branch_provider.dart';
import '../providers/treatment_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/patient_form.dart';

class RegisterPatientScreen extends StatelessWidget {
  static const routeName = '/register-patient';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final branchProvider = Provider.of<BranchProvider>(context, listen: false);
    final treatmentProvider = Provider.of<TreatmentProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register Patient'),
      ),
      body: FutureBuilder(
        future: Future.wait([
          branchProvider.fetchBranches(authProvider.token),
          treatmentProvider.fetchTreatments(authProvider.token),
        ]),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred'));
          } else {
            return PatientForm();
          }
        },
      ),
    );
  }
}
