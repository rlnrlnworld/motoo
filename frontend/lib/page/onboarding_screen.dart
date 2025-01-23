import 'package:motoo/widget/onboarding_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: size.height * 0.2),
          SizedBox(
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => buildIndicator(index)),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });

                if (index == 4) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              children: [
                OnboardingPage(
                  title: "자동으로 연결되는\n투자 계좌",
                  lottieAsset: "assets/bankCapital.json",
                ),
                OnboardingPage(
                  title: "한 눈에 보는\n뉴스 브리핑",
                  lottieAsset: "assets/pricingPlans.json",
                ),
                OnboardingPage(
                  title: "편하게 정리하는\n투자 인사이트",
                  lottieAsset: "assets/emailWriting.json",
                ),
                OnboardingPage(
                  title: "매주 받아보는\n투자 리포트",
                  lottieAsset: "assets/mailbox.json",
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 8,
      width: _currentPage == index ? 18 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Color(0xffec380f) : Color(0xffd9d9d9),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
