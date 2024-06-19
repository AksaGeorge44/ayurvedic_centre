import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/patient_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/branch_provider.dart';
import '../providers/treatment_provider.dart';

class PatientForm extends StatefulWidget {
  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _executive = '';
  String _payment = '';
  String _phone = '';
  String _address = '';
  double _totalAmount = 0.0;
  double _discountAmount = 0.0;
  double _advanceAmount = 0.0;
  double _balanceAmount = 0.0;
  String _dateTime = '';
  List<int> _maleTreatments = [];
  List<int> _femaleTreatments = [];
  int _branch = 0;
  List<int> _selectedTreatments = [];

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final patientProvider = Provider.of<PatientProvider>(context, listen: false);
    try {
      await patientProvider.registerPatient(
        token: authProvider.token,
        name: _name,
        executive: _executive,
        payment: _payment,
        phone: _phone,
        address: _address,
        totalAmount: _totalAmount,
        discountAmount: _discountAmount,
        advanceAmount: _advanceAmount,
        balanceAmount: _balanceAmount,
        dateTime: _dateTime,
        id: '',
        maleTreatments: _maleTreatments,
        femaleTreatments: _femaleTreatments,
        branch: _branch,
        treatments: _selectedTreatments,
      );
      // Generate PDF and navigate back
      Navigator.of(context).pop();
    } catch (error) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to register patient. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final branchProvider = Provider.of<BranchProvider>(context);
    final treatmentProvider = Provider.of<TreatmentProvider>(context);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onSaved: (value) => _name = value!,
              validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
            ),
            // Other form fields...
            DropdownButtonFormField(
              items: branchProvider.branches
                  .map((branch) => DropdownMenuItem(
                child: Text(branch.name),
                value: branch.id,
              ))
                  .toList(),
              onChanged: (value) {
                _branch = value as int;
              },
              hint: Text('Select Branch'),
            ),
            // Treatment selection logic...
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Register Patient'),
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
