module.exports =

setAccent = (accent) ->
    fs = require 'fs'
    fs.writeFileSync 'styles/ui-highlight.less', "@highlight-color: #{accent.toHexString()};\n"

setAccent(atom.config.get('highlights-dark-ui.accentColor'))

atom.config.onDidChange 'highlights-dark-ui.accentColor', ->
    setAccent(atom.config.get('highlights-dark-ui.accentColor'))
