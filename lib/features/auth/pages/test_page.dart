import 'package:not/common/utils/constants.dart';
import 'package:not/common/widgets/appstyle.dart';
import 'package:not/common/widgets/reusable_text.dart';
import 'package:not/features/auth/controllers/code_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String code = ref.watch(codeStateProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ReusableText(
                text: code,
                style: appstyle(30, AppConst.kLight, FontWeight.bold)),
            TextButton(
                onPressed: () {
                  ref.read(codeStateProvider.notifier).setStart("Hello Sumit");
                },
                child: const Text("Press me")),
          ],
        ),
      ),
    );
  }
}
