import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AdzunaJobCompany {
  AdzunaJobCompany({this.companyDisplayName});
  String companyDisplayName;

  factory AdzunaJobCompany.fromJson(Map<String, dynamic> json) =>
      _$AdzunaJobCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$AdzunaJobCompanyToJson(this);
}

AdzunaJobCompany _$AdzunaJobCompanyFromJson(Map<String, dynamic> json) =>
    AdzunaJobCompany(companyDisplayName: json['display_name']);

Map<String, dynamic> _$AdzunaJobCompanyToJson(
        AdzunaJobCompany adzunaJobCompany) =>
    <String, dynamic>{'display_name': adzunaJobCompany.companyDisplayName};
