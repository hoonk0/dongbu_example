
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongbu_example/const/value/keys.dart';
import 'package:dongbu_example/ui/route/auth/route_auth_change_pw.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/static/global.dart';
import '../../../const/value/colors.dart';
import '../../../const/value/gaps.dart';
import '../../../const/value/text_style.dart';
import '../../../service/utils/utils.dart';
import '../../component/custom_container_profile_list.dart';
import '../../component/custom_divider.dart';
import '../../dialog/dialog_cancel_confirm.dart';
import '../route_splash.dart';


class TabProfile extends StatelessWidget {
  const TabProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v16,
              ValueListenableBuilder(
                valueListenable: Global.userNotifier,
                builder: (context, userMe, child) {
                  // Null 체크 처리
                  if (userMe == null) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '로그인 정보 불러오기 실패',
                            style: TS.s16w600(colorGray900),
                          ),
                        ],
                      ),
                    );
                  }

                  // 정상적인 데이터가 있을 때
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${userMe.email}님',
                          style: const TS.s16w600(colorGray900),
                        ),
                        Text(
                          userMe.nickname,
                          style: const TS.s16w500(colorPoint800),
                        ),
                      ],
                    ),
                  );
                },
              ),

              Gaps.v20,
              const CustomDivider(
                color: Color(0xffe7eaf0),
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    CustomContainerProfileList(
                        title: '비밀번호 변경',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RouteAuthChangePw()));
                        }),

                    CustomContainerProfileList(
                      title: '로그아웃',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DialogCancelConfirm(
                            desc: '로그아웃을 하시겠습니까?',
                            onTap: () async {
                              final pref = await SharedPreferences.getInstance();
                              pref.remove(keyUid);
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RouteSplash()), (route) => false);

                              Utils.toast(
                                desc: '로그아웃 되었습니다.',
                              );
                            },
                          ),
                        );
                      },
                    ),
                    CustomContainerProfileList(
                      title: '회원탈퇴',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => DialogCancelConfirm(
                            desc: '회원탈퇴를 하시겠습니까?',
                            onTap: () async {
                              FirebaseFirestore.instance
                                  .collection(keyUser)
                                  .doc(Global.userNotifier.value!.uid)
                                  .delete();

                              final pref = await SharedPreferences.getInstance();
                              pref.remove(keyUid);
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const RouteSplash()), (route) => false);

                              Utils.toast(
                                desc: '회원가입이 탈퇴되었습니다.',
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
