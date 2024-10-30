import 'package:dongbu_example/ui/component/basic_button.dart';
import 'package:flutter/material.dart';

import '../../../const/value/colors.dart';
import '../../../const/value/gaps.dart';
import '../../../const/value/text_style.dart';
import '../../../service/utils/utils.dart';
import '../../component/textfield_border.dart';
import '../../dialog/dialog_confirm.dart';

class RouteAuthChangePw extends StatefulWidget {
  const RouteAuthChangePw({super.key});

  @override
  State<RouteAuthChangePw> createState() => _RouteAuthChangePwState();
}

class _RouteAuthChangePwState extends State<RouteAuthChangePw> {
  final TextEditingController tecPw = TextEditingController();
  final TextEditingController tecPwConfirm = TextEditingController();
  final TextEditingController tecCurrentPw = TextEditingController();
  final ValueNotifier<bool> vnIsAllComplete = ValueNotifier<bool>(true);

  void checkAllComplete() {
    final condition1 = tecPw.text.isNotEmpty;
    final condition2 = Utils.regExpPw.hasMatch(tecPw.text);
    final condition3 = tecPw.text == tecPwConfirm.text;
    vnIsAllComplete.value = condition1 && condition2 && condition3;
  }

  @override
  void dispose() {
    tecPw.dispose();
    tecPwConfirm.dispose();
    tecCurrentPw.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('비밀번호 변경'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gaps.v36,

                        /// New Password
                        const Text(
                          '변경할 비밀번호',
                          style: TS.s14w500(colorGray900),
                        ),
                        Gaps.v10,
                        ValueListenableBuilder(
                          valueListenable: tecPw,
                          builder: (context, isCheck, child) {
                            return TextFieldBorder(
                              obscureText: true,
                              onChanged: (value) {
                                checkAllComplete();
                              },
                              errorText: (tecPw.text.isEmpty || Utils.regExpPw.hasMatch(tecPw.text))
                                  ? null
                                  : '6글자 이상 입력하세요.',
                              controller: tecPw,
                              hintText: '비밀번호 입력',
                            );
                          },
                        ),
                        Gaps.v10,
                        ValueListenableBuilder(
                          valueListenable: tecPwConfirm,
                          builder: (context, isCheck, child) {
                            return TextFieldBorder(
                              obscureText: true,
                              onChanged: (value) {
                                checkAllComplete();
                              },
                              controller: tecPwConfirm,
                              hintText: '비밀번호 확인',
                              errorText: (tecPwConfirm.text.isEmpty || tecPw.text == tecPwConfirm.text)
                                  ? null
                                  : '비밀번호가 일치하지 않습니다.',
                            );
                          },
                        ),
                        Gaps.v10,
                      ],
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: vnIsAllComplete,
                  builder: (context, isAllComplete, child) {
                    return BasicButton(
                      title: '비밀번호 변경',
                      colorBg: isAllComplete ? colorGreen800 : colorPoint700,
                      onTap: isAllComplete ? _changePw : null,
                    );
                  },
                ),
                Gaps.v10,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Find Password
  Future<void> _changePw() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (tecPw.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const DialogConfirm(
          desc: '비밀번호를 입력하세요.',
        ),
      );
      return;
    }

    if (!Utils.regExpPw.hasMatch(tecPw.text)) {
      showDialog(
        context: context,
        builder: (context) => const DialogConfirm(
          desc: '유효하지 않은 비밀번호 입니다.',
        ),
      );
      return;
    }

    if (tecPwConfirm.text.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const DialogConfirm(
          desc: '비밀번호 확인을 입력해주세요.',
        ),
      );
      return;
    }

    if (tecPw.text != tecPwConfirm.text) {
      showDialog(
        context: context,
        builder: (context) => const DialogConfirm(
          desc: '비밀번호가 일치하지 않습니다.',
        ),
      );
      return;
    }

    // await FirebaseFirestore.instance.collection(keyUser).doc(Global.userNotifier.value!.uid).update({'pw': tecPw.text});
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Utils.toast(desc: '비밀번호가 변경되었습니다.');

  }
}
