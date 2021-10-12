import 'package:flutter/material.dart';
import '../model/model.dart';
import '../services/http.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Weather>? weather;
  Future<Sys>? sys;
  @override
  void initState() {
    sys = getData();
    super.initState();
  }

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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.grey.shade900,
          Colors.black,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _cloudIcon(),
              temp(),
              location(),
              _date(),
              _hourlyPrediction(),
              _weeklyPredictions(),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<Weather> temp() {
    return FutureBuilder<Weather>(
      future: weather,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!.description.toString(),
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w100,
              ),
            );
          }else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        return Center(child: const CircularProgressIndicator());
      },
    );
  }

    FutureBuilder<Sys> location() {
    return FutureBuilder<Sys>(
      future: sys,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Text(
              snapshot.data!.country.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w100,
              ),
            );
          }else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }
        return Center(child: const CircularProgressIndicator());
      },
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

_location() {
  return Row(
    children: [
      Icon(Icons.place),
      SizedBox(
        width: 10,
      ),
      Text('Osla, No')
    ],
  );
}

_date() {
  return Row(
    children: [
      Text('today'),
      SizedBox(
        width: 10,
      ),
      Text('08-10-2021')
    ],
  );
}

final times = ['1', '2', '4', '6', '7', '8', '10', '3', '20'];
_hourlyPrediction() {
  return Container(
    height: 100,
    decoration: BoxDecoration(
        border: Border(
      top: BorderSide(color: Colors.white),
      bottom: BorderSide(color: Colors.white),
    )),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: times.length,
      itemBuilder: (context, index) {
        return Container(
            width: 50,
            child: Card(
              child: Center(
                child: Text('${times[index]}'),
              ),
            ));
      },
    ),
  );
}

_weeklyPredictions() {
  return Expanded(
    child: Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: times.length,
        itemBuilder: (context, index) {
          return Container(
              height: 50,
              child: Card(
                child: Center(
                  child: Text('${times[index]}'),
                ),
              ));
        },
      ),
    ),
  );
}
