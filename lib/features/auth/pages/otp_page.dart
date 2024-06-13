import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:not/common/utils/constants.dart';
import 'package:not/common/widgets/appstyle.dart';
import 'package:not/common/widgets/hieght_space.dart';
import 'package:not/common/widgets/reusable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:not/features/auth/controllers/auth_controller.dart';
import 'package:pinput/pinput.dart';

class OtpPage extends ConsumerWidget {
  const OtpPage({super.key, required this.smsCodeId, required this.phone});

  final String smsCodeId;
  final String phone;

  void verifyOtpCode(BuildContext context, WidgetRef ref, String smsCode) {
    ref.read(authControllerProvider).verifyOtpCode(
        context: context,
        smsCodeId: smsCodeId,
        smsCode: smsCode,
        mounted: true);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                HieghtSpacer(hieght: AppConst.kHieght * 0.12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Image.network(
                    "http://www.pngall.com/wp-content/uploads/5/Vector-Checklist-PNG-Free-Download.png",
                    width: AppConst.kWidth * 0.5,
                  ),
                ),
                const HieghtSpacer(hieght: 20),
                ReusableText(
                    text: "Enter your otp code",
                    style: appstyle(18, AppConst.kLight, FontWeight.bold)),
                const HieghtSpacer(hieght: 20),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Pinput(
                    length: 6,
                    showCursor: true,
                    onCompleted: (value) {
                      if (value.length == 6) {
                        return verifyOtpCode(context, ref, value);
                      }
                    },
                    onSubmitted: (value) {
                      if (value.length == 6) {
                        return verifyOtpCode(context, ref, value);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
