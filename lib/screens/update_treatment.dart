import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/treatment.dart';
import '../providers/treatment_provider.dart';
import '../providers/auth_provider.dart';

class EditTreatmentScreen extends StatefulWidget {
  static const routeName = '/edit-treatment';

  final Treatment treatment;

  EditTreatmentScreen({required this.treatment});

  @override
  _EditTreatmentScreenState createState() => _EditTreatmentScreenState();
}

class _EditTreatmentScreenState extends State<EditTreatmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _duration;
  late String _price;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    _name = widget.treatment.name;
    _duration = widget.treatment.duration;
    _price = widget.treatment.price;
    _isActive = widget.treatment.isActive;
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    final updatedTreatment = Treatment(
      id: widget.treatment.id,
      branches: widget.treatment.branches,
      name: _name,
      duration: _duration,
      price: _price,
      isActive: _isActive,
      createdAt: widget.treatment.createdAt,
      updatedAt: DateTime.now(),
    );


    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final token = authProvider.token;

    try {
      await Provider.of<TreatmentProvider>(context, listen: false).
      updateTreatment(token, updatedTreatment);

      Navigator.of(context).pop();
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Treatment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _duration,
                decoration: InputDecoration(labelText: 'Duration'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
                onSaved: (value) {
                  _duration = value!;
                },
              ),
              TextFormField(
                initialValue: _price,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
                onSaved: (value) {
                  _price = value!;
                },
              ),
              SwitchListTile(
                title: Text('Is Active'),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
