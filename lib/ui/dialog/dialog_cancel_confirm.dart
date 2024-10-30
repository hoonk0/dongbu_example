import 'package:flutter/material.dart';

import '../../const/value/colors.dart';
import '../../const/value/gaps.dart';
import '../../const/value/text_style.dart';
import '../component/custom_divider.dart';

class DialogCancelConfirm extends StatelessWidget {
  final String desc;
  final Function() onTap;

  const DialogCancelConfirm({
    super.key,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      // Transparent to only show the clipped content
      child: Container(
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Adjusts size to fit content
          children: [
            Gaps.v40,
            // 제목
            Text(
              desc,
              style: const TS.s16w500(colorGray900),
              textAlign: TextAlign.center,
            ),
            // 상단 회색 선
            Gaps.v40,

            const CustomDivider(
              color: colorPoint600,
            ),

            // 버튼 영역
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: const Text(
                        '취소',
                        textAlign: TextAlign.center,
                        style: TS.s16w600(colorPoint700),
                      ),
                    ),
                  ),
                ),
                Container(
                  color: colorPoint600, // 가로선을 위한 컨테이너
                  width: 1,
                  height: 55, // 적절한 높이 설정
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: const Text(
                        '확인',
                        textAlign: TextAlign.center,
                        style: TS.s16w600(colorGreen800),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
