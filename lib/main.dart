import 'package:flutter/material.dart';

void main() {
  runApp(AppConvertisseur());
}

class AppConvertisseur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertisseur de Mesures',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.blueAccent,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18.0),
        ),
      ),
      home: PageConvertisseur(),
    );
  }
}

class PageConvertisseur extends StatefulWidget {
  @override
  _PageConvertisseurState createState() => _PageConvertisseurState();
}

class _PageConvertisseurState extends State<PageConvertisseur> {
  final TextEditingController _controller = TextEditingController();

  String _uniteDepart = 'mètres';
  String _uniteArrivee = 'kilomètres';
  String _resultat = "0.0";

  final Map<String, int> _mesuresMap = {
    'mètres': 0,
    'kilomètres': 1,
    'grammes': 2,
    'kilogrammes': 3,
    'pieds': 4,
    'miles': 5,
    'livres': 6,
    'onces': 7,
  };

  final List<List<double>> _formules = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0], // Mètres
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0], // Kilomètres
    [0, 0, 1, 0.0001, 0, 0, 0.0022, 0.03527], // Grammes
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274], // Kilogrammes
    [0.3048, 0.0003, 0, 0, 1, 0.00019, 0, 0], // Pied
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0], // Miles
    [0, 0, 453.592, 0.45359, 0, 0, 1, 16], // Livres
    [0, 0, 28.3495, 0.022835, 0, 0, 0.0625, 1] // Onces
  ];

  void _convertir() {
    setState(() {
      int numDepuis = _mesuresMap[_uniteDepart]!;
      int numVers = _mesuresMap[_uniteArrivee]!;
      double valeur = double.tryParse(_controller.text) ?? 0.0;
      double resultat = valeur * _formules[numDepuis][numVers];
      _resultat = ajusterResultat(resultat);
    });
  }
  String ajusterResultat(double resultat) { // Permet de résoudre les soucis de conversion des doubles
    String resultatStr = resultat.toStringAsFixed(10);
    resultatStr = double.parse(resultatStr).toString();

    return resultatStr;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Convertisseur de Mesures'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Spacer(),
            Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Entrez la valeur à convertir',
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true), // Challenge B fait
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: _uniteDepart,
                      onChanged: (newValue) {
                        setState(() {
                          _uniteDepart = newValue!;
                        });
                      },
                      items: _mesuresMap.keys.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: _uniteArrivee,
                      onChanged: (newValue) {
                        setState(() {
                          _uniteArrivee = newValue!;
                        });
                      },
                      items: _mesuresMap.keys.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    ElevatedButton(
                      onPressed: _convertir,
                      child: const Text('Convertir'),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              '${_controller.text} $_uniteDepart est égal à  : $_resultat $_uniteArrivee',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(flex: 8),
          ],
        ),
      ),
    );
  }
}
