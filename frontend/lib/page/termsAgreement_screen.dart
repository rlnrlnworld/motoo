import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:motoo/page/help_screen.dart';
import 'package:motoo/widget/terms_list.dart';
import 'package:motoo/models/terms_model.dart';

class TermsAgreementScreen extends StatefulWidget {
  @override
  State<TermsAgreementScreen> createState() => _TermsAgreementScreenState();
}

class _TermsAgreementScreenState extends State<TermsAgreementScreen>
    with SingleTickerProviderStateMixin {
  double textWidth = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _calculateTextWidth();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _animation = Tween<double>(begin: 0, end: textWidth).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _calculateTextWidth() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: "안녕하세요.",
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    setState(() {
      textWidth = textPainter.width + 3;
    });
  }

  void _toggleAgreement(int index, bool value) {
    setState(() {
      termsData[index].isChecked = value;
    });
  }

  void _toggleAllAgreements() {
    setState(() {
      bool newValue = !termsData.every((t) => t.isChecked);
      for (var term in termsData) {
        term.isChecked = newValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bool isButtonEnabled = termsData
        .where((term) => term.isRequired)
        .every((term) => term.isChecked);

    return Scaffold(
      backgroundColor: Color(0xffF2f2f2),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: size.height * 0.15),
          Align(
            alignment: Alignment(-0.6, 0.0),
            child: SvgPicture.asset(
              "assets/term-icon.svg",
              width: size.width * 0.5,
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                  left: size.width * 0.1,
                  top: size.height * 0.07,
                  right: size.width * 0.1),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        bottom: 7,
                        child: AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Container(
                              width:
                                  _animation.value,
                              height: 6,
                              color: Color(0xffFCB9AA),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Text(
                          "안녕하세요!",
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "서비스 이용을 위해 약관에 동의해주세요.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Expanded(child: SizedBox()),
                  Container(
                    margin: EdgeInsets.only(bottom: size.height * 0.1),
                    child: TermsList(
                      terms: termsData,
                      onChanged: _toggleAgreement,
                      onAllChecked: _toggleAllAgreements,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        child: ElevatedButton(
          onPressed: isButtonEnabled
              ? () {
                  // TODO: 약관 동의 정보 서버로 전달
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HelpScreen()),
                  );
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isButtonEnabled ? Color(0xffEC3910) : Colors.grey,
            minimumSize: Size(double.infinity, 100),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          child: Text(
            "동의하고 시작하기",
            style: TextStyle(fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
