class Weather
{
  final String cityName;
  final double tempreture;
  final String mainCondition;
  Weather({required this.cityName,required this.mainCondition,required this.tempreture});
  factory Weather.fromJson(Map<String,dynamic> Json){
    return Weather(
    cityName: Json['name'],
    mainCondition: Json['weather'][0]['main'],
    tempreture: Json['main']['temp'].toDouble());
  }
}