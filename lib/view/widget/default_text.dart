import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DefaultText extends StatelessWidget {
  String date;
  double? font;
  FontWeight? fontWeight;
  DefaultText({super.key, required this.date, this.fontWeight, this.font});

  @override
  Widget build(BuildContext context) {
    return Text(
      date,
      style: TextStyle(
        fontSize: font ?? 20.sp,
        fontWeight: fontWeight,
        color: Colors.black,
      ),
    );
  }
}
