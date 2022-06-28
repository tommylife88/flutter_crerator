import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  try {
    final useFvm = context.logger.confirm(
      '? Use FVM?',
      defaultValue: false,
    );
    // save vars
    context.vars = {
      ...context.vars,
      'use_fvm': useFvm,
    };
    if (useFvm) {
      await _generateFvmFlutterProject(context);
    } else {
      await _generateFlutterProject(context);
    }
    context.logger.info('Done');
  } catch (e) {
    context.logger.err('Failed');
  }
}

Future<void> _generateFvmFlutterProject(HookContext context) async {
  final appName = context.vars['app_name'];
  final appDescription = context.vars['app_description'];
  final orgName = context.vars['org_name'];

  // check fvm installed
  {
    final fvmResult = await Process.run(
      'fvm',
      [
        '--version',
      ],
      runInShell: true,
    );
    if (fvmResult.exitCode != 0) {
      context.logger.err('FVM is not installed');
      exit(fvmResult.exitCode); //fatal
    }
    context.logger.info('FVM version ${fvmResult.stdout}');
  }

  // select sdk version
  final flutterSdkVersion = context.logger.prompt(
    '? Select Flutter SDK version?',
    defaultValue: "stable",
  );
  // save vars
  context.vars = {
    ...context.vars,
    'flutter_sdk_version': flutterSdkVersion,
  };

  // fvm install
  {
    final fvmListResult = await Process.run(
      'fvm',
      [
        'list',
      ],
      runInShell: true,
    );
    if (fvmListResult.exitCode != ExitCode.success.code) {
      context.logger.err('${fvmListResult.stderr}');
      exit(fvmListResult.exitCode);
    }
    final listStrig = fvmListResult.stdout as String;
    if (!listStrig.contains(flutterSdkVersion)) {
      final installProgress =
          context.logger.progress('fvm install $flutterSdkVersion');
      // final fvmInstallResult = await Process.run(
      await Process.run(
        'fvm',
        [
          'install',
          '$flutterSdkVersion',
        ],
        runInShell: true,
      );
      // if (fvmInstallResult.exitCode != ExitCode.success.code) {
      //   context.logger.err('${fvmInstallResult.stderr}');
      //   installProgress
      //       .fail('fvm install failed (${fvmInstallResult.exitCode})');
      //   exit(fvmInstallResult.exitCode);
      // }
      installProgress.complete('fvm install $flutterSdkVersion success');
    }
  }

  {
    final createProgress = context.logger.progress('fvm flutter create');
    final currentDir = Directory.current.path;
    final projectDir = currentDir + '/$appName';

    await Directory('$projectDir').create();

    await Process.run(
      'fvm',
      [
        'use',
        '$flutterSdkVersion',
        '--force',
        ' --skip-setup',
      ],
      runInShell: true,
      workingDirectory: projectDir,
    );

    // final createResult = await Process.run(
    await Process.run(
      'fvm',
      [
        'flutter',
        'create',
        '.',
        '--description',
        '$appDescription',
        '--org',
        '$orgName'
      ],
      runInShell: true,
      workingDirectory: projectDir,
    );

    // if (createResult.exitCode != 0) {
    //   context.logger.err('${createResult.stderr}');
    //   createProgress.fail('fvm flutter create failed');
    //   exit(createResult.exitCode);
    // }
    createProgress.complete('fvm flutter create success');
  }
}

Future<void> _generateFlutterProject(HookContext context) async {
  final inProgress = context.logger.progress('flutter create');

  final appName = context.vars['app_name'];
  final appDescription = context.vars['app_description'];
  final orgName = context.vars['org_name'];

  await Process.run(
    'flutter',
    [
      'create',
      '$appName',
      '--description',
      '$appDescription',
      '--org',
      '$orgName'
    ],
    runInShell: true,
  );

  inProgress.complete('flutter create success');
}
