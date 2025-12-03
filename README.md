# Repro

This project is a repro where sentry would not capture exceptions.

## Pods

## Run

- run `./deploy.sh` to build and deploy the app to the device.
- Press 'click me' button
- notice nothing happens on sentry.io

## Experiments

- Remove `"DEAD_CODE_STRIPPING[arch=*]" = YES;` in `ios/Runner/procect.pbxproj` ❌
  - Remove `"STRIPFLAGS[sdk=*]" = "";` ❌
  - Remove `"STRIP_STYLE[sdk=*]" = all;` ❌
  - Remove `SWIFT_OPTIMIZATION_LEVEL = "-Osize";` ❌
  - Remove `SWIFT_OPTIMIZATION_LEVEL = "-O";` ❌
  - Remove `DEPLOYMENT_POSTPROCESSING = YES;` ❌
  - Remove `GCC_OPTIMIZATION_LEVEL = fast;` ❌
  - Remove `FlutterGeneratedPluginSwiftPackage` under `Runner -> Frameworks, Libraries...`, as SPM Dependency and in `ios/Runner/procect.pbxproj` ❌
  - Add back `SWIFT_OPTIMIZATION_LEVEL = "-O";` in `Relase`  ❌
  - Remove `:linkage => :static` in `Podfile` ✅
  - Add `:linkage => :static` in `Podfile` & Set `STRIP_STYLE = "non-global";` ✅

## Conclusion

If the app is integrated with cocoapods and frameworks are statically linked, we need to set `STRIP_STYLE = "non-global";` in runner settings.

```ruby
target 'Runner' do
  use_frameworks! :linkage => :static
```

This is the current commit. The SPM setup will not be committed.

## SPM

Setup SPM

```bash
flutter config --enable-swift-package-manager
flutter run
```

## Experiments

- Run with SPM enabled without changing pods  ✅
- Remove `STRIP_STYLE = "non-global";` from project file ❌
- Remove `Podfile` (Build will generate Podfile without static linking option.) ✅

## Conclusion

When migration Pods to SPM, Flutter tooling will NOT delete the Podfile, leaving it with the options it was configured with.