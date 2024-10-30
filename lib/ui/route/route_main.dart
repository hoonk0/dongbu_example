//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dongbu_example/ui/route/tab/tab_book.dart';
import 'package:dongbu_example/ui/route/tab/tab_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../const/value/colors.dart';
import '../../const/value/text_style.dart';

class RouteMain extends StatefulWidget {
  const RouteMain({super.key});

  @override
  State<RouteMain> createState() => _RouteMainState();
}

class _RouteMainState extends State<RouteMain> {
  final pc = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return '홈';
      case 1:
        return '프로필';
      default:
        return '홈';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(_currentIndex), style: const TS.s18w600(colorGray900)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: colorWhite,
      body: SafeArea(
        child: PageView(
          controller: pc,
          //physics: const NeverScrollableScrollPhysics(),
          children: [const TabBook(), TabProfile()],

          onPageChanged: (value) {
            setState(() {
              _currentIndex = value; // 페이지 변경 시 현재 인덱스 업데이트
            });
          },
        ),
      ),
      bottomNavigationBar: Row(
        children: List.generate(
          2,
              (index) => Expanded(
            child: GestureDetector(
              onTap: () {
                final currentPageIndex = pc.page;
                if ((index - currentPageIndex!).abs() > 1) {
                  pc.jumpToPage(index);
                } else {
                  pc.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                }
              },
              child: Container(
                color: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AnimatedBuilder(
                  animation: pc,
                  builder: (context, child) {
                    final pageIndex = pc.page ?? 0;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          index == 0
                              ? 'assets/icons/home.png'
                              : 'assets/icons/person.png',
                          width: 28, // 이미지 너비 (옵션)
                          height: 28, // 이미지 높이 (옵션)
                          fit: BoxFit.cover,
                        ),
                      ],
                    );

                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
