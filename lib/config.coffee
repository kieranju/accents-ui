fs = require "fs"
path = require "path"

module.exports =

# converts rgb to hex
rgbToHex = (r, g, b) ->
    "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)

# converts hex to rgb
hexToRgb = (hex) ->
    result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    if result
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16),
    else
        null

# matches hex pattern
checkHex = (hex) ->
    reg = /^#([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})$/
    str = hex
    true if str.match reg

# refresh: ->
#     self = @
#     self.package.deactivate()
#     setImmediate ->
#         return self.package.activate()

# string accent, writes hex colour to file
# setAccent = (accent) ->
#     writePath = path.join __dirname, "..", "styles/ui-accent.less"
#     fs.writeFileSync writePath, "@accent-color: #{rgbToHex(accent.red, accent.green, accent.blue)};\n"

# int size, writes global fontsize to file
# setFontsize = (size) ->
#     fs = require "fs"
#     path = require "path"
#     writePath = path.join __dirname, "..", "styles/ui-fontsize.less"
#     fs.writeFileSync writePath, "@font-size: #{size}px;\n"

# bool trigger, specifies whether or not to override syntax
# setSyntax = (trigger) ->
#     fs = require "fs"
#     path = require "path"
#     writePath = path.join __dirname, "..", "styles/ui-syntax-include.less"
#     content = if trigger then "@import "ui-syntax";\n" else "\n"
#     fs.writeFileSync writePath, content

# string accent, writes hex colour to file
setAccent = (accent) ->
    document.documentElement.style.setProperty("--test", rgbToHex(accent.red, accent.green, accent.blue))

# shortens atom.config.get methods
getOption = (option) ->
    atom.config.get("accents-ui.#{option}")

# runs functions to generate files with LESS variables
setAccent(getOption("accentColor"))
# setFontsize(getOption("fontSize"))
# setSyntax(getOption("useSyntax"))


# basic atom configuration handling
atom.config.onDidChange "accents-ui.accentColor", ->
    color = getOption("accentColor")
    setAccent(color)
    atom.config.set("accents-ui.hexColor", rgbToHex(color.red, color.green, color.blue))

atom.config.onDidChange "accents-ui.hexColor", ->
    hex = getOption("hexColor")
    isHex = checkHex(hex)

    if isHex
        color = getOption("accentColor")
        rgb = hexToRgb(hex)

        color.red = rgb.r
        color.green = rgb.g
        color.blue = rgb.b
        atom.config.set("accents-ui.accentColor", color)

atom.config.onDidChange "accents-ui.fontSize", ->
    # setFontsize(getOption("fontSize"))

atom.config.onDidChange "accents-ui.useSyntax", ->
    # setSyntax(getOption("useSyntax"))
