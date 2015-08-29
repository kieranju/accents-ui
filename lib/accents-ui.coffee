module.exports =

  config:
    accentColor:
      description: 'Set a color that will influence accents in the theme'
      type: 'color'
      default: '#d2372b'
    useSyntax:
        description: 'Override the gutter, background, and selection colours'
        type: 'boolean'
        default: 'true'

  activate: (state) ->
    atom.themes.onDidChangeActiveThemes ->
      Config = require './config'
      Config.apply()
