/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesCharacterGen get character => const $AssetsImagesCharacterGen();
  $AssetsImagesTerrainGen get terrain => const $AssetsImagesTerrainGen();
}

class $AssetsTiledGen {
  const $AssetsTiledGen();

  /// File path: assets/tiled/Chilling Escape.tsx
  String get chillingEscape => 'assets/tiled/Chilling Escape.tsx';

  /// File path: assets/tiled/endless_1.tmx
  String get endless1 => 'assets/tiled/endless_1.tmx';

  /// File path: assets/tiled/hot_and_cold.tiled-project
  String get hotAndColdTiledProject =>
      'assets/tiled/hot_and_cold.tiled-project';

  /// File path: assets/tiled/hot_and_cold.tiled-session
  String get hotAndColdTiledSession =>
      'assets/tiled/hot_and_cold.tiled-session';

  /// List of all assets
  List<String> get values => [
        chillingEscape,
        endless1,
        hotAndColdTiledProject,
        hotAndColdTiledSession
      ];
}

class $AssetsImagesCharacterGen {
  const $AssetsImagesCharacterGen();

  /// File path: assets/images/Character/ice_cube.aseprite
  String get iceCube => 'assets/images/Character/ice_cube.aseprite';

  /// List of all assets
  List<String> get values => [iceCube];
}

class $AssetsImagesTerrainGen {
  const $AssetsImagesTerrainGen();

  /// File path: assets/images/Terrain/Terrain.png
  AssetGenImage get terrain =>
      const AssetGenImage('assets/images/Terrain/Terrain.png');

  /// List of all assets
  List<AssetGenImage> get values => [terrain];
}

class Assets {
  Assets._();

  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTiledGen tiled = $AssetsTiledGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
