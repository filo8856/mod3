import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mod3/Screens/home/history.dart';
import 'package:mod3/Screens/loading.dart';
import 'package:mod3/Services/auth.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double avg(Map<String, String>? result) {
    if (result == null) return 0;
    return (double.parse(result['high']!) + double.parse(result['low']!)) / 2;
  }
  String error = '';
  bool load=false;
  Future<Map<String, String>?> calculate(String symbol, String date) async {
    final String key = 'BX2EMF6YSH154065';
    final String url =
        'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$key';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final daily = body['Time Series (Daily)'];
      if (daily != null && daily[date] != null) {
        return {'high': daily[date]['2. high'], 'low': daily[date]['3. low']};
      } else {
        setState(() {
          error = 'No data for date $date';
        });
        return null;
      }
    } else {
      setState(() {
        error = 'Failed to fetch data';
      });
      return null;
    }
  }

  final AuthService _auth = AuthService();
  String symbol = '';
  int units = 0;
  TextEditingController _buydate = TextEditingController();
  TextEditingController _selldate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return load?Loading():Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Stocks',
          style: TextStyle(
            color: Colors.black,
            fontSize: 50.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          iconSize: 55,
          icon: Icon(Icons.timeline),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => History()),
            );
          },
        ),
        toolbarHeight: 150,
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new_rounded),
            color: Colors.black,
            iconSize: 55,
            onPressed: () async {
              await _auth.SO();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 20),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter Symbol',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    symbol = val.trim();
                  });
                },
              ),
              SizedBox(height: 40),
              TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter Quantity',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    units = int.parse(val);
                  });
                },
              ),
              SizedBox(height: 40),
              TextField(
                style: TextStyle(fontSize: 25),
                controller: _buydate,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Buy Date',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                ),
                readOnly: true,
                onTap: () {
                  _Buydate();
                },
              ),
              SizedBox(height: 40),
              TextField(
                style: TextStyle(fontSize: 25),
                controller: _selldate,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Sell Date',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.calendar_today),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.black, width: 3.0),
                  ),
                ),
                readOnly: true,
                onTap: () {
                  _Selldate();
                },
              ),
              SizedBox(height: 40),
              Container(
                width: 150,
                height: 60,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40), // round corners
                  ),
                  onPressed: () async {
                    setState(() {
                      load=true;
                    });
                    if (symbol.isEmpty ||
                        _buydate.text.isEmpty ||
                        _selldate.text.isEmpty) {
                      load=false;
                      return;
                    }
                    final rbuy = await calculate(symbol, _buydate.text);
                    if (rbuy == null){
                      load=false;
                      return;
                    }
                    final rsell = await calculate(symbol, _selldate.text);
                    if (rsell == null) {
                      load=false;
                      return;
                    }
                    if (rsell != null && rbuy != null) {
                      setState(() {
                        load=false;
                      });
                      String result = '';
                      Color color=Colors.black;
                      double profit = units * (avg(rbuy) - avg(rsell));
                      profit=double.parse(profit.toStringAsFixed(2));
                      if (avg(rsell) < avg(rbuy)) {
                        result = 'Lost';
                        color=Colors.red;
                      } else if (avg(rsell) > avg(rbuy)) {
                        result = 'Got';
                        color=Colors.blue;
                      } else
                        {result = 'No Profit No Loss';
                        color=Colors.black;}
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                result +"!\n\n\$$profit",
                                style: TextStyle(color: color),
                              ),
                            ),
                            content: Text(''
                            ),
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'Calculate',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _Buydate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (_picked != null) {
      setState(() {
        _buydate.text = _picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _Selldate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (_picked != null) {
      setState(() {
        _selldate.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
