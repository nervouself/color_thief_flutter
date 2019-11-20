import 'dart:math' as math;

_min(List<num> list) {
  return list.reduce((a, b) {
    return math.min(a, b);
  });
}

_max(List<num> list) {
  return list.reduce((a, b) {
    return math.max(a, b);
  });
}

/// retruns HSVColor, represented as [H,S,V]
/// 
/// `list` - RGBColor, represented as [R,G,B]
/// 
/// `R,G,B`'s range is [0,255], `H`'s range is [0,360], `S,V`'s range is [0,100]
List<int> fromRGBtoHSV(List<int> list) {
  assert(list.length == 3);

  var r = list[0] / 255;
  var g = list[1] / 255;
  var b = list[2] / 255;
  var h,s,v;
  var min = _min([r, g, b]);
  var max = v = _max([r, g, b]);
  var difference = max - min;

  if (max == min){
    h = 0;
  } else {
    if (max == r) {
      h = (g - b) / difference + (g < b ? 6 : 0);
    } else if (max == g) {
      h = 2.0 + (b - r) / difference;
    } else if (max == b) {
      h = 4.0 + (r - g) / difference;
    }
    h = (h * 60).round();
  }
  if (max == 0) {
    s = 0;
  } else {
    s = 1 - min / max;
  }
  s = (s * 100).round();
  v = (v * 100).round();

  return [h, s, v];
}

/// retruns RGBColor, represented as [R,G,B]
/// 
/// `list` - HSVColor, represented as [H,S,V]
/// 
/// `H`'s range is [0,360], `S,V`'s range is [0,100], `R,G,B`'s range is [0,255]
List<int> fromHSVtoRGB(List<int> list) {
  assert(list.length == 3);

  var h = list[0];
  var s = list[1] / 100;
  var v = list[2] / 100;
  var h1 = (h ~/ 60) % 6;
  var f = h / 60 - h1;
  var p = v * (1 - s);
  var q = v * (1 - f *s );
  var t = v * (1 - (1 - f) * s);
  var r, g, b;

  switch (h1) {
    case 0:
      r = v; g = t; b = p;
      break;
    case 1:
      r = q; g = v; b = p;
      break;
    case 2:
      r = p; g = v; b = t;
      break;
    case 3:
      r = p; g = q; b = v;
      break;
    case 4:
      r = t; g = p; b = v;
      break;
    case 5:
      r = v; g = p; b = q;
      break;
  }

  return [(r * 255).round(), (g * 255).round(), (b * 255).round()];
}
