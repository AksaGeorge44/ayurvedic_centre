import 'package:flutter/material.dart';
import '../models/patient.dart';

class PatientDetailsScreen extends StatelessWidget {
  final Patient patient;

  PatientDetailsScreen({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListTile(
          title: Text('Patient Name: ${patient.name}'),
          subtitle: Text('Address: ${patient.address}\n'
              'Phoneno: ${patient.phone}\nPayment: ${patient.payment}\n'
              'Total Amount: ${patient.totalAmount}\n'
              'Discount Amount: ${patient.discountAmount}\n'
              'Advance Amount: ${patient.advanceAmount}\n'
              'Balance Amount: ${patient.balanceAmount}\n'
              'Date & Time: ${patient.dateTime}\nUser: ${patient.user}'
              ),
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //
          //
          //     Text('Patient Name: ${patient.name}'),
          //     Text(' Address: ${patient.address}'),
          //     Text(' Phoneno: ${patient.phone}'),
          //     Text('Payment: ${patient.payment}'),
          //     Text('Total Amount: ${patient.totalAmount}'),
          //     Text('Discount Amount: ${patient.discountAmount}'),
          //     Text('Advance Amount: ${patient.advanceAmount}'),
          //     Text('Balance Amount: ${patient.balanceAmount}'),
          //     Text('                Date & Time: ${patient.dateTime}'),
          //     Text('User: ${patient.user}'),
          //
          //   ],
          // ),
        ),
      ),
    );
  }
}
