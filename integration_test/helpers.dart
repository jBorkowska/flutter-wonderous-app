import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wonders/common_libs.dart';
import 'package:wonders/patrol_keys.dart';

Future<void> swipeUntilVisible({
  required PatrolTester $,
  required Finder finder,
  required Finder view,
  int maxIteration = 100,
  Offset step = const Offset(-200, 0),
  Duration duration = const Duration(milliseconds: 100),
}) async {
  var viewPatrolFinder = $(view);
  viewPatrolFinder = (await viewPatrolFinder.waitUntilVisible()).first;
  var iterationsLeft = maxIteration;
  while (iterationsLeft > 0 && finder.hitTestable().evaluate().isEmpty) {
    await $.tester.drag(viewPatrolFinder, step);
    await pumpAndMaybeSettle($: $);
    iterationsLeft -= 1;
  }
  if (iterationsLeft <= 0) {
    throw Exception('After trying to scroll to $finder, there was no such widget');
  }
}

Future<void> pumpAndMaybeSettle({
  required PatrolTester $,
  Duration duration = const Duration(milliseconds: 100),
  Duration timeout = const Duration(seconds: 10),
}) async {
  // int iteration = 100;
  // print('started pumpAndMaybeSettle');
  // while ($.tester.hasRunningAnimations && iteration > 0) {
  //   await $.pump(Duration(milliseconds: 50));
  //   iteration--;
  // }
  // if (iteration <= 0) {
  //   print('pumpAndMaybeSettle timed out');
  // }
  try {
    await $.tester.pumpAndSettle(duration, EnginePhase.sendSemanticsUpdate, timeout);
  } catch (e) {
    if (e is FlutterError && e.message == 'pumpAndSettle timed out') {
      //dev.log(e.message);
      print('time out');
    } else {
      rethrow;
    }
  }
}

Future<void> runWonderous({
  required PatrolTester $,
}) async {
  await (await SharedPreferences.getInstance()).clear();
  prepareApp();
  await $.pumpWidgetAndSettle(WondersApp());
  await initializeApp();
}

Future<void> onboarding({
  required PatrolTester $,
}) async {
  await $('Swipe left to continue').waitUntilVisible();

  await $(K.finishIntroButton)
      .which<AnimatedOpacity>(
        (button) => button.opacity == 1,
      )
      .$(CircleIconBtn)
      .scrollTo(step: 300)
      .tap();
  await $(K.hamburgerMenuButton).waitUntilVisible();
}

Future<void> openChitchenItza({
  required PatrolTester $,
}) async {
  await $(K.wonderScreen(WonderType.chichenItza)).scrollTo(step: 300).tap(
        settlePolicy: SettlePolicy.trySettle,
        settleTimoeut: Duration(seconds: 2),
      );
}
