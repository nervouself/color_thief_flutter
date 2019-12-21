import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:color_thief_flutter/utils.dart';
import 'package:flutter/painting.dart';

void main() {

  // color_thief_flutter.dart

  final url = 'https://github.githubassets.com/images/modules/open_graph/github-octocat.png';
  final imageProvider = NetworkImage(url);

  getColorFromUrl(url).then((color) {
    print(color); // [R,G,B]
  });

  getPaletteFromUrl(url).then((palette) {
    print(palette); // [[R,G,B]]
  });

  getImageFromUrl(url).then((image) {
    print(image); // Image
  });

  getImageFromProvider(imageProvider).then((image) {
    print(image); // Image

    getColorFromImage(image).then((color) {
      print(color); // [R,G,B]
    });

    getPaletteFromImage(image).then((palette) {
      print(palette); // [[R,G,B]]
    });
  });

  // utils.dart

  final hsv = fromRGBtoHSV([90, 90, 90]);
  print(hsv); // [H,S,V]

  final rgb = fromHSVtoRGB([90, 90, 90]);
  print(rgb); // [R,B,G]

}
