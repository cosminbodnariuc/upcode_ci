// File created by
// Lung Razvan <long1eu>
// on 09/05/2020

import 'dart:async';
import 'dart:io';

import 'package:upcode_ci/src/commands/command.dart';

class FlutterFormatCommand extends UpcodeCommand {
  FlutterFormatCommand(Map<String, dynamic> config) : super(config) {
    argParser.addFlag(
      'modify',
      defaultsTo: false,
      help:
          'If false it will only check if there are changes that need to be done and exists with non 0 code if so. If true it will format the code.',
    );
  }

  @override
  final String name = 'flutter:format';

  @override
  final String description = 'Runs the dart formatter and exists with a non 0 code when there are issues.';

  @override
  FutureOr<dynamic> run() async {
    final bool modify = argResults['modify'] ?? false;

    for (final String module in formattedModules) {
      final List<String> files = Directory(module)
          .listSync(recursive: true, followLinks: false)
          .whereType<File>()
          .map((File it) => it.path.split('$module/')[1])
          .where(fileFilter)
          .toList();

      await execute(
        () => runCommand(
          'flutter',
          <String>['format', '-l', '120', if (!modify) '--set-exit-if-changed', ...files],
          workingDirectory: module,
        ),
        description,
      );
    }
  }
}
