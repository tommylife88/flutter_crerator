# flutter_creator

[![Powered by Mason](https://img.shields.io/endpoint?url=https%3A%2F%2Ftinyurl.com%2Fmason-badge)](https://github.com/felangel/mason)

A new brick created with the Mason CLI.

_Generated by [mason][1] 🧱_

## Description

A wrapper for `flutter create` or `fvm flutter create` command and add some management files.

* select use [FVM](https://fvm.app/) for manage flutter SDK version
  * and modify .gitignore (base is [here](https://github.com/flutter/flutter/blob/496049263e4efd68ced664ee2c90db9c93f08571/packages/flutter_tools/templates/app_shared/.gitignore.tmpl))
* add `vscode` files
  * extensions.json
  * settings.json (from [Recommended Settings](https://dartcode.org/docs/recommended-settings/))
* add [.gitattributes](https://github.com/flutter/flutter/blob/master/.gitattributes)

## Prerequisites

* [mason_cli](https://pub.dev/packages/mason_cli). (see [installation](https://pub.dev/packages/mason_cli#installation))
* [FVM](https://fvm.app/) ※if needed

## Usage

Add this package.
```
mason add -g flutter_creator --git-url https://github.com/tommylife88/flutter_crerator.git
```

```
mason make flutter_creator --on-conflict overwrite
```

You'll be prompted for the following information:
* The name of your app
* Your app's description
* The name of your organization
* Whether to use FVM ⚠️
  * Select flutter SDK version

⚠️ **note**: Install FVM in advance by referring to [here](https://fvm.app/docs/getting_started/installation).

## Variables

| Variable                 | Description                                        | Default                               | Type      |
|--------------------------|----------------------------------------------------|---------------------------------------|-----------|
| `app_name`               | The name of your app                               | `app_name`                            | `string`  |
| `app_description`        | The description of your application                | ` A new Flutter project.              | `string`  |
| `org_name`               | The name of your organization                      | `com.example`                         | `string`  |
| `use_fvm`                | Whether to use FVM                                 | `false`                               | `boolean` |
| `flutter_sdk_version`    | Select flutter SDK version (if `use_fvm` is true)  | `stable`                              | `string` |

## About Mason

This is a starting point for a new brick.
A few resources to get you started if this is your first brick template:

- [Official Mason Documentation][2]
- [Code generation with Mason Blog][3]
- [Very Good Livestream: Felix Angelov Demos Mason][4]

[1]: https://github.com/felangel/mason
[2]: https://github.com/felangel/mason/tree/master/packages/mason_cli#readme
[3]: https://verygood.ventures/blog/code-generation-with-mason
[4]: https://youtu.be/G4PTjA6tpTU
