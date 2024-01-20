import 'package:not/common/helpers/notification_helper.dart';
import 'package:not/common/utils/constants.dart';
import 'package:not/common/widgets/appstyle.dart';
import 'package:not/common/widgets/custom_textfeild.dart';

import 'package:not/common/widgets/reusable_text.dart';
import 'package:not/features/todo/controllers/todo/todo_provider.dart';

import 'package:not/features/todo/pages/add.dart';
import 'package:not/features/todo/widgets/completed_task.dart';
import 'package:not/features/todo/widgets/dayafter_tomorrow.dart';
import 'package:not/features/todo/widgets/today_task.dart';

import 'package:not/features/todo/widgets/tomorrow_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/widgets/hieght_space.dart';
import '../../../common/widgets/width_space.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with TickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 2, vsync: this);
  late NotificationHelper notifireHelper;
  late NotificationHelper controller;
  final TextEditingController search = TextEditingController();
  @override
  void initState() {
    notifireHelper = NotificationHelper(ref: ref);
    Future.delayed(Duration(seconds: 0), () {
      controller = NotificationHelper(ref: ref);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(todoStateProvider.notifier).refresh();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReusableText(
                          text: "Dashboard",
                          style:
                              appstyle(18, AppConst.kLight, FontWeight.bold)),
                      Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: const BoxDecoration(
                          color: AppConst.kLight,
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AddTask()));
                          },
                          child: const Icon(
                            Icons.add,
                            color: AppConst.kBkDark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const HieghtSpacer(hieght: 20),
                CustomTextFeild(
                  hintText: "Search",
                  controller: search,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12.h),
                    child: GestureDetector(
                      onTap: null,
                      child: const Icon(
                        AntDesign.search1,
                        color: AppConst.kGreyLight,
                      ),
                    ),
                  ),
                  suffixIcon: const Icon(
                    FontAwesome.sliders,
                    color: AppConst.kGreyLight,
                  ),
                ),
                const HieghtSpacer(hieght: 15)
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: [
                const HieghtSpacer(hieght: 25),
                Row(
                  children: [
                    const Icon(
                      FontAwesome.tasks,
                      size: 20,
                      color: AppConst.kLight,
                    ),
                    const WidthSpacer(wydth: 10),
                    ReusableText(
                        text: "Today's Task",
                        style: appstyle(18, AppConst.kLight, FontWeight.bold))
                  ],
                ),
                const HieghtSpacer(hieght: 25),
                Container(
                  decoration: BoxDecoration(
                      color: AppConst.kLight,
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppConst.kRadius))),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                        color: AppConst.kGreyLight,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppConst.kRadius))),
                    controller: tabController,
                    labelPadding: EdgeInsets.zero,
                    isScrollable: false,
                    labelStyle:
                        appstyle(24, AppConst.kBlueLight, FontWeight.w700),
                    labelColor: AppConst.kBlueLight,
                    unselectedLabelColor: AppConst.kLight,
                    tabs: [
                      Tab(
                        child: SizedBox(
                          width: AppConst.kWidth * 0.5,
                          child: Center(
                              child: ReusableText(
                            text: "Pending",
                            style:
                                appstyle(16, AppConst.kBkDark, FontWeight.bold),
                          )),
                        ),
                      ),
                      Tab(
                        child: Container(
                          padding: EdgeInsets.only(left: 30.w),
                          width: AppConst.kWidth * 0.5,
                          child: Center(
                              child: ReusableText(
                            text: "Completed",
                            style:
                                appstyle(16, AppConst.kBkDark, FontWeight.bold),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                const HieghtSpacer(hieght: 20),
                SizedBox(
                  height: AppConst.kHieght * 0.3,
                  width: AppConst.kWidth,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(AppConst.kRadius)),
                    child: TabBarView(controller: tabController, children: [
                      Container(
                        color: AppConst.kBkLight,
                        height: AppConst.kHieght * 0.3,
                        child: const TodayTasks(),
                      ),
                      Container(
                        color: AppConst.kBkLight,
                        height: AppConst.kHieght * 0.3,
                        child: const CompletedTasks(),
                      )
                    ]),
                  ),
                ),
                const HieghtSpacer(hieght: 20),
                const TomorrowList(),

                const HieghtSpacer(hieght: 20),

                const DayAfterList(),
                // XpansionTile(
                //     text: DateTime.now()
                //         .add(const Duration(days: 2))
                //         .toString()
                //         .substring(5, 10),
                //     text2: "Day After tomorrow tasks",
                //     onExpansionChanged: (bool expanded) {
                //       ref
                //           .read(xpansionState0Provider.notifier)
                //           .setStart(!expanded);
                //     },
                //     trailing: Padding(
                //       padding: EdgeInsets.only(right: 12.0.w),
                //       child: ref.watch(xpansionState0Provider)
                //           ? const Icon(
                //               AntDesign.circledown,
                //               color: AppConst.kLight,
                //             )
                //           : const Icon(
                //               AntDesign.closecircleo,
                //               color: AppConst.kBlueLight,
                //             ),
                //     ),
                //     children: [
                //       TodoTile(
                //           start: "03:00",
                //           end: "05:00",
                //           switcher: Switch(
                //             value: true,
                //             onChanged: (value) {},
                //           ))
                //     ]),
                // const HieghtSpacer(hieght: 20),
                // XpansionTile(
                //     text: DateTime.now()
                //         .add(const Duration(days: 2))
                //         .toString()
                //         .substring(5, 10),
                //     text2: "Tomorrow tasks are shown here",
                //     children: []),
              ],
            ),
          ),
        ));
  }
}
