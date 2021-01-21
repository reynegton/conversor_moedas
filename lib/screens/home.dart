import 'dart:convert';
import 'package:conversor_moedas/api/end_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
//import 'package:flutter_masked_text/flutter_masked_text.dart';

final request = urlFinances();

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolarPrecoVenda;
  double euroPrecoVenda;

  final realController = TextEditingController();
  final dolarlController = TextEditingController();
  final eurolController = TextEditingController();

  Widget buildTextField(String label, String prefix,
      TextEditingController controller, Function onChange) {
    return TextField(
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      onChanged: onChange,
      controller: controller,
      style: TextStyle(
        color: Colors.amber,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.amber,
        ),
        border: OutlineInputBorder(),
        prefixText: prefix,
      ),
    );
  }

  Future<Map> getData() async {
    http.Response response = await http.get(request);
    return json.decode(response.body);
  }

  void _realChanged(String text) {
    double real = double.parse(text);
    dolarlController.text = (real / dolarPrecoVenda).toStringAsFixed(2);
    eurolController.text = (real / euroPrecoVenda).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    realController.text = (dolarPrecoVenda * dolar).toStringAsFixed(2);
    eurolController.text = (dolarPrecoVenda * dolar/euroPrecoVenda).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (euroPrecoVenda * euro).toStringAsFixed(2);
    dolarlController.text = (euroPrecoVenda * euro/dolarPrecoVenda).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '\$ Conversor Moeda \$',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  'Carregando',
                  style: TextStyle(color: Colors.amber),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erro',
                    style: TextStyle(color: Colors.amber),
                  ),
                );
              } else {
                dolarPrecoVenda =
                snapshot.data['results']['currencies']['USD']['buy'];
                euroPrecoVenda =
                snapshot.data['results']['currencies']['EUR']['buy'];

                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 120,
                        color: Colors.amber,
                      ),
                      buildTextField(
                          'Reais', 'R\$ ', realController, _realChanged),
                      Divider(),
                      buildTextField(
                          'Dólares', 'US\$ ', dolarlController, _dolarChanged),
                      Divider(),
                      buildTextField(
                          'Euros', '€ ', eurolController, _euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}


