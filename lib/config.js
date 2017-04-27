var app = 'accents-ui';

function checkHex(hex) {
  var hexPattern = /^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/;
  return hex.match(hexPattern);
}

function rgbToHex(color) {
  return '#' + ((1 << 24) + (color.red << 16) + (color.green << 8) + color.blue).toString(16).slice(1);
}

function hexToRgb(hex) {
  var shorthandRegex = /^#?([a-f\d])([a-f\d])([a-f\d])$/i;
  hex = hex.replace(shorthandRegex, function(m, r, g, b) {
    return r + r + g + g + b + b;
  });

  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? {
    red: parseInt(result[1], 16),
    green: parseInt(result[2], 16),
    blue: parseInt(result[3], 16)
  } : null;
}

function desatRgb(rgb, percent) {
  var intensity = 0.3 * rgb.red + 0.59 * rgb.green + 0.11 * rgb.blue;

  rgb.red = Math.floor(intensity * percent + rgb.red * (1 - percent));
  rgb.green = Math.floor(intensity * percent + rgb.green * (1 - percent));
  rgb.blue = Math.floor(intensity * percent + rgb.blue * (1 - percent));

  return rgb;
}

function shadeRgb(rgb, percent) {
  var t = percent < 0 ? 0 : 255,
  p = percent < 0 ? percent * -1 : percent;

  rgb.red = Math.round((t - rgb.red) * p) + rgb.red;
  rgb.green = Math.round((t - rgb.green) * p) + rgb.green;
  rgb.blue = Math.round((t - rgb.blue) * p) + rgb.blue;

  return rgb;
}

function mapColor(color, rgb) {
  color.red = rgb.red;
  color.green = rgb.green;
  color.blue = rgb.blue;
}

function setRoot(property, value) {
  document.documentElement.style.setProperty(property, value);
}

function setAccent(color) {
  setRoot('--accent-color', rgbToHex(color));
  setRoot('--accent-color-subtle', rgbToHex(shadeRgb(desatRgb(color, 0.25), -0.25)));
}

function setScale(scale) {
  setRoot('--ui-scale', scale);
}

atom.config.observe(app + '.accentColor', function (value) {
  value = value.trim();

  if (checkHex(value)) {
    var color = {
      red: 255,
      green: 255,
      blue: 255,
    };
    mapColor(color, hexToRgb(value));
    setAccent(color);
  }
});

atom.config.observe(app + '.useSyntax', function (value) {});

atom.config.observe(app + '.scale', function (value) {
  setScale(value + 'em');
});
