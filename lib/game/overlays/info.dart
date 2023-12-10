import 'package:flame_jam_2023/game/overlays/background.dart';
import 'package:flutter/material.dart';

class InfoView extends StatelessWidget {
  static PageRoute<void> route() {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => const InfoView(),
    );
  }

  const InfoView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(7, 28, 182, 1);
    const whiteTextColor = Color.fromRGBO(155, 197, 255, 1);

    return Scaffold(
      body: Stack(
        children: [
          const GameBackground(),
          Center(
            child: IntrinsicHeight(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: blackTextColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Jump and collect sfx were generated/provided\n by Jsfxr - https://sfxr.me/',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteTextColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Ice Cracking sound is a royalty-free sfx from\n Pixaby - pixabay.com, by GregorQuendel_SoundDesign',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteTextColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Land of 8 Bits is a royalty-free song by Stephen Bennett from\n https://www.fesliyanstudios.com/',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteTextColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'The Pixel Artwork was created by myself',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: whiteTextColor,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 20,
                            color: blackTextColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Expanded(
                      child: Text(
                        'HOW TO PLAY\n Tap to jump, or press the spacebar\nAvoid Hot enemies like the Sunrays or Magma blocks\nStay Cold by collecting snowflakes!\nYou can also jump on top of wooden boxes,\n but you might make them Cold.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteTextColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
