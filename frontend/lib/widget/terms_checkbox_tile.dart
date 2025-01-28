import 'package:flutter/material.dart';

class TermsCheckboxTile extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool) onChanged;
  final bool isRequired;
  final VoidCallback? onTap;

  const TermsCheckboxTile({
    Key? key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap, // 약관 상세 페이지 이동
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (bool? newValue) => onChanged(newValue ?? false),
              activeColor: Color(0xffEC3910),
            ),
            Expanded(
              child: Text(
                "${isRequired ? "필수" : "선택"} $title",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: isRequired ? Color(0xffEC3910) : Colors.black,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}