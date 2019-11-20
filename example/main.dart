import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:color_thief_flutter/utils.dart';

void main() {

  // color_thief_flutter.dart

  getColorFromUrl('url/to/image').then((color) {
    print(color); // [R,G,B]
  });

  getPaletteFromUrl('url/to/image').then((palette) {
    print(palette); // [[R,G,B]]
  });

  getImageFromUrl('url/to/image').then((image) {
    print(image); // Image
  });

  getImageFromProvider(imageProvider).then((image) {
    print(image); // Image
  });

  getColorFromImage(image).then((color) {
    print(color); // [R,G,B]
  });

  getPaletteFromImage(image).then((palette) {
    print(palette); // [[R,G,B]]
  });

  // utils.dart

  final hsv = fromRGBtoHSV([90, 90, 90]);
  print(hsv); // [0, 0, 35]

  final rgb = fromHSVtoRGB([90, 90, 90]);
  print(rgb); // [126, 230, 23]

}
