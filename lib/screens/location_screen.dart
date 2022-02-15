import 'package:clima_flutter_test/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima_flutter_test/utilities/constants.dart';
import 'package:clima_flutter_test/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.LocationWeaather});

  final LocationWeaather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int temp = 0;
  String tempM = "";
  String condition = "";
  String city = "";
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUserui(widget.LocationWeaather);
  }

  void updateUserui(dynamic weatherData) {
    setState(() {
      if(weatherData==null){
        return;
      }
      double temper = weatherData['main']['temp'];
      temp = temper.toInt();
      tempM = weatherModel.getMessage(temp);
      print(temp);
      var weatherCond = weatherData['weather'][0]['id'];
      print(weatherCond);
      condition = weatherModel.getWeatherIcon(weatherCond);
      city = weatherData['name'];
      print(city);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weatherModel.getLocationWeather();
                      updateUserui(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CityScreen(),
                          ));
                      print(result);
                      if(result!= null){
                       var weaatherData = await weatherModel.getCityWeather(result);
                       updateUserui(weaatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "$temp°",
                      style: kTempTextStyle,
                    ),
                    Text(
                      condition,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$tempM in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
