import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:wheater_app/data/my_data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());

      try {
        WeatherFactory wf = WeatherFactory("bd5e378503939ddaee76f12ad7a97608",
            language: Language.ENGLISH);

        // Position position = await Geolocator.getCurrentPosition();
        // print(position);

        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude,
             event.position.longitude
             );

        // Weather weather = await wf.currentWeatherByCityName("faisalabad");

        // Console.(weather);

        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}
