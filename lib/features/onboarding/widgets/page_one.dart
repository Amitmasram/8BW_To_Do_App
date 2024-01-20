import 'package:not/common/utils/constants.dart';
import 'package:not/common/widgets/appstyle.dart';
import 'package:not/common/widgets/hieght_space.dart';
import 'package:not/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConst.kHieght,
      width: AppConst.kWidth,
      color: AppConst.kBkDark,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            //  child: Image.asset("assets/images/"),
            child: Image.asset('assets/images/front.jpg'),
          ),
          const HieghtSpacer(hieght: 60),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ReusableText(
                  text: "ToDo with Change",
                  style: appstyle(30, AppConst.kLight, FontWeight.w600)),
              const HieghtSpacer(hieght: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Text(
                  "Welcome!! Do you want to create a task fast and easy",
                  textAlign: TextAlign.center,
                  style: appstyle(16, AppConst.kGreyLight, FontWeight.normal),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
