import 'package:dongbu_example/ui/route/tab/tab_order.dart';
import 'package:dongbu_example/ui/route/tab/tab_profile.dart';
import 'package:flutter/material.dart';
import '../../const/value/colors.dart';
import '../../const/value/text_style.dart';
import 'order/route_order_history_search.dart';

class RouteMain extends StatefulWidget {
  const RouteMain({super.key});

  @override
  State<RouteMain> createState() => _RouteMainState();
}

class _RouteMainState extends State<RouteMain> {
  final PageController pc = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _getAppBarTitle(_currentIndex),
          style: const TS.s18w600(colorGray900),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          // 조건에 따라 검색 아이콘 추가
          if (_currentIndex == 0) // 홈일 때만 버튼 활성화
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black), // 검색 아이콘
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RouteOrderHistorySearch(),
                  ),
                );
              },
            ),
        ],
      ),

      backgroundColor: colorWhite,
      body: SafeArea(
        child: PageView(
          controller: pc,
          physics: const NeverScrollableScrollPhysics(), // 슬라이드 비활성화
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index; // 인덱스 업데이트
            });
          },
          children: [TabOrder(), const TabProfile()],
        ),
      ),
      bottomNavigationBar: Row(
        children: List.generate(
          2,
              (index) => _buildNavItem(index),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          _onNavItemTapped(index);
        },
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                index == 0
                    ? 'assets/icons/home.png'
                    : 'assets/icons/person.png',
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                color: _currentIndex == index ? Colors.red : Colors.black,
              ),
              const SizedBox(height: 4),
              Text(
                index == 0 ? '홈' : '프로필',
                style: TextStyle(
                  color: _currentIndex == index ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNavItemTapped(int index) {
    if ((index - _currentIndex).abs() > 1) {
      pc.jumpToPage(index); // 멀리 있는 페이지는 점프
    } else {
      pc.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      ); // 인접한 페이지는 애니메이션 적용
    }
    setState(() {
      _currentIndex = index; // 인덱스 업데이트
    });
  }

  String _getAppBarTitle(int index) {
    return index == 0 ? '홈' : '프로필';
  }

  @override
  void dispose() {
    pc.dispose();
    super.dispose();
  }
}
