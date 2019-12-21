import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:quantize_dart/quantize_dart.dart';

_createPixelArray(Uint8List imgData, int pixelCount, int quality) {
  final pixels = imgData;
  List<List<int>> pixelArray = [];

  for (var i = 0, offset, r, g, b, a; i < pixelCount; i = i + quality) {
    offset = i * 4;
    r = pixels[offset + 0];
    g = pixels[offset + 1];
    b = pixels[offset + 2];
    a = pixels[offset + 3];

    if (a == null || a >= 125) {
      if (!(r > 250 && g > 250 && b > 250)) {
        pixelArray.add([r, g, b]);
      }
    }
  }
  return pixelArray;
}

_validateOptions(int colorCount, int quality) {
  if (colorCount == null || colorCount.runtimeType != int) {
    colorCount = 10;
  } else {
    colorCount = max(colorCount, 2);
    colorCount = min(colorCount, 20);
  }
  if (quality == null || quality.runtimeType != int) {
    quality = 10;
  } else if (quality < 1) {
    quality = 10;
  }
  return [colorCount, quality];
}

/// returns the real Image of ImageProvider
/// 
/// `imageProvider` - ImageProvider
Future<Image> getImageFromProvider(ImageProvider imageProvider) async {
  final ImageStream stream = imageProvider.resolve(
    ImageConfiguration(devicePixelRatio: 1.0),
  );
  final Completer<Image> imageCompleter = Completer<Image>();
  ImageStreamListener listener;
  listener = ImageStreamListener((ImageInfo info, bool synchronousCall) {
    stream.removeListener(listener);
    imageCompleter.complete(info.image);
  });
  stream.addListener(listener);
  final image = await imageCompleter.future;
  return image;
}

/// returns the Image from url
/// 
/// `url` - url to image
Future<Image> getImageFromUrl(String url) async {
  final ImageProvider imageProvider = NetworkImage(url);
  final image = await getImageFromProvider(imageProvider);
  return image;
}

/// returns a list that contains the reduced color palette, represented as [[R,G,B]]
/// 
/// `image` - Image
/// 
/// `colorCount` - Between 2 and 256. The maximum number of colours allowed in the reduced palette
/// 
/// `quality` - Between 1 and 10. There is a trade-off between quality and speed. The bigger the number, the faster the palette generation but the greater the likelihood that colors will be missed.
Future getPaletteFromImage(Image image, [int colorCount, int quality]) async {
    final options = _validateOptions(colorCount, quality);
    colorCount = options[0];
    quality = options[1];

    final imageData  = await image.toByteData(format: ImageByteFormat.rawRgba).then((val) => Uint8List.view((val.buffer)));
    final pixelCount = image.width * image.height;

    final pixelArray = _createPixelArray(imageData, pixelCount, quality);

    final cmap = quantize(pixelArray, colorCount);
    final palette = cmap == null ? null : cmap.palette();

    return palette;
}

/// returns a list that contains the reduced color palette, represented as [[R,G,B]]
/// 
/// `url` - url to image
/// 
/// `colorCount` - Between 2 and 256. The maximum number of colours allowed in the reduced palette
/// 
/// `quality` - Between 1 and 10. There is a trade-off between quality and speed. The bigger the number, the faster the palette generation but the greater the likelihood that colors will be missed.
Future getPaletteFromUrl(String url, [int colorCount, int quality]) async {
  final image = await getImageFromUrl(url);
  final palette = await getPaletteFromImage(image, colorCount, quality);
  return palette;
}

/// returns the base color from the largest cluster, represented as [R,G,B]
/// 
/// `image` - Image
/// 
/// `quality` - Between 1 and 10. There is a trade-off between quality and speed. The bigger the number, the faster the palette generation but the greater the likelihood that colors will be missed.
Future getColorFromImage(Image image, [int quality = 10]) async {
  final palette = await getPaletteFromImage(image, 5, quality);
  if (palette == null) {
    return null;
  }
  final dominantColor = palette[0];
  return dominantColor;
}

/// returns the base color from the largest cluster, represented as [R,G,B]
/// 
/// `url` - url to image
/// 
/// `quality` - Between 1 and 10. There is a trade-off between quality and speed. The bigger the number, the faster the palette generation but the greater the likelihood that colors will be missed.
Future getColorFromUrl(String url, [int quality]) async {
  final image = await getImageFromUrl(url);
  final dominantColor = await getColorFromImage(image, quality);
  return dominantColor;
}
