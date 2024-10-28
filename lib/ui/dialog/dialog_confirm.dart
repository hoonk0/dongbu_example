import 'package:flutter/material.dart';

import '../../const/value/colors.dart';
import '../../const/value/gaps.dart';
import '../../const/value/text_style.dart';
import '../component/custom_divider.dart';

class DialogConfirm extends StatelessWidget {
  final String desc;
  final EdgeInsets insetPadding;

  const DialogConfirm({
    required this.desc,
    this.insetPadding = const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: insetPadding,
      backgroundColor: colorWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: colorWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Gaps.v42,
            Text(
              desc,
              style: const TS.s16w500(colorGray900),
              textAlign: TextAlign.center,
            ),
            Gaps.v42,
            const CustomDivider(
              color: colorGray300,
              height: 1,
            ),
            _Button(
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final void Function()? onTap;

  const _Button({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: const Center(
          child: Text(
            'OK',
            style: TS.s18w600(colorPurple500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
