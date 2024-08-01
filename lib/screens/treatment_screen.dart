import 'package:ayurvedic_centre/screens/update_treatment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/treatment_provider.dart';
import '../providers/auth_provider.dart';

class TreatmentScreen extends StatelessWidget {
  static const routeName = '/treatments';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;

    return Scaffold(
      appBar: AppBar(
        title: Text('Treatments'),
      ),
      body: FutureBuilder(
        future: Provider.of<TreatmentProvider>(context, listen: false).fetchTreatments(token),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<TreatmentProvider>(
              builder: (ctx, treatmentProvider, child) => ListView.builder(
                itemCount: treatmentProvider.treatments.length,
                itemBuilder: (ctx, index) {
                  final treatment = treatmentProvider.treatments[index];
                  return ListTile(
                    title: Text(treatment.name),
                    subtitle: Text('Duration: ${treatment.duration}\nPrice: ${treatment.price}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EditTreatmentScreen(treatment: treatment),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
