import 'package:not/common/modals/task_model.dart';
import 'package:not/common/utils/constants.dart';
import 'package:not/features/todo/controllers/todo/todo_provider.dart';
import 'package:not/features/todo/widgets/todo_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompletedTasks extends ConsumerWidget {
  const CompletedTasks({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todoStateProvider);
    List lastMonth = ref.read(todoStateProvider.notifier).last30days();
    var completedList = listData
        .where((element) =>
            element.isCompleted == 1 ||
            lastMonth.contains(element.date!.substring(0, 10)))
        .toList();

    return ListView.builder(
        itemCount: completedList.length,
        itemBuilder: (context, index) {
          final data = completedList[index];

          dynamic color = ref.read(todoStateProvider.notifier).getRandomColor();
          return TodoTile(
              delete: () {
                ref.read(todoStateProvider.notifier).deleteTodo(data.id ?? 0);
              },
              editWidget: const SizedBox.shrink(),
              title: data.title,
              color: color,
              description: data.desc,
              start: data.startTime,
              end: data.endTime,
              switcher: const Icon(
                AntDesign.checkcircle,
                color: AppConst.kGreen,
              ));
        });
  }
}
