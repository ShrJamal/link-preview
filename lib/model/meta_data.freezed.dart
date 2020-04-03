// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'meta_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
LinkMetaData _$LinkMetaDataFromJson(Map<String, dynamic> json) {
  return _LinkMetaData.fromJson(json);
}

class _$LinkMetaDataTearOff {
  const _$LinkMetaDataTearOff();

  _LinkMetaData call(
      {@JsonKey(defaultValue: '') String title,
      @JsonKey(defaultValue: '') String description,
      @JsonKey(defaultValue: '') String image}) {
    return _LinkMetaData(
      title: title,
      description: description,
      image: image,
    );
  }
}

// ignore: unused_element
const $LinkMetaData = _$LinkMetaDataTearOff();

mixin _$LinkMetaData {
  @JsonKey(defaultValue: '')
  String get title;
  @JsonKey(defaultValue: '')
  String get description;
  @JsonKey(defaultValue: '')
  String get image;

  Map<String, dynamic> toJson();
  $LinkMetaDataCopyWith<LinkMetaData> get copyWith;
}

abstract class $LinkMetaDataCopyWith<$Res> {
  factory $LinkMetaDataCopyWith(
          LinkMetaData value, $Res Function(LinkMetaData) then) =
      _$LinkMetaDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(defaultValue: '') String title,
      @JsonKey(defaultValue: '') String description,
      @JsonKey(defaultValue: '') String image});
}

class _$LinkMetaDataCopyWithImpl<$Res> implements $LinkMetaDataCopyWith<$Res> {
  _$LinkMetaDataCopyWithImpl(this._value, this._then);

  final LinkMetaData _value;
  // ignore: unused_field
  final $Res Function(LinkMetaData) _then;

  @override
  $Res call({
    Object title = freezed,
    Object description = freezed,
    Object image = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      image: image == freezed ? _value.image : image as String,
    ));
  }
}

abstract class _$LinkMetaDataCopyWith<$Res>
    implements $LinkMetaDataCopyWith<$Res> {
  factory _$LinkMetaDataCopyWith(
          _LinkMetaData value, $Res Function(_LinkMetaData) then) =
      __$LinkMetaDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(defaultValue: '') String title,
      @JsonKey(defaultValue: '') String description,
      @JsonKey(defaultValue: '') String image});
}

class __$LinkMetaDataCopyWithImpl<$Res> extends _$LinkMetaDataCopyWithImpl<$Res>
    implements _$LinkMetaDataCopyWith<$Res> {
  __$LinkMetaDataCopyWithImpl(
      _LinkMetaData _value, $Res Function(_LinkMetaData) _then)
      : super(_value, (v) => _then(v as _LinkMetaData));

  @override
  _LinkMetaData get _value => super._value as _LinkMetaData;

  @override
  $Res call({
    Object title = freezed,
    Object description = freezed,
    Object image = freezed,
  }) {
    return _then(_LinkMetaData(
      title: title == freezed ? _value.title : title as String,
      description:
          description == freezed ? _value.description : description as String,
      image: image == freezed ? _value.image : image as String,
    ));
  }
}

@JsonSerializable()
class _$_LinkMetaData implements _LinkMetaData {
  const _$_LinkMetaData(
      {@JsonKey(defaultValue: '') this.title,
      @JsonKey(defaultValue: '') this.description,
      @JsonKey(defaultValue: '') this.image});

  factory _$_LinkMetaData.fromJson(Map<String, dynamic> json) =>
      _$_$_LinkMetaDataFromJson(json);

  @override
  @JsonKey(defaultValue: '')
  final String title;
  @override
  @JsonKey(defaultValue: '')
  final String description;
  @override
  @JsonKey(defaultValue: '')
  final String image;

  @override
  String toString() {
    return 'LinkMetaData(title: $title, description: $description, image: $image)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LinkMetaData &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.image, image) ||
                const DeepCollectionEquality().equals(other.image, image)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(image);

  @override
  _$LinkMetaDataCopyWith<_LinkMetaData> get copyWith =>
      __$LinkMetaDataCopyWithImpl<_LinkMetaData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LinkMetaDataToJson(this);
  }
}

abstract class _LinkMetaData implements LinkMetaData {
  const factory _LinkMetaData(
      {@JsonKey(defaultValue: '') String title,
      @JsonKey(defaultValue: '') String description,
      @JsonKey(defaultValue: '') String image}) = _$_LinkMetaData;

  factory _LinkMetaData.fromJson(Map<String, dynamic> json) =
      _$_LinkMetaData.fromJson;

  @override
  @JsonKey(defaultValue: '')
  String get title;
  @override
  @JsonKey(defaultValue: '')
  String get description;
  @override
  @JsonKey(defaultValue: '')
  String get image;
  @override
  _$LinkMetaDataCopyWith<_LinkMetaData> get copyWith;
}
