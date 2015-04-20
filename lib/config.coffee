module.exports =

setAccent = (accent) ->
    fs = require 'fs'
    path = require 'path'
    writePath = path.join __dirname, '..', 'styles/ui-accent.less'
    fs.writeFileSync writePath, "@accent-color: #{accent.toHexString()};\n"

setAccent(atom.config.get('accents-ui.accentColor'))

atom.config.onDidChange 'accents-ui.accentColor', ->
    setAccent(atom.config.get('accents-ui.accentColor'))
