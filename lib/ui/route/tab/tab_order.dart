
import 'package:dongbu_example/const/value/colors.dart';
import 'package:dongbu_example/ui/bottom_sheet/bottom_sheet_list_filter.dart';
import 'package:dongbu_example/ui/route/order/route_order_make.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../const/enums/enums.dart';
import '../../../const/value/gaps.dart';

class TabOrder extends ConsumerStatefulWidget {
  final ValueNotifier<String> vnOrderByFilter = ValueNotifier<String>('최신순');
  final ValueNotifier<OrderStatus?> vnOrderStatusFilter = ValueNotifier(null);


  @override
  ConsumerState<TabOrder> createState() => _TabOrderState();
}

class _TabOrderState extends ConsumerState<TabOrder> {
  final ValueNotifier<String> vnOrderByFilter = ValueNotifier<String>('최신순');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(context: context, builder: (BuildContext context){
                  return BottomSheetListFilter(vnSelectedFilterList: vnOrderByFilter);
                });
              },
              child: ValueListenableBuilder(
                valueListenable: vnOrderByFilter,
                builder: (context, selectedFilter, child){
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                          color: colorGreen900
                      ),
                    ),
                    child: Row(children: [
                      Text(selectedFilter),
                      Gaps.h2,
                      Image.asset(
                        'assets/icons/arrow_down.png',
                        width: 20,
                        height: 20,
                        color: colorBlack,
                        fit: BoxFit.cover,
                      ),

                      ElevatedButton(onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => RouteOrderMake()));
                      }, child: Text("주문하러 가기"))
                    ],
                    ),
                  );
                },
              ),
            )
          ],
        )
      ],),
    );
  }
}