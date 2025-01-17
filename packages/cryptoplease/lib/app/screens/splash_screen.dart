import 'package:cryptoplease/gen/assets.gen.dart';
import 'package:cryptoplease_ui/cryptoplease_ui.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => CpBackgroundGradient(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Assets.icons.logoBg.svg(alignment: Alignment.bottomCenter),
            ),
            Align(
              alignment: const Alignment(0, -0.7),
              child: Assets.images.logo.image(height: 195, width: 300),
            ),
          ],
        ),
      );
}
