class TermsModel {
  final String title;
  bool isChecked;
  final bool isRequired;

  TermsModel({
    required this.title,
    this.isChecked = false,
    required this.isRequired,
  });
}

List<TermsModel> termsData = [
  TermsModel(title: "이용약관 동의", isRequired: true),
  TermsModel(title: "개인신용정보 수집, 이용 동의", isRequired: true),
  TermsModel(title: "만 14세 이상입니다", isRequired: true),
  TermsModel(title: "홍보 및 마케팅 수집, 이용 동의", isRequired: false),
];