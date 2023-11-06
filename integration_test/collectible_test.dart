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
    config: PatrolTesterConfig(
      settleTimeout: Duration(seconds: 3),
      settlePolicy: SettlePolicy.trySettle,
    ),
    ($) async {
      await runWonderous($: $);

      await onboarding($: $);

      await openChitchenItza($: $);

      await $(K.collectible(WonderType.chichenItza, 0))
          .scrollTo(
            view: $(PageStorageKey('editorial')).$(Scrollable),
            settlePolicy: SettlePolicy.noSettle,
          )
          .tap(
            settlePolicy: SettlePolicy.trySettle,
          );
      await $('VIEW IN MY COLLECTION').tap();
      await $(
        K.collectibleDetails(WonderType.chichenItza, 'Pendant'),
      ).tap(
        settleTimeout: Duration(seconds: 10),
      );
      await $('Pendant').waitUntilVisible();

      await $(K.hamburgerMenuButton).tap();
      await $(K.hamburgerMenuButton).tap();

      await $(K.timelineButton).tap(
        settlePolicy: SettlePolicy.trySettle,
      );

      await $('OPEN GLOBAL TIMELINE').tap();

      await $('Modern Era').scrollTo(
        view: $(K.box),
        scrollDirection: AxisDirection.left,
        step: 32,
      );
    },
  );
}
