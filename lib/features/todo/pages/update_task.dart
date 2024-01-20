import 'package:not/common/modals/task_model.dart';
import 'package:not/common/utils/constants.dart';
import 'package:not/common/widgets/appstyle.dart';
import 'package:not/common/widgets/custom_otn_btn.dart';
import 'package:not/common/widgets/custom_textfeild.dart';
import 'package:not/common/widgets/hieght_space.dart';
import 'package:not/features/todo/controllers/dates/dates_provider.dart';
import 'package:not/features/todo/controllers/todo/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;

class UpdateTask extends ConsumerStatefulWidget {
  const UpdateTask({super.key, required this.id});
  final int id;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<UpdateTask> {
  final TextEditingController title = TextEditingController(text: titles);
  final TextEditingController desc = TextEditingController(text: descs);
  @override
  Widget build(BuildContext context) {
    var scheduleDate = ref.watch(dateStateProvider);
    var start = ref.watch(startTimeStateProvider);
    var end = ref.watch(finishTimeStateProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            const HieghtSpacer(hieght: 20),
            CustomTextFeild(
              hintText: "Add title",
              controller: title,
              hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            const HieghtSpacer(hieght: 20),
            CustomTextFeild(
              hintText: "Add description",
              controller: desc,
              hintStyle: appstyle(16, AppConst.kGreyLight, FontWeight.w600),
            ),
            const HieghtSpacer(hieght: 20),
            CustomOtlnBtn(
                onTap: () {
                  picker.DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2023, 7, 9),
                      maxTime: DateTime(2025, 6, 7),
                      theme: const picker.DatePickerTheme(
                          doneStyle:
                              TextStyle(color: AppConst.kGreen, fontSize: 16)),
                      onConfirm: (date) {
                    ref
                        .read(dateStateProvider.notifier)
                        .setDate(date.toString());
                  }, currentTime: DateTime.now(), locale: picker.LocaleType.en);
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kBlueLight,
                text: scheduleDate == ""
                    ? "Set Date"
                    : scheduleDate.substring(0, 10)),
            const HieghtSpacer(hieght: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOtlnBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        // print('confirm $date');
                        ref
                            .read(startTimeStateProvider.notifier)
                            .setStart(date.toString());
                      }, locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: start == "" ? "Start Time" : start.substring(10, 16)),
                CustomOtlnBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          showTitleActions: true, onConfirm: (date) {
                        // print('confirm $date');
                        ref
                            .read(finishTimeStateProvider.notifier)
                            .setFinish(date.toString());
                      }, locale: picker.LocaleType.en);
                    },
                    width: AppConst.kWidth * 0.4,
                    height: 52.h,
                    color: AppConst.kLight,
                    color2: AppConst.kBlueLight,
                    text: end == "" ? "Finish Time" : end.substring(10, 16)),
              ],
            ),
            const HieghtSpacer(hieght: 20),
            CustomOtlnBtn(
                onTap: () {
                  if (title.text.isNotEmpty &&
                      desc.text.isNotEmpty &&
                      scheduleDate.isNotEmpty &&
                      start.isNotEmpty &&
                      end.isNotEmpty) {
                    // ignore: unused_local_variable
                    Task task = Task(
                        title: title.text,
                        desc: desc.text,
                        isCompleted: 0,
                        date: scheduleDate,
                        startTime: start.substring(10, 16),
                        endTime: end.substring(10, 16),
                        remind: 0,
                        repeat: "yes");

                    ref.read(todoStateProvider.notifier).updateItem(
                        widget.id,
                        title.text,
                        desc.text,
                        0,
                        scheduleDate,
                        start.substring(10, 16),
                        end.substring(10, 16));
                    // ignore: avoid_single_cascade_in_expression_statements
                    ref..read(finishTimeStateProvider.notifier).setFinish('');
                    // ignore: avoid_single_cascade_in_expression_statements
                    ref..read(startTimeStateProvider.notifier).setStart('');
                    // ignore: avoid_single_cascade_in_expression_statements
                    ref..read(dateStateProvider.notifier).setDate('');
                    Navigator.pop(context);
                  } else {
                    print("faild to add task");
                  }
                },
                width: AppConst.kWidth,
                height: 52.h,
                color: AppConst.kLight,
                color2: AppConst.kGreen,
                text: "Submit"),
          ],
        ),
      ),
    );
  }
}
