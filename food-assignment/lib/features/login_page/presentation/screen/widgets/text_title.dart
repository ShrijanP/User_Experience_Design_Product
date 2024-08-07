import 'package:flutter/material.dart';

import '../../../../shared/constants/size_config.dart';
// import 'package:food_assignment/features/home_page/components/size_config.dart';

class TextTitle extends StatelessWidget {
  String title;
  TextTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title, style: TextStyle(color: Colors.white, fontSize: SizeConfig.screenHeight!/22.77, fontWeight: FontWeight.bold),),   /// 30
      alignment: Alignment.center,
    );
  }
}
