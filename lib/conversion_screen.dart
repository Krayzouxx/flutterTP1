import 'package:flutter/material.dart';

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _units = ['Mètres', 'Kilomètres','Grammes','Kilogrammes','Pieds','Miles','Livres','Onces'];
  String _startUnit = 'Miles';
  String _targetUnit = 'Kilomètres';
  double? _inputNumber;
  String _result = '';

  // Fonction de conversion
  void _convert() {
    if (_formKey.currentState!.validate()) {
      double result = 0.0;
      if (_startUnit == 'Miles') {

        result = _inputNumber! * 1.60934;

      }
      setState(() {
        _result = result.toStringAsFixed(2);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convertisseur de Mesures'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Entrez le nombre à convertir'),
              keyboardType: TextInputType.number,
              onSaved: (value) => _inputNumber = double.tryParse(value!),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un nombre';
                }
                return null;
              },
            ),
            DropdownButtonFormField(
              value: _startUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _startUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButtonFormField(
              value: _targetUnit,
              onChanged: (String? newValue) {
                setState(() {
                  _targetUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _convert();
                }
              },
              child: const Text('Convertir'),
            ),
            Text(_result),
          ],
        ),
      ),
    );
  }
}