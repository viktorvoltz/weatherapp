import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
            icon: Icon(Icons.settings),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cloudIcon(),
          _temperature(),
        ],
      ),
    );
  }
}

_cloudIcon() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Icon(
      Icons.cloud,
      size: 80,
    ),
  );
}

_temperature() {
  return Text(
    '-10',
    style: TextStyle(
      fontSize: 80,
      fontWeight: FontWeight.w100,
    ),
  );
}
