// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_arguments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IconArguments _$IconArgumentsFromJson(Map<String, dynamic> json) =>
    IconArguments(
      icon: tryToGetIconByName(json['icon'] as String?),
      color: nullableColorFromJson(json['color'] as String?),
      size: nullableDoubleFromJson(json['size'] as String?),
    );

Map<String, dynamic> _$IconArgumentsToJson(IconArguments instance) =>
    <String, dynamic>{
      'icon': toNullJson(instance.icon),
      'color': colorToJson(instance.color),
      'size': instance.size,
    };
