import 'package:flutter/material.dart';

void main() {
  runApp(TempConverterApp());
}

class TempConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: TempConverterScreen(),
    );
  }
}

class TempConverterScreen extends StatefulWidget {
  @override
  _TempConverterScreenState createState() => _TempConverterScreenState();
}

class _TempConverterScreenState extends State<TempConverterScreen> {
  final TextEditingController _tempController = TextEditingController();
  String _conversionType = 'FtoC';
  String _result = '';
  List<String> _history = [];

  void _convertTemperature() {
    String tempInput = _tempController.text;
    if (tempInput.isEmpty || double.tryParse(tempInput) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid temperature value')),
      );
      return;
    }

    double temp = double.parse(tempInput);
    double convertedTemp;
    String conversion;

    if (_conversionType == 'FtoC') {
      convertedTemp = ((temp - 32) * 5 / 9);
      _result = '${temp.toStringAsFixed(2)} °F = ${convertedTemp.toStringAsFixed(2)} °C';
      conversion = 'F to C: ${temp.toStringAsFixed(2)} => ${convertedTemp.toStringAsFixed(2)}';
    } else {
      convertedTemp = ((temp * 9 / 5) + 32);
      _result = '${temp.toStringAsFixed(2)} °C = ${convertedTemp.toStringAsFixed(2)} °F';
      conversion = 'C to F: ${temp.toStringAsFixed(2)} => ${convertedTemp.toStringAsFixed(2)}';
    }

    setState(() {
      _history.add(conversion);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter temperature',
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio<String>(
                  value: 'FtoC',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                Text('Fahrenheit to Celsius'),
                Radio<String>(
                  value: 'CtoF',
                  groupValue: _conversionType,
                  onChanged: (value) {
                    setState(() {
                      _conversionType = value!;
                    });
                  },
                ),
                Text('Celsius to Fahrenheit'),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
