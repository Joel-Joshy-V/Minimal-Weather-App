class weather {
  final String cityName;
  final double temperature;
  final String maincondition;

  weather({
    required this.cityName,
    required this.temperature,
    required this.maincondition,
  });

  factory weather.fromJson(Map<String, dynamic> json) {
    return weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      maincondition: json['weather'][0]['main'],
    );
  }
}
