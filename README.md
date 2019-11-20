# color_thief_flutter

the Flutter implementation of color-thief, based on [quantize_dart](https://github.com/nervouself/quantize_dart).

## Usage

`````dart
import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:color_thief_flutter/utils.dart';

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
`````

### color_thief_flutter.dart

Main package of color_thief_flutter.

> **All these functions return `null` if the parameter is unqualified**

#### getColorFromUrl(String url, [int quality])

returns the base color from the largest cluster, represented as [R,G,B]

#### getPaletteFromUrl(String url, [int colorCount, int quality])

returns a list that contains the reduced color palette, represented as [[R,G,B]]

#### getImageFromUrl(String url)

returns the Image from url

#### getImageFromProvider(ImageProvider imageProvider)

returns the real Image of ImageProvider

#### getColorFromImage(Image image, [int quality = 10])

returns the base color from the largest cluster, represented as [R,G,B]

#### getPaletteFromImage(Image image, [int colorCount, int quality])

returns a list that contains the reduced color palette, represented as [[R,G,B]]

#### parameters

* `url` - Url to image.
* `imageProvider` - ImageProvider.
* `image` - Image that get from `getImageFromProvider`.
* `colorCount` - Between 2 and 256. The maximum number of colours allowed in the reduced palette.
* `quality` - Between 1 and 10. There is a trade-off between quality and speed. The bigger the number, the faster the palette generation but the greater the likelihood that colors will be missed.

### utils.dart

Tools for format colors.

> **May cause loss of significance**

#### fromRGBtoHSV(List<int> list)

retruns HSVColor, represented as [H,S,V]

#### fromHSVtoRGB(List<int> list)

retruns RGBColor, represented as [R,G,B]

#### parameters

* `R,G,B`'s range is [0,255]
* `H`'s range is [0,360]
* `S,V`'s range is [0,100]

## License

Licensed under the MIT License.
