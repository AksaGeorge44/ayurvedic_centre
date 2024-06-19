import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/branch_provider.dart';
import '../providers/patient_provider.dart';
import '../providers/treatment_provider.dart';
import '../providers/auth_provider.dart';

class RegisterPatientScreen extends StatelessWidget {
  static const routeName = '/register-patient';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final branchProvider = Provider.of<BranchProvider>(context, listen: false);
    final treatmentProvider = Provider.of<TreatmentProvider>(context, listen: false);
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
        // Navigate back after successful registration
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
        print('Error during patient registration: $error');
      }
    }


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
            return  Padding(
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
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Executive'),
                      onSaved: (value) => _executive = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter an executive' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Payment'),
                      onSaved: (value) => _payment = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter payment details' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Phone'),
                      onSaved: (value) => _phone = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter a phone number' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Address'),
                      onSaved: (value) => _address = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter an address' : null,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Total Amount'),
                      onSaved: (value) => _totalAmount = double.tryParse(value!) ?? 0.0,
                      validator: (value) => value!.isEmpty ? 'Please enter total amount' : null,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Discount Amount'),
                      onSaved: (value) => _discountAmount = double.tryParse(value!) ?? 0.0,
                      validator: (value) => value!.isEmpty ? 'Please enter discount amount' : null,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Advance Amount'),
                      onSaved: (value) => _advanceAmount = double.tryParse(value!) ?? 0.0,
                      validator: (value) => value!.isEmpty ? 'Please enter advance amount' : null,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Balance Amount'),
                      onSaved: (value) => _balanceAmount = double.tryParse(value!) ?? 0.0,
                      validator: (value) => value!.isEmpty ? 'Please enter balance amount' : null,
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Date & Time'),
                      onSaved: (value) => _dateTime = value!,
                      validator: (value) => value!.isEmpty ? 'Please enter date and time' : null,
                      keyboardType: TextInputType.datetime,
                    ),
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
                      validator: (value) => value == null ? 'Please select a branch' : null,
                    ),
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
        },
      ),
    );
  }
}
