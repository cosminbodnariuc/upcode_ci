// File created by
// Lung Razvan <long1eu>
// on 09/05/2020

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:upcode_ci/src/commands/flutter/analyze.dart';
import 'package:upcode_ci/src/commands/flutter/fastlane.dart';
import 'package:upcode_ci/src/commands/flutter/firebase_app_distribution.dart';
import 'package:upcode_ci/src/commands/flutter/format.dart';
import 'package:upcode_ci/src/commands/flutter/save_release_notes.dart';
import 'package:upcode_ci/src/commands/flutter/test.dart';
import 'package:upcode_ci/src/commands/index.dart';
import 'package:yaml/yaml.dart';

void main(List<String> args) {
  final File upcode = File('./upcode.yaml');
  if (!upcode.existsSync()) {
    stderr.writeln('You need to call this command from the same directory as you upcode.yaml file.');
    exit(1);
  }

  final Map<String, dynamic> config = <String, dynamic>{
    'pwd': upcode.parent.absolute.path,
    ...loadYaml(upcode.readAsStringSync()),
  };

  CommandRunner('upcode', 'Provides useful automation tools')
    ..addCommand(FlutterGenerateCommand(config))
    ..addCommand(FlutterI18nCommand(config))
    ..addCommand(FlutterBuildRunnerCommand(config))
    ..addCommand(FlutterVersionCommand(config))
    ..addCommand(FlutterFirebaseAppDistributionCommand(config))
    ..addCommand(FlutterFastlaneDeployCommand(config))
    ..addCommand(FlutterEnvironmentCommand(config))
    ..addCommand(FlutterAnalyzeCommand(config))
    ..addCommand(FlutterFormatCommand(config))
    ..addCommand(FlutterTestCommand(config))
    ..addCommand(SaveReleaseNotesCommand(config))
    ..run(args);
}