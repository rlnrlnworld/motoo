import 'package:flutter/material.dart';
import 'package:motoo/data/terms_content.dart';
import 'package:motoo/page/termsDetail_screen.dart';
import '../models/terms_model.dart';

class TermsList extends StatelessWidget {
  final List<TermsModel> terms;
  final Function(int, bool) onChanged;
  final VoidCallback onAllChecked;

  const TermsList({
    Key? key,
    required this.terms,
    required this.onChanged,
    required this.onAllChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
          decoration: BoxDecoration(
            color: Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => onAllChecked(),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: terms.every((t) => t.isChecked)
                      ? Color(0xffEC3910)
                      : Colors.white,
                  child: Icon(
                    Icons.check,
                    size: 16,
                    color: terms.every((t) => t.isChecked)
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "전체 동의하기",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Divider(),
        for (int i = 0; i < terms.length; i++)
          _buildAgreementRow(
            context,
            title: terms[i].title,
            isRequired: terms[i].isRequired,
            value: terms[i].isChecked,
            onChanged: (value) => onChanged(i, value),
            onTap: () => _navigateToDetail(context, terms[i].title),
          ),
      ],
    );
  }

  Widget _buildAgreementRow(
    BuildContext context, {
    required String title,
    required bool isRequired,
    required bool value,
    required Function(bool) onChanged,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => onChanged(!value),
              child: Icon(
                Icons.check,
                size: 22,
                color: value ? Color(0xffEC3910) : Colors.grey,
              ),
            ),
            SizedBox(width: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: isRequired ? "필수 " : "선택 ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isRequired ? Color(0xffEC3910) : Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String title) {
    final content = termsContent[title] ?? "약관 내용을 불러올 수 없습니다.";
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TermsDetailScreen(
          title: title,
          content: content,
        ),
      ),
    );
  }
}
