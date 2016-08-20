var app = 'accents-ui';

function checkHex(hex) {
    var hexPattern;
    hexPattern = /^#([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})$/;
    if (hex.match(hexPattern)) {
        return true;
    }
};

function rgbToHex(color) {
    return '#' + ((1 << 24) + (color.red << 16) + (color.green << 8) + color.blue).toString(16).slice(1);
};

function hexToRgb(hex) {
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

function desatRgb(rgb, percent) {
    var intensity = 0.3 * rgb.red + 0.59 * rgb.green + 0.11 * rgb.blue;

    rgb.red = Math.floor(intensity * percent + rgb.red * (1 - percent));
    rgb.green = Math.floor(intensity * percent + rgb.green * (1 - percent));
    rgb.blue = Math.floor(intensity * percent + rgb.blue * (1 - percent));

    return rgb;
};

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
};

function setAccent(accent) {
    setRoot('--accent-color', rgbToHex(accent));
    setRoot('--accent-color-subtle', rgbToHex(shadeRgb(desatRgb(accent, 0.20), -0.20)));
};

atom.config.onDidChange(app + '.accentColor', function (state) {
    var accent = state.newValue;

    atom.config.set(app + '.accentHex', rgbToHex(accent));
    setAccent(accent);
});

atom.config.onDidChange(app + '.accentHex', function (state) {
    var hex = state.newValue;

    if (checkHex(hex)) {
        var accent = atom.config.get(app + '.accentColor');
        mapColor(accent, hexToRgb(hex));

        atom.config.set(app + '.accentColor', accent);
    }
});

atom.config.onDidChange(app + '.useSyntax', function (state) {
    var syntax = state.newValue;
    
    atom.config.set(app + '.useSyntax', syntax);
});

setAccent(atom.config.get(app + '.accentColor'));
