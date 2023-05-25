import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';


class HomePage extends StatelessWidget {
  WeatherModel? weatherDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchPage()));
                },
                icon: Icon(Icons.search)),
          ],
          title: Text('Weather App'),
        ),
        body: BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoding) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WeatherSuccess) {
              return SuccessWidget(weatherDate: state.weatherModel);
            } else if (state is WeatherFailure) {
              return Center(
                child: Text('error'),
              );
            } else {
              return InitiWidget();
            }
          },
        ));
  }
}

class InitiWidget extends StatelessWidget {
  const InitiWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'there is no weather 😔 start',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'searching now 🔍',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({
    Key? key,
    required this.weatherDate,
  }) : super(key: key);

  final WeatherModel? weatherDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          weatherDate!.getThemeColor(),
          weatherDate!.getThemeColor()[300]!,
          weatherDate!.getThemeColor()[100]!,
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Text(
              BlocProvider.of<WeatherCubit>(context).cityName!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
            Text(
              'updated at : ${weatherDate!.date.hour}:${weatherDate!.date.minute}',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(weatherDate!.getImge()),
                Text(
                  '${weatherDate!.temp.toInt()}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('max temp :${weatherDate!.maxtemp.toInt()}'),
                    Text('min temp:${weatherDate!.mintemp.toInt()}'),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Text(
              weatherDate!.weatherStatName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
            const Spacer(
              flex: 5,
            ),
          ],
        ),
      ),
    );
  }
}
