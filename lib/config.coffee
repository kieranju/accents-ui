module.exports =

setAccent = (accent) ->
    fs = require 'fs'
    fs.writeFileSync 'styles/ui-accent.less', "@accent-color: #{accent.toHexString()};\n"

setAccent(atom.config.get('accents-ui.accentColor'))

atom.config.onDidChange 'accents-ui.accentColor', ->
    setAccent(atom.config.get('accents-ui.accentColor'))
