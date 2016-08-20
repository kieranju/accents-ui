app = "accents-ui"

module.exports =
# converts hex to rgb
hexToRgb = (hex) ->
    rgbPattern = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    if rgbPattern
        return {
            r: parseInt(rgbPattern[1], 16),
            g: parseInt(rgbPattern[2], 16),
            b: parseInt(rgbPattern[3], 16),
        }

# converts rgb to hex
rgbToHex = (color) ->
    "#" + ((1 << 24) + (color.red << 16) + (color.green << 8) + color.blue).toString(16).slice(1)

# matches hex pattern
checkHex = (hex) ->
    hexPattern = /^#([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})$/
    true if hex.match hexPattern

# desaturate color
desaturate = (color, percentage) ->
    intensity = 0.3 * color.red + 0.59 * color.green + 0.11 * color.blue
    percentage /= 100

    color.red = Math.floor(intensity * percentage + color.red * (1 - percentage))
    color.green = Math.floor(intensity * percentage + color.green * (1 - percentage))
    color.blue = Math.floor(intensity * percentage + color.blue * (1 - percentage))

    return color

# set root style
setRoot = (property, value) ->
    document.documentElement.style.setProperty(property, value)

# shortens atom.config.get & atom.config.set methods
getOption = (option) ->
    atom.config.get("#{app}.#{option}")

setOption = (option, value) ->
    atom.config.set("#{app}.#{option}", value)


# sets accent colours
setAccent = (accent) ->
    accentBase = rgbToHex(accent)
    accentSubtle = rgbToHex(desaturate(accent, 20))

    setRoot("--accent-color", accentBase)
    setRoot("--accent-color-subtle", accentSubtle)


# accentColor changed
atom.config.onDidChange "#{app}.accentColor", ->
    accent = getOption("accentColor")
    setOption("hexColor", rgbToHex(accent))
    setAccent(accent)

# hexColor changed
atom.config.onDidChange "#{app}.hexColor", ->
    hex = getOption("hexColor")
    if checkHex(hex)
        accent = getOption("accentColor")
        rgb = hexToRgb(hex)

        accent.red = rgb.r
        accent.green = rgb.g
        accent.blue = rgb.b
        setOption("accentColor", color)

setAccent(getOption("accentColor"))

# fontSize changed
# atom.config.onDidChange "#{app}.fontSize", ->
    # setFontsize(getOption("fontSize"))

# useSyntax changed
# atom.config.onDidChange "#{app}.useSyntax", ->
    # setSyntax(getOption("useSyntax"))









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
