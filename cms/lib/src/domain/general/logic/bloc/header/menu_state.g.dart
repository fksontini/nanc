// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MenuStateCWProxy {
  MenuState activeElement(MenuElement activeElement);

  MenuState activeHeaderSegment(String activeHeaderSegment);

  MenuState elements(List<MenuElement> elements);

  MenuState isLoading(bool isLoading);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuState(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuState call({
    MenuElement? activeElement,
    String? activeHeaderSegment,
    List<MenuElement>? elements,
    bool? isLoading,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMenuState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMenuState.copyWith.fieldName(...)`
class _$MenuStateCWProxyImpl implements _$MenuStateCWProxy {
  final MenuState _value;

  const _$MenuStateCWProxyImpl(this._value);

  @override
  MenuState activeElement(MenuElement activeElement) =>
      this(activeElement: activeElement);

  @override
  MenuState activeHeaderSegment(String activeHeaderSegment) =>
      this(activeHeaderSegment: activeHeaderSegment);

  @override
  MenuState elements(List<MenuElement> elements) => this(elements: elements);

  @override
  MenuState isLoading(bool isLoading) => this(isLoading: isLoading);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MenuState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MenuState(...).copyWith(id: 12, name: "My name")
  /// ````
  MenuState call({
    Object? activeElement = const $CopyWithPlaceholder(),
    Object? activeHeaderSegment = const $CopyWithPlaceholder(),
    Object? elements = const $CopyWithPlaceholder(),
    Object? isLoading = const $CopyWithPlaceholder(),
  }) {
    return MenuState(
      activeElement:
          activeElement == const $CopyWithPlaceholder() || activeElement == null
              ? _value.activeElement
              // ignore: cast_nullable_to_non_nullable
              : activeElement as MenuElement,
      activeHeaderSegment:
          activeHeaderSegment == const $CopyWithPlaceholder() ||
                  activeHeaderSegment == null
              ? _value.activeHeaderSegment
              // ignore: cast_nullable_to_non_nullable
              : activeHeaderSegment as String,
      elements: elements == const $CopyWithPlaceholder() || elements == null
          ? _value.elements
          // ignore: cast_nullable_to_non_nullable
          : elements as List<MenuElement>,
      isLoading: isLoading == const $CopyWithPlaceholder() || isLoading == null
          ? _value.isLoading
          // ignore: cast_nullable_to_non_nullable
          : isLoading as bool,
    );
  }
}

extension $MenuStateCopyWith on MenuState {
  /// Returns a callable class that can be used as follows: `instanceOfMenuState.copyWith(...)` or like so:`instanceOfMenuState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MenuStateCWProxy get copyWith => _$MenuStateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuState _$MenuStateFromJson(Map<String, dynamic> json) => MenuState(
      activeElement: MenuElement.fromJson(json['activeElement']),
      elements: (json['elements'] as List<dynamic>)
          .map((e) => MenuElement.fromJson(e))
          .toList(),
      isLoading: json['isLoading'] as bool,
      activeHeaderSegment: json['activeHeaderSegment'] as String,
    );

Map<String, dynamic> _$MenuStateToJson(MenuState instance) => <String, dynamic>{
      'activeElement': instance.activeElement.toJson(),
      'elements': instance.elements.map((e) => e.toJson()).toList(),
      'isLoading': instance.isLoading,
      'activeHeaderSegment': instance.activeHeaderSegment,
    };
