import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sugar Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: MainPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  var txtM = TextEditingController(); // mmol/L
  var txtA = TextEditingController(); // mg/dL
  var txtB = TextEditingController(); // A1C

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      var aInt = double.parse(value);
                      txtM.text = (aInt * 0.0555).toString();
                      txtB.text = ((aInt + 46.7) / 28.7).toString();
                    },
                    controller: txtA,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                      TextInputFormatter.withFunction(
                        (oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {}
                          return oldValue;
                        },
                      ),
                    ],
                    onTap: () {
                      txtA.clear();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(" mg/dL"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      var mmInt = double.parse(value);
                      txtA.text = (mmInt / 0.0555).toString();
                      txtB.text = (((mmInt / 0.0555) + 46.7) / 28.7).toString();
                    },
                    controller: txtM,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {}
                        return oldValue;
                      }),
                    ],
                    onTap: () {
                      txtM.clear();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(" mmol/L"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      var a1cInt = double.parse(value);
                      txtA.text = (28.7 * a1cInt - 46.7).toString();
                      txtM.text = ((28.7 * a1cInt - 46.7) * 0.0555).toString();
                    },
                    controller: txtB,
                    keyboardType: const TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {}
                        return oldValue;
                      }),
                    ],
                    onTap: () {
                      txtB.clear();
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                const Text(" A1C"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
