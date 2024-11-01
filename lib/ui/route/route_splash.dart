import 'package:dongbu_example/ui/route/route_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/static/global.dart';
import '../../const/value/colors.dart';
import '../../service/stream/stream_me.dart';
import 'auth/route_auth_login.dart';

class RouteSplash extends ConsumerStatefulWidget {
  const RouteSplash({super.key});

  @override
  ConsumerState<RouteSplash> createState() => _RouteSplashState();
}

class _RouteSplashState extends ConsumerState<RouteSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserAndInitData();
  }


  Future<void> checkUserAndInitData() async {
    final pref = await SharedPreferences.getInstance();
    final uid = pref.getString('uid');

    try {
      Global.uid = uid;

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) async {
          /// FirebaseAuth에 등록되어 있지 않음: 아무것도 안함
          if (uid == null) {
            debugPrint('uid null');
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RouteAuthLogin()));
          }

          /// FirebaseAuth에 등록되어 있음
          else {
            debugPrint('uid login');
            StreamMe.listenMe(ref);
            await Future.delayed(Duration(milliseconds: 100));
            WidgetsBinding.instance.endOfFrame.then((value) async {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RouteMain(), settings: const RouteSettings(name: 'home')));
            });
          }
        },
      );
    } catch (e) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RouteAuthLogin()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Global.contextSplash = context;
    return Scaffold(
      backgroundColor: colorWhite,
      body: Center(
        child: Text('splash'),
      ),
    );
  }
}
