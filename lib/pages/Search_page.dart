import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';

class SearchPage extends StatelessWidget {
  SearchPage();

  String? cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Search page',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: TextField(
              onChanged: (value) => cityName = value,
              onSubmitted: (value) async {
                cityName = value;

                BlocProvider.of<WeatherCubit>(context)
                    .getWeather(cityName: cityName!);
                    
                BlocProvider.of<WeatherCubit>(context).cityName=cityName;

                Navigator.pop(context);
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(30.0),
                border: OutlineInputBorder(),
                labelText: 'Search',
                hintText: 'Enter City Name',
                suffixIcon: IconButton(
                  onPressed: (() async {
                    BlocProvider.of<WeatherCubit>(context)
                        .getWeather(cityName: cityName!);
                    Navigator.pop(context);
                  }),
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ));
  }
}
