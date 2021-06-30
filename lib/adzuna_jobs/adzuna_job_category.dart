import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AdzunaJobCategory {
  AdzunaJobCategory({this.jobCategoryLabel, this.jobCategoryTag});
  String jobCategoryLabel;
  String jobCategoryTag;

  factory AdzunaJobCategory.fromJson(Map<String, dynamic> json) =>
      _$AdzunaJobCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$AdzunaJobCategoryToJson(this);
}

AdzunaJobCategory _$AdzunaJobCategoryFromJson(Map<String, dynamic> json) =>
    AdzunaJobCategory(
        jobCategoryLabel: json['label'], jobCategoryTag: json['tag']);

Map<String, dynamic> _$AdzunaJobCategoryToJson(
        AdzunaJobCategory adzunaJobCategory) =>
    <String, dynamic>{
      'label': adzunaJobCategory.jobCategoryLabel,
      'tag': adzunaJobCategory.jobCategoryTag
    };
