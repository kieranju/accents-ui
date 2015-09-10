module.exports =

# more reliable rgb to hex conversion
# .toHexString function sometimes returns shorthand
rgbToHex = (r, g, b) ->
    '#' + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1)

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
        when 'useSyntax' then atom.config.get('accents-ui.useSyntax')
        when 'debugMode' then atom.config.get('accents-ui.debugMode')

# shows value in console and returns value for use
toConsole = (key, val, returnVal) ->
    console.log('accents-ui :: ' + key + ' : ' + val) if getOption('debugMode')
    val if returnVal

setAccent(getOption('accentColor'))
setSyntax(getOption('useSyntax'))

atom.config.onDidChange 'accents-ui.accentColor', ->
    setAccent(toConsole('accent colour object', getOption('accentColor'), true))
    toConsole('accent colour Hex', getOption('accentColor').toHexString(), false)
    console.log(getOption('accentColor')) if getOption('debugMode')

atom.config.onDidChange 'accents-ui.useSyntax', ->
    setSyntax(toConsole('override syntax', getOption('useSyntax'), true))

atom.config.onDidChange 'accents-ui.debugMode', ->
    toConsole('debug mode', getOption('debugMode'), false)
