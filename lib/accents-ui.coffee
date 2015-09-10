module.exports =

  config:
    accentColor:
        description: 'Set a color that will influence accents in the theme'
        type: 'color'
        default: '#d2372b'
    hexColor:
        description: 'Set an accent color by hex value (cannot be shorthand, use #rrggbb)'
        type: 'string'
        default: '#d2372b'
    useSyntax:
        description: 'Override the gutter, background, and selection colours'
        type: 'boolean'
        default: 'true'
    debugMode:
        description: 'Log certain details to the console'
        type: 'boolean'
        default: 'false'

  activate: (state) ->
    atom.themes.onDidChangeActiveThemes ->
      Config = require './config'
      Config.apply()
