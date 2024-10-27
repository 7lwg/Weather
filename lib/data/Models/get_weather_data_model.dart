class WeatherDataModel {
  final int? queryCost;
  final double? latitude;
  final double? longitude;
  final String? resolvedAddress;
  final String? address;
  final String? timezone;
  final double? tzoffset;
  final List<Day>? days;
  final Map<String, WeatherStation>? stations;
  final CurrentConditions? currentConditions;

  WeatherDataModel({
    this.queryCost,
    this.latitude,
    this.longitude,
    this.resolvedAddress,
    this.address,
    this.timezone,
    this.tzoffset,
    this.days,
    this.stations,
    this.currentConditions,
  });

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    var daysList =
        (json['days'] as List).map((day) => Day.fromJson(day)).toList();

    var stationsMap = (json['stations'] as Map<String, dynamic>)
        .map((key, value) => MapEntry(key, WeatherStation.fromJson(value)));

    return WeatherDataModel(
      queryCost: json['queryCost'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      resolvedAddress: json['resolvedAddress'],
      address: json['address'],
      timezone: json['timezone'],
      tzoffset: json['tzoffset'],
      days: daysList,
      stations: stationsMap,
      currentConditions: CurrentConditions.fromJson(json['currentConditions']),
    );
  }
}

class Day {
  final String? datetime;
  final int? datetimeEpoch;
  final double? tempmax;
  final double? tempmin;
  final double? temp;
  final double? feelslikemax;
  final double? feelslikemin;
  final double? feelslike;
  final double? dew;
  final double? humidity;
  final double? precip;
  final double? precipprob;
  final double? precipcover;
  final List<dynamic>? preciptype;
  final double? snow;
  final double? snowdepth;
  final double? windgust;
  final double? windspeed;
  final double? winddir;
  final double? pressure;
  final double? cloudcover;
  final double? visibility;
  final double? solarradiation;
  final double? solarenergy;
  final double? uvindex;
  final double? severerisk;
  final String? sunrise;
  final int? sunriseEpoch;
  final String? sunset;
  final int? sunsetEpoch;
  final double? moonphase;
  final String? conditions;
  final String? description;
  final String? icon;
  final List<String>? stations;
  final String? source;
  final List<Hour>? hours;

  Day({
    this.datetime,
    this.datetimeEpoch,
    this.tempmax,
    this.tempmin,
    this.temp,
    this.feelslikemax,
    this.feelslikemin,
    this.feelslike,
    this.dew,
    this.humidity,
    this.precip,
    this.precipprob,
    this.precipcover,
    this.preciptype,
    this.snow,
    this.snowdepth,
    this.windgust,
    this.windspeed,
    this.winddir,
    this.pressure,
    this.cloudcover,
    this.visibility,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.severerisk,
    this.sunrise,
    this.sunriseEpoch,
    this.sunset,
    this.sunsetEpoch,
    this.moonphase,
    this.conditions,
    this.description,
    this.icon,
    this.stations,
    this.source,
    this.hours,
  });

  factory Day.fromJson(Map<String, dynamic> json) {
    var hoursList = json['hours'] as List;
    List<Hour> hours = hoursList.map((i) => Hour.fromJson(i)).toList();

    return Day(
      datetime: json['datetime'],
      datetimeEpoch: json['datetimeEpoch'],
      tempmax: json['tempmax'],
      tempmin: json['tempmin'],
      temp: json['temp'],
      feelslikemax: json['feelslikemax'],
      feelslikemin: json['feelslikemin'],
      feelslike: json['feelslike'],
      dew: json['dew'],
      humidity: json['humidity'],
      precip: json['precip'],
      precipprob: json['precipprob'],
      precipcover: json['precipcover'],
      preciptype: json['preciptype'],
      snow: json['snow'],
      snowdepth: json['snowdepth'],
      windgust: json['windgust'],
      windspeed: json['windspeed'],
      winddir: json['winddir'],
      pressure: json['pressure'],
      cloudcover: json['cloudcover'],
      visibility: json['visibility'],
      solarradiation: json['solarradiation'],
      solarenergy: json['solarenergy'],
      uvindex: json['uvindex'],
      severerisk: json['severerisk'],
      sunrise: json['sunrise'],
      sunriseEpoch: json['sunriseEpoch'],
      sunset: json['sunset'],
      sunsetEpoch: json['sunsetEpoch'],
      moonphase: json['moonphase'],
      conditions: json['conditions'],
      description: json['description'],
      icon: json['icon'],
      stations: json['stations']?.cast<String>(),
      source: json['source'],
      hours: hours,
    );
  }
}

class Hour {
  final String? datetime;
  final int? datetimeEpoch;
  final double? temp;
  final double? feelslike;
  final double? humidity;
  final double? dew;
  final double? precip;
  final double? precipprob;
  final double? snow;
  final double? snowdepth;
  final List<dynamic>? preciptype;
  final double? windgust;
  final double? windspeed;
  final double? winddir;
  final double? pressure;
  final double? visibility;
  final double? cloudcover;
  final double? solarradiation;
  final double? solarenergy;
  final double? uvindex;
  final double? severerisk;
  final String? conditions;
  final String? icon;
  final List<String>? stations;
  final String? source;

  Hour({
    this.datetime,
    this.datetimeEpoch,
    this.temp,
    this.feelslike,
    this.humidity,
    this.dew,
    this.precip,
    this.precipprob,
    this.snow,
    this.snowdepth,
    this.preciptype,
    this.windgust,
    this.windspeed,
    this.winddir,
    this.pressure,
    this.visibility,
    this.cloudcover,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.severerisk,
    this.conditions,
    this.icon,
    this.stations,
    this.source,
  });

  factory Hour.fromJson(Map<String, dynamic> json) {
    return Hour(
      datetime: json['datetime'],
      datetimeEpoch: json['datetimeEpoch'],
      temp: json['temp'],
      feelslike: json['feelslike'],
      humidity: json['humidity'],
      dew: json['dew'],
      precip: json['precip'],
      precipprob: json['precipprob'],
      snow: json['snow'],
      snowdepth: json['snowdepth'],
      preciptype: json['preciptype'],
      windgust: json['windgust'],
      windspeed: json['windspeed'],
      winddir: json['winddir'],
      pressure: json['pressure'],
      visibility: json['visibility'],
      cloudcover: json['cloudcover'],
      solarradiation: json['solarradiation'],
      solarenergy: json['solarenergy'],
      uvindex: json['uvindex'],
      severerisk: json['severerisk'],
      conditions: json['conditions'],
      icon: json['icon'],
      stations: json['stations']?.cast<String>(),
      source: json['source'],
    );
  }
}

class WeatherStation {
  final double? distance;
  final double? latitude;
  final double? longitude;
  final int? useCount;
  final String? id;
  final String? name;
  final int? quality;
  final double? contribution;

  WeatherStation({
    this.distance,
    this.latitude,
    this.longitude,
    this.useCount,
    this.id,
    this.name,
    this.quality,
    this.contribution,
  });

  factory WeatherStation.fromJson(Map<String, dynamic> json) {
    return WeatherStation(
      distance: json['distance'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      useCount: json['useCount'],
      id: json['id'],
      name: json['name'],
      quality: json['quality'],
      contribution: json['contribution'],
    );
  }
}

class CurrentConditions {
  final String? datetime;
  final int? datetimeEpoch;
  final double? temp;
  final double? feelslike;
  final double? humidity;
  final double? dew;
  final double? precip;
  final double? precipprob;
  final double? snow;
  final double? snowdepth;
  final List<dynamic>? preciptype;
  final double? windgust;
  final double? windspeed;
  final double? winddir;
  final double? pressure;
  final double? visibility;
  final double? cloudcover;
  final double? solarradiation;
  final double? solarenergy;
  final double? uvindex;
  final String? conditions;
  final String? icon;
  final List<String>? stations;
  final String? source;
  final String? sunrise;
  final int? sunriseEpoch;
  final String? sunset;
  final int? sunsetEpoch;
  final double? moonphase;

  CurrentConditions({
    this.datetime,
    this.datetimeEpoch,
    this.temp,
    this.feelslike,
    this.humidity,
    this.dew,
    this.precip,
    this.precipprob,
    this.snow,
    this.snowdepth,
    this.preciptype,
    this.windgust,
    this.windspeed,
    this.winddir,
    this.pressure,
    this.visibility,
    this.cloudcover,
    this.solarradiation,
    this.solarenergy,
    this.uvindex,
    this.conditions,
    this.icon,
    this.stations,
    this.source,
    this.sunrise,
    this.sunriseEpoch,
    this.sunset,
    this.sunsetEpoch,
    this.moonphase,
  });

  factory CurrentConditions.fromJson(Map<String, dynamic> json) {
    return CurrentConditions(
      datetime: json['datetime'],
      datetimeEpoch: json['datetimeEpoch'],
      temp: json['temp'],
      feelslike: json['feelslike'],
      humidity: json['humidity'],
      dew: json['dew'],
      precip: json['precip'],
      precipprob: json['precipprob'],
      snow: json['snow'],
      snowdepth: json['snowdepth'],
      preciptype: json['preciptype'],
      windgust: json['windgust'],
      windspeed: json['windspeed'],
      winddir: json['winddir'],
      pressure: json['pressure'],
      visibility: json['visibility'],
      cloudcover: json['cloudcover'],
      solarradiation: json['solarradiation'],
      solarenergy: json['solarenergy'],
      uvindex: json['uvindex'],
      conditions: json['conditions'],
      icon: json['icon'],
      stations: (json['stations'] as List).cast<String>(),
      source: json['source'],
      sunrise: json['sunrise'],
      sunriseEpoch: json['sunriseEpoch'],
      sunset: json['sunset'],
      sunsetEpoch: json['sunsetEpoch'],
      moonphase: json['moonphase'],
    );
  }
}
