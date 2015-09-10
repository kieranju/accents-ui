module.exports =

# more reliable rgb to hex conversion
# .toHexString function sometimes returns shorthand
rgbToHex = (r, g, b) ->
    '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)

# converts hex to rgb
hexToRgb = (hex) ->
    result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
    if result
        r: parseInt(result[1], 16),
        g: parseInt(result[2], 16),
        b: parseInt(result[3], 16),
    else
        null

# returns true if matches hex pattern
checkHex = (hex) ->
    reg = /^#([\da-fA-F]{2})([\da-fA-F]{2})([\da-fA-F]{2})$/
    str = hex
    true if str.match reg

# string accent, writes hex colour to file
setAccent = (accent) ->
    fs = require 'fs'
    path = require 'path'
    writePath = path.join __dirname, '..', 'styles/ui-accent.less'
    fs.writeFileSync writePath, "@accent-color: #{rgbToHex(accent.red, accent.green, accent.blue)};\n"

# bool trigger, specifies whether or not to override syntax
setSyntax = (trigger) ->
    fs = require 'fs'
    path = require 'path'
    writePath = path.join __dirname, '..', 'styles/ui-syntax-include.less'
    content = if trigger then '@import "ui-syntax";\n' else '\n'
    fs.writeFileSync writePath, content

# shortens atom.config.get methods for redundancy
getOption = (option) ->
    switch option
        when 'accentColor' then atom.config.get('accents-ui.accentColor')
        when 'hexColor' then atom.config.get('accents-ui.hexColor')
        when 'useSyntax' then atom.config.get('accents-ui.useSyntax')
        when 'debugMode' then atom.config.get('accents-ui.debugMode')

# shows value in console and returns value for use
toConsole = (key, val, returnVal) ->
    console.log('accents-ui :: ' + key + ' : ' + val) if getOption('debugMode')
    val if returnVal

# runs functions to generate files with LESS variables
setAccent(getOption('accentColor'))
setSyntax(getOption('useSyntax'))

# basic atom configuration handling
atom.config.onDidChange 'accents-ui.accentColor', ->
    color = getOption('accentColor')
    setAccent(toConsole('accent colour object', color, true))
    toConsole('accent colour Hex', color.toHexString(), false)
    console.log(color) if getOption('debugMode')
    atom.config.set('accents-ui.hexColor', rgbToHex(color.red, color.green, color.blue))

atom.config.onDidChange 'accents-ui.hexColor', ->
    hex = getOption('hexColor')
    isHex = checkHex(hex)
    rgb = hexToRgb(hex)
    color = getOption('accentColor')

    if isHex
        color.red = rgb.r
        color.green = rgb.g
        color.blue = rgb.b
        atom.config.set('accents-ui.accentColor', color)

atom.config.onDidChange 'accents-ui.useSyntax', ->
    setSyntax(toConsole('override syntax', getOption('useSyntax'), true))

atom.config.onDidChange 'accents-ui.debugMode', ->
    toConsole('debug mode', getOption('debugMode'), false)
