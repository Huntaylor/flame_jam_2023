import 'package:flame_jam_2023/utils/asset_constants.dart';
import 'package:flutter/material.dart';

class GameBackground extends StatelessWidget {
  const GameBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        AssetConstants.gameBackground,
        fit: BoxFit.cover,
      ),
    );
  }
}

class GrayBackground extends StatelessWidget {
  const GrayBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset(
        AssetConstants.grayBackground,
        fit: BoxFit.cover,
      ),
    );
  }
}
