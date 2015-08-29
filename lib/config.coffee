module.exports =

setAccent = (accent) ->
    fs = require 'fs'
    path = require 'path'
    writePath = path.join __dirname, '..', 'styles/ui-accent.less'
    fs.writeFileSync writePath, "@accent-color: #{accent.toHexString()};\n"

setSyntax = (trigger) ->
    fs = require 'fs'
    path = require 'path'
    writePath = path.join __dirname, '..', 'styles/ui-syntax-include.less'
    content = if trigger then '@import "ui-syntax";\n' else '\n'
    fs.writeFileSync writePath, content

setAccent(atom.config.get('accents-ui.accentColor'))
setSyntax(atom.config.get('accents-ui.useSyntax'))

atom.config.onDidChange 'accents-ui.accentColor', ->
    setAccent(atom.config.get('accents-ui.accentColor'))

atom.config.onDidChange 'accents-ui.useSyntax', ->
    setSyntax(atom.config.get('accents-ui.useSyntax'))
