import 'package:patrol/patrol.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/patrol_keys.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';

void main() {
  patrolTest(
    'discover pendant collectible in chichen itza',
    nativeAutomation: true,
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive,
    config: PatrolTesterConfig(settleTimeout: Duration(seconds: 3)),
    ($) async {
      await runWonderous($: $);

      await $(K.finishIntroButton)
          .which<AnimatedOpacity>(
            (button) => button.opacity == 1,
          )
          .$(CircleIconBtn)
          .scrollTo(step: 300)
          .tap();
      await $(K.hamburgerMenuButton).waitUntilVisible();

      await $(K.wonderScreen(WonderType.chichenItza))
          .scrollTo(
            step: 300,
          )
          .tap(
            settlePolicy: SettlePolicy.trySettle,
          );

      await $(K.collectible(WonderType.chichenItza, 0))
          .scrollTo(
            view: $(PageStorageKey('editorial')).$(Scrollable),
            settlePolicy: SettlePolicy.noSettle,
          )
          .tap(
            settlePolicy: SettlePolicy.trySettle,
          );
      await $('VIEW IN MY COLLECTION').tap();
      await $(K.collectibleDetails(WonderType.chichenItza, 'Pendant')).tap(
        settleTimeout: Duration(seconds: 10),
      );
      await $('Pendant').waitUntilVisible();
    },
  );
}
