class WeatherData {
  final String cityName;
  final double temperature;
  final String description;
  final String main;

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.main,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      main: json['weather'][0]['main']
    );
  }
}
