import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/newmodel.dart';
import '../services/service.dart';
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<WeatherData>? weather;
  String dropdownvalue = 'cairo';

  @override
  void initState() {
    weather = getData(dropdownvalue);
    super.initState();
  }

  void getweather() {
    setState(() {
      weather = getData(dropdownvalue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forecast'),
        centerTitle: true,
        actions: [
          DropdownButton(
              value: dropdownvalue,
              icon: Icon(Icons.arrow_drop_down),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
                getweather();
              },
              items: <String>[
                'nsukka',
                'london',
                'cairo',
                'tokyo',
                'texas',
                'paris'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList())
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.grey.shade900,
            Colors.grey.shade800,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 20,
          ),
          child: FutureBuilder<WeatherData>(
            future: weather,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //_cloudIcon(),

                      _city(snapshot.data!.name!.toUpperCase()),
                      //_temperature(),
                      Text(
                        "${snapshot.data!.main!.temp.toString()} fah",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      _location(snapshot.data!.sys!.country),
                      _date(),
                      _hourlyPrediction(),
                      _weeklyPredictions(),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text("couldn't load weather data"));
                }
              }
              return Center(
                child: LoadingIndicator(
                    indicatorType: Indicator.circleStrokeSpin,
                    colors: const [Colors.white],
                    strokeWidth: 2,
                    //backgroundColor: Colors.black,
                    //pathBackgroundColor: Colors.black
                    ),
              );
            },
          ),
        ),
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

_city(Wdata) {
  return Row(
    children: [
      Text(
        Wdata,
        style: TextStyle(fontSize: 30),
      )
    ],
  );
}

_location(Wdata) {
  return Row(
    children: [
      Icon(Icons.place),
      SizedBox(
        width: 10,
      ),
      Text(Wdata)
    ],
  );
}

final DateTime now = DateTime.now();
final DateFormat formatter = DateFormat('yyyy-MM-dd');
final String formatted = formatter.format(now);

_date() {
  return Row(
    children: [
      Text(formatted),
      SizedBox(
        width: 10,
      ),
      //Text('08-10-2021')
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
