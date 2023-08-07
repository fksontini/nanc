import 'package:flutter/material.dart';
import 'package:icons/icons.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tools/tools.dart';

part 'icon_arguments.g.dart';

@JsonSerializable()
class IconArguments {
  const IconArguments({
    required this.icon,
    required this.color,
    required this.size,
    required this.weight,
    required this.fill,
    required this.opticalSize,
  });

  factory IconArguments.fromJson(dynamic json) => _$IconArgumentsFromJson(castToJson(json));

  @JsonKey(fromJson: tryToGetIconByName, toJson: toNullJson)
  final IconData? icon;

  @JsonKey(fromJson: nullableColorFromJson, toJson: colorToJson)
  final Color? color;

  @JsonKey(fromJson: nullableDoubleFromJson)
  final double? size;

  @JsonKey(fromJson: nullableDoubleFromJson)
  final double? weight;

  @JsonKey(fromJson: nullableDoubleFromJson)
  final double? fill;

  @JsonKey(fromJson: nullableDoubleFromJson)
  final double? opticalSize;

  Json toJson() => _$IconArgumentsToJson(this);
}
