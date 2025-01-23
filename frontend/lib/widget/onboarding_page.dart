import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String lottieAsset;
  final VoidCallback? onNext;

  const OnboardingPage({
    required this.title,
    required this.lottieAsset,
    this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 28, height: 1.5),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: size.height * 0.6,
          width: size.width,
          child: Stack(
            children: [
              Positioned(
                top: size.height * 0.2,
                left: size.width * 0.18,
                child: SvgPicture.asset(
                  "assets/onboardingUnion.svg",
                  height: 180,
                ),
              ),
              Positioned(
                top: size.height * 0.02, // 위치를 적절히 조정
                left: size.width * 0.15,
                child: Lottie.asset(
                  lottieAsset,
                  width: 300,
                  height: 300,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
