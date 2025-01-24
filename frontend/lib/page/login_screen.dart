import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_naver_login/interface/types/naver_login_result.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:lottie/lottie.dart';
import 'package:motoo/widget/login_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<void> _loginWithNaver() async {
      try {
        final NaverLoginResult? result = await FlutterNaverLogin.logIn().timeout(
          Duration(seconds: 20),
          onTimeout: () => null as NaverLoginResult,
        );

        if (result == null) {
          print("네이버 로그인이 취소되었거나 응답이 없습니다.");
          return;
        }

        print("네이버 로그인 성공: ${result.accessToken}");

        //TODO: 액세스 토큰 백엔드로 전달 후 JWT를 로컬 저장소에 저장

        Navigator.pushReplacementNamed(context, '/terms');
      } catch (e) {
        print("네이버 로그인 실패: $e");
      }
    }
    Future<void> _loginWithKaKao() async {
      try {
        OAuthToken token;

        if (await isKakaoTalkInstalled()) {
          token = await UserApi.instance.loginWithKakaoTalk();
          print("카카오톡으로 로그인 성공: ${token.accessToken}");
        } else {
          token = await UserApi.instance.loginWithKakaoAccount();
          print("카카오 계정으로 로그인 성공: ${token.accessToken}");
        }

        //TODO: 액세스 토큰 백엔드로 전달 후 JWT를 로컬 저장소에 저장

        Navigator.pushReplacementNamed(context, '/terms');
      } catch (e) {
        print("카카오 로그인 실패: $e");
        if (e is PlatformException && e.code == 'CANCELED') {
          return;
        }
      }
    }
    Future<void> _loginWithApple() async {
      //TODO: 애플 개발자 계정 결제 이후, 메소드 작성
    }
    Future<void> _loginWithGoogle() async {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/userinfo.profile',
        ],
      );

      try {
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

        if (googleUser == null) {
          print('사용자가 로그인을 취소했습니다.');
          return;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        print('구글 로그인 성공: ${googleAuth.accessToken}');
        print('구글 ID 토큰: ${googleAuth.idToken}');

        // TODO: 액세스 토큰 또는 ID 토큰을 백엔드로 전달

        Navigator.pushReplacementNamed(context, '/terms');
      } catch (e) {
        print('구글 로그인 실패: $e');

        // TODO: 실패 시 사용자에게 알림 표시 또는 재시도 로직 추가
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.13,
          ),
          Container(
            margin: EdgeInsets.only(left: size.width * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Motoo",
                      style: GoogleFonts.alfaSlabOne(
                        textStyle: TextStyle(
                          inherit: false,
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      ".",
                      style: GoogleFonts.alfaSlabOne(
                        textStyle: TextStyle(
                          inherit: false,
                          fontSize: 48,
                          height: 1,
                          fontWeight: FontWeight.w400,
                          color: Color(0xffEC3910),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  "당신의 투자를 더 알기 쉽게!",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          SizedBox(
            width: size.width,
            height: 280,
            child: Stack(
              children: [
                Positioned(
                    left: size.width * 0.2,
                    top: 50,
                    child: Lottie.asset("assets/money.json",
                        width: 100, height: 100)),
                Positioned(
                    left: size.width * 0.4,
                    child: SvgPicture.asset(
                      "assets/motooLogo.svg",
                      width: 280,
                    ))
              ],
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "SNS 계정으로 간편 가입하기",
              style: TextStyle(color: Color(0xff696969), fontSize: 17),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginButton(
                  logoPath: "assets/kakao.svg",
                  backgroundColor: Color(0xffFDE500),
                  onPressed: _loginWithKaKao),
              LoginButton(
                  logoPath: "assets/naver.svg",
                  backgroundColor: Color(0xff03c75a),
                  onPressed: _loginWithNaver),
              LoginButton(
                  logoPath: "assets/apple.svg",
                  backgroundColor: Color(0xff000000),
                  onPressed: _loginWithApple),
              LoginButton(
                logoPath: "assets/google.svg",
                backgroundColor: Color(0xffF1F1F1),
                onPressed: _loginWithGoogle,
              )
            ],
          )
        ],
      ),
    );
  }
}
