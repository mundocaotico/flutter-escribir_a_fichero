import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  //const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String printLatestValue = '0';
  final myController = TextEditingController();
  void reset() {
    myController.text = '0';
  }

  String _printLatestValue() {
    print(myController.text); // Para propósitos de depuración
    printLatestValue = myController.text;
    return myController.text;
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(() {
      _printLatestValue();
    });
  }

  Future<String> get _localPath async {
    // Finds the path to the documents directory
    final directory = await getApplicationDocumentsDirectory();
    print(directory);
    return directory.path;
  }

  Future<File> get _localFile async {
    // Creates a reference to the file´s full location
    final path = await _localPath;
    return File('$path/test.txt');
  }

  Future<File> writeContent(String text) async {
  text = _printLatestValue();
    final file = await _localFile;

    return file.writeAsString(text); // '' pendiente de cambiarse
  } // pendiente de rellenar () de writeContent

  Future<String> readContent() async {
    // Manejo de errores
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'An error has been encountered';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Escribir a archivo"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Escribe el texto que quieras: "),
            Flexible(
              child: FractionallySizedBox(
                widthFactor: 0.5,
                heightFactor: 0.5,
                child: Container(
                  child: TextField(
                    controller: myController, // Necesario para coger el texto del TextEditingController al darle al boton de escribir al fichero
                    keyboardType: TextInputType.multiline,
                    maxLines: 12,
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () => writeContent(_printLatestValue()),
                child: Text("Escribir texto a fichero"))
          ],
        )));
  }
}
