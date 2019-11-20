import 'package:flutter_test/flutter_test.dart';

// import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:color_thief_flutter/utils.dart';

void main() {

  test('utils.fromRGBtoHSV', () {
    expect(fromRGBtoHSV([90, 90, 90]).toString(), [0, 0, 35].toString());
  });

  test('utils.fromHSVtoRGB', () {
    expect(fromHSVtoRGB([90, 90, 90]).toString(), [126, 230, 23].toString());
  });

}
