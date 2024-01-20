import 'package:not/common/utils/constants.dart';
import 'package:not/common/widgets/expansion_tile.dart';
import 'package:not/features/todo/controllers/todo/todo_provider.dart';
import 'package:not/features/todo/controllers/xpansion_provider.dart';
import 'package:not/features/todo/pages/update_task.dart';
import 'package:not/features/todo/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoStateProvider);
    var color = ref.read(todoStateProvider.notifier).getRandomColor();
    String tomorrow = ref.read(todoStateProvider.notifier).getTomorrow();

    var tomorrowTasks =
        todos.where((element) => element.date!.contains(tomorrow));
    return XpansionTile(
        text: "Tomorrow's Task",
        text2: "Tomorrow tasks are shown here",
        onExpansionChanged: (bool expanded) {
          ref.read(xpansionStateProvider.notifier).setStart(!expanded);
        },
        trailing: Padding(
          padding: EdgeInsets.only(right: 12.0.w),
          child: ref.watch(xpansionStateProvider)
              ? const Icon(
                  AntDesign.circledown,
                )
              : const Icon(
                  AntDesign.closecircleo,
                ),
        ),
        children: [
          for (final todo in tomorrowTasks)
            TodoTile(
                title: todo.title,
                description: todo.desc,
                color: color,
                start: todo.startTime,
                end: todo.endTime,
                delete: () {
                  ref.read(todoStateProvider.notifier).deleteTodo(todo.id ?? 0);
                },
                editWidget: GestureDetector(
                  onTap: () {
                    titles = todo.title.toString();
                    descs = todo.desc.toString();

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateTask(
                                  id: todo.id ?? 0,
                                )));
                  },
                  child: const Icon(MaterialCommunityIcons.circle_edit_outline),
                ),
                switcher: const SizedBox.shrink())
        ]);
  }
}


// class TomorrowList extends ConsumerWidget {
//   const TomorrowList({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     List<Task> listData = ref.watch(todoStateProvider);
//     String today = ref.read(todoStateProvider.notifier).getToday();
//     var todayList = listData
//         .where((element) =>
//             element.isCompleted == 0 && element.date!.contains(today))
//         .toList();

//     return ListView.builder(
//         itemCount: todayList.length,
//         itemBuilder: (context, index) {
//           final data = todayList[index];
//           bool isCompleted =
//               ref.read(todoStateProvider.notifier).getStatus(data);
//           dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
//           return TodoTile(
//             delete: () {
//               ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
//             },
//             editWidget: GestureDetector(
//               onTap: () {},
//               child: const Icon(MaterialCommunityIcons.circle_edit_outline),
//             ),
//             title: data.title,
//             color: color,
//             description: data.desc,
//             start: data.startTime,
//             end: data.endTime,
//             switcher: Switch(
//               value: isCompleted,
//               onChanged: (value) {},
//             ),
//           );
//         });
//   }
// }

