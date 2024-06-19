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
        child: Table(
          border: TableBorder.all(color: Colors.black),
          columnWidths: {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          children: [
            _buildTableRow('Patient Name', patient.name),
            _buildTableRow('Address', patient.address),
            _buildTableRow('Phone', patient.phone),
            _buildTableRow('Payment', patient.payment),
            _buildTableRow('Total Amount', patient.totalAmount.toString()),
            _buildTableRow('Discount Amount', patient.discountAmount.toString()),
            _buildTableRow('Advance Amount', patient.advanceAmount.toString()),
            _buildTableRow('Balance Amount', patient.balanceAmount.toString()),
            _buildTableRow('Date & Time', patient.dateTime.toString()),
            _buildTableRow('User', patient.user),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value),
        ),
      ],
    );
  }
}
