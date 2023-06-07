import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/patrol_keys.dart';

import 'helpers.dart';

void main() {
  patrolTest(
    'artifacts carousel',
    nativeAutomation: true,
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive,
    config: PatrolTesterConfig(settleTimeout: Duration(seconds: 2)),
    ($) async {
      await runWonderous($: $);

      await $('Swipe left to continue').waitUntilVisible();

      await $(K.finishIntroButton)
          .which<AnimatedOpacity>(
            (button) => button.opacity == 1,
          )
          .$(CircleIconBtn)
          .scrollTo(step: 300)
          .tap();
      await $(K.hamburgerMenuButton).waitUntilVisible();

      await $(K.wonderScreen(WonderType.chichenItza)).scrollTo(step: 300).tap(
            settlePolicy: SettlePolicy.trySettle,
            settleTimoeut: Duration(seconds: 2),
          );

      await $(K.artifactsSectionButton).tap(settlePolicy: SettlePolicy.trySettle);
      await $(K.artifact('Head of a Rain God'))
          .scrollTo(
            scrollable: $(PageView).$(Scrollable),
            step: 100,
            settlePolicy: SettlePolicy.trySettle,
          )
          .tap(settlePolicy: SettlePolicy.trySettle);
    },
  );
}
