import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginButton extends StatelessWidget {
  final String logoPath;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const LoginButton({
    required this.logoPath,
    required this.backgroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 60,
        height: 60,
        decoration:
            BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
        child: Center(
          child: SvgPicture.asset(
            logoPath,
            width: 25,
            height: 25,
          ),
        ),
      ),
    );
  }
}
