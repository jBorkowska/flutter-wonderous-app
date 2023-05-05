import 'package:flutter/widgets.dart';

import 'package:wonders/logic/data/wonder_type.dart';

typedef K = PatrolKeys;

class PatrolKeys {
  static const finishIntroButton = Key('finishIntroButton');
  static const hamburgerMenuButton = Key('hamburgerMenuButton');
  static const wonderHomeButton = Key('wonderHomeButton');
  static const photosSectionButton = Key('photosSectionButton');
  static const artifactsSectionButton = Key('artifactsSectionButton');

  static Key wonderScreen(WonderType type) => Key(type.name);
  static Key collectible(WonderType type, int index) => Key('${type.name}_$index');
  static Key collectibleDetails(WonderType type, String title) => Key('${type.name}_$title');
}
