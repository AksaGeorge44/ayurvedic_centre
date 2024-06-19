import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/branch_provider.dart';
import '../providers/auth_provider.dart'; // Assuming you have an AuthProvider for token management

class BranchScreen extends StatelessWidget {
  static const routeName = '/branches';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false); // Assuming you have an AuthProvider for token management
    final token = authProvider.token; // Get the token from AuthProvider

    return Scaffold(
      appBar: AppBar(
        title: Text('Branches'),
      ),
      body: FutureBuilder(
        future: Provider.of<BranchProvider>(context, listen: false).fetchBranches(token),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('An error occurred!'));
          } else {
            return Consumer<BranchProvider>(
              builder: (ctx, branchProvider, child) => ListView.builder(
                itemCount: branchProvider.branches.length,
                itemBuilder: (ctx, index) {
                  final branch = branchProvider.branches[index];
                  return ListTile(
                    title: Text(branch.name),
                    subtitle: Text('Location: ${branch.location}\nPhone: ${branch.phone}\nPatients: ${branch.patientsCount}'),
                    isThreeLine: true,
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
