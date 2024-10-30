import 'package:dongbu_example/ui/component/basic_button.dart';
import 'package:flutter/material.dart';

import '../../const/value/colors.dart';
import '../../const/value/gaps.dart';
import '../../const/value/text_style.dart';
import '../component/custom_checkbox_container.dart';

class BottomSheetListFilter extends StatelessWidget {
  final ValueNotifier<String> vnSelectedFilterList;

  const BottomSheetListFilter({
    super.key,
    required this.vnSelectedFilterList,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> vnFilterTemp = ValueNotifier(vnSelectedFilterList.value);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Gaps.v14,
          // 상단의 작은 막대
          Container(
            width: 44,
            height: 4,
            margin: const EdgeInsets.only(top: 12.0),
            decoration: BoxDecoration(
              color: colorGray300,
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          Gaps.v16,
          Text('필터', style: TS.s18w600(const Color(0xff222222))),
          Gaps.v20,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                ValueListenableBuilder<String>(
                  valueListenable: vnFilterTemp,
                  builder: (context, selectedFilter, child) {
                    return Column(
                      children: [
                        CustomCheckboxContainer(
                          title: '최신순',
                          isSelected: selectedFilter == '최신순',
                          onTap: () {
                            vnFilterTemp.value = '최신순';
                          },
                        ),
                        Gaps.v10,
                        CustomCheckboxContainer(
                          title: '오래된 순',
                          isSelected: selectedFilter == '오래된 순',
                          onTap: () {
                            vnFilterTemp.value = '오래된 순';
                          },
                        ),
                      ],
                    );
                  },
                ),
                Gaps.v16,
                Row(
                  children: [
                    Expanded(
                        child: BasicButton(
                            title: '취소',
                            titleColorBg: colorGreen800,
                            colorBg: colorWhite,
                            onTap: () {
                              Navigator.of(context).pop();
                            })),
                    Gaps.h16,
                    Expanded(
                        child: BasicButton(
                            title: '확인',
                            titleColorBg: colorWhite,
                            colorBg: colorGreen800,
                            onTap: () {
                              vnSelectedFilterList.value = vnFilterTemp.value;
                              Navigator.of(context).pop();
                            }))
                  ],
                ),
                Gaps.v16
              ],
            ),
          ),
          Gaps.v30,
        ],
      ),
    );
  }
}
