import 'package:flutter/foundation.dart';
import 'package:not/common/utils/constants.dart';
import 'package:not/common/widgets/appstyle.dart';
import 'package:not/common/widgets/custom_otn_btn.dart';
import 'package:not/common/widgets/custom_textfeild.dart';
import 'package:not/common/widgets/hieght_space.dart';
import 'package:not/common/widgets/reusable_text.dart';
import 'package:not/common/widgets/showDilog.dart';
import 'package:not/features/auth/controllers/auth_controller.dart';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController phone = TextEditingController();
  Country country = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "IND",
    example: "IND",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
  );

  sendCodeToUser() {
    if (phone.text.isEmpty) {
      return showAlertDialog(
          context: context, message: "Please enter your phone number");
    } else if (phone.text.length < 8) {
      return showAlertDialog(
          context: context, message: "Your number is to short");
    } else {
      if (kDebugMode) {
        print('+${country.phoneCode}${phone.text}');
      }
      ref.read(authControllerProvider).sendSms(
          context: context, phone: '+${country.phoneCode}${phone.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Image.asset(
                  'assets/images/front.jpg',
                  width: 300,
                ),
              ),
              const HieghtSpacer(hieght: 1),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 40.w),
                child: ReusableText(
                  text: "Please enter your phone number",
                  style: appstyle(17, AppConst.kLight, FontWeight.w500),
                ),
              ),
              const HieghtSpacer(hieght: 20),
              Center(
                child: CustomTextFeild(
                  controller: phone,
                  prefixIcon: Container(
                    padding: const EdgeInsets.all(14),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                                backgroundColor: AppConst.kGreyLight,
                                bottomSheetHeight: AppConst.kHieght * 0.6,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(AppConst.kRadius),
                                    topRight:
                                        Radius.circular(AppConst.kRadius))),
                            onSelect: (code) {
                              setState(() {
                                country = code;
                              });
                              // ref
                              //     .read(codeStateProvider.notifier)
                              //     .setStart(code.phoneCode);
                            });
                        // print(ref.read(codeStateProvider)
                        // );
                      },
                      child: ReusableText(
                          text: "${country.flagEmoji} + ${country.phoneCode}",
                          style:
                              appstyle(18, AppConst.kBkDark, FontWeight.bold)),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  hintText: "Enter phone number",
                  hintStyle: appstyle(16, AppConst.kBkDark, FontWeight.w600),
                ),
              ),
              const HieghtSpacer(hieght: 20),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CustomOtlnBtn(
                    onTap: () {
                      sendCodeToUser();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OtpPage(
                      //               smsCodeId: '',
                      //               phone: phone.text,
                      //             )));
                    },
                    width: AppConst.kWidth * 0.9,
                    height: AppConst.kHieght * 0.07,
                    color: AppConst.kBkDark,
                    color2: AppConst.kLight,
                    text: "Send Code"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
