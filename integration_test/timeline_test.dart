import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:wonders/patrol_keys.dart';
import 'package:wonders/ui/common/controls/eight_way_swipe_detector.dart';

import 'helpers.dart';

void main() {
  patrolTest(
    'gallery swiping test',
    nativeAutomation: true,
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive,
    config: PatrolTesterConfig(settleTimeout: Duration(seconds: 2)),
    ($) async {
      await runWonderous($: $);

      await onboarding($: $);

      await openChitchenItza($: $);

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
