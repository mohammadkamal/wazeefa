import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AdzunaJobLocation {
  String displayName;
  List<dynamic> area;
  AdzunaJobLocation({this.displayName, this.area});

  factory AdzunaJobLocation.fromJson(Map<String, dynamic> json) =>
      _$AdzunaJobLocationFromJson(json);
  Map<String, dynamic> toJson() => _$AdzunaJobLocationToJson(this);
}

AdzunaJobLocation _$AdzunaJobLocationFromJson(Map<String, dynamic> json) =>
    AdzunaJobLocation(displayName: json['display_name'], area: json['area']
    );

Map<String, dynamic> _$AdzunaJobLocationToJson(
        AdzunaJobLocation adzunaJobLocation) =>
    <String, dynamic>{
      'display_name': adzunaJobLocation.displayName,
      'area': adzunaJobLocation.area
    };
