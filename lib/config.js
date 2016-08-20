var app = 'accents-ui';

var rgbToHex = function (color) {
    return '#' + ((1 << 24) + (color.red << 16) + (color.green << 8) + color.blue).toString(16).slice(1);
};

var hexToRgb = function (hex) {
    var rgbPattern = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
    var rgb = {
        red: 255,
        green: 255,
        blue: 255,
    };

    if (rgbPattern) {
        rgb.red = parseInt(rgbPattern[1], 16);
        rgb.green = parseInt(rgbPattern[2], 16);
        rgb.blue = parseInt(rgbPattern[3], 16);
    }

    return rgb;
};

var checkHex = function (hex) {
    var hexPattern;
    hexPattern = /^#([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})$/;
    if (hex.match(hexPattern)) {
        return true;
    }
};

var desaturate = function (rgb, percentage) {
    var intensity = 0.3 * rgb.red + 0.59 * rgb.green + 0.11 * rgb.blue;
    percentage /= 100;

    rgb.red = Math.floor(intensity * percentage + rgb.red * (1 - percentage));
    rgb.green = Math.floor(intensity * percentage + rgb.green * (1 - percentage));
    rgb.blue = Math.floor(intensity * percentage + rgb.blue * (1 - percentage));

    return rgb;
};

var mapColor = function (color, rgb) {
    color.red = rgb.red;
    color.green = rgb.green;
    color.blue = rgb.blue;
}

var setRoot = function (property, value) {
    document.documentElement.style.setProperty(property, value);
};

var setAccent = function (accent) {
    setRoot('--accent-color', rgbToHex(accent));
    setRoot('--accent-color-subtle', rgbToHex(desaturate(accent, 20)));
};

atom.config.onDidChange(app + '.accentColor', function () {
    var accent = atom.config.get(app + '.accentColor');

    atom.config.set(app + '.hexColor', rgbToHex(accent));
    setAccent(accent);
});

atom.config.onDidChange(app + '.hexColor', function () {
    var hex = atom.config.get(app + '.hexColor');
    if (checkHex(hex)) {
        var accent = atom.config.get(app + '.accentColor');
        var rgb = hexToRgb(hex);

        mapColor(accent, rgb);
        atom.config.set(app + '.accentColor', color);
    }
});

setAccent(atom.config.get(app + '.accentColor'));
