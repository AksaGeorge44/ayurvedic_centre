import 'package:flutter/material.dart';
import '../models/patient.dart';

class PatientListItem extends StatelessWidget {
  final Patient patient;

  PatientListItem(this.patient);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(patient.name),
        subtitle: Text('Phone: ${patient.phone}'),
        trailing: Text('Balance: \$${patient.balanceAmount.toStringAsFixed(2)}'),
      ),
    );
  }
}
