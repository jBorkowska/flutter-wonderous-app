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

      await $(K.photosSectionButton).tap(
        settlePolicy: SettlePolicy.trySettle,
      );
      await $(EightWaySwipeDetector)
          .which<EightWaySwipeDetector>(
            (widget) => widget.key == K.image('14'),
          )
          .scrollTo(
            step: 200,
            view: $(EightWaySwipeDetector),
            scrollDirection: AxisDirection.right,
            settlePolicy: SettlePolicy.trySettle,
          );

      await $(EightWaySwipeDetector)
          .which<EightWaySwipeDetector>(
            (widget) => widget.key == K.image('19'),
          )
          .scrollTo(
            step: 200,
            view: $(EightWaySwipeDetector),
            scrollDirection: AxisDirection.down,
            settlePolicy: SettlePolicy.trySettle,
          );

      await $(EightWaySwipeDetector)
          .which<EightWaySwipeDetector>(
            (widget) => widget.key == K.image('18'),
          )
          .scrollTo(
            step: 200,
            view: $(EightWaySwipeDetector),
            scrollDirection: AxisDirection.left,
            settlePolicy: SettlePolicy.trySettle,
          );
    },
  );
}
