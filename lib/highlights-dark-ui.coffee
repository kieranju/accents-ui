module.exports =

  config:
    accentColor:
      description: 'Set a color that will influence accents in the theme'
      type: 'color'
      default: '#d2372b'

  activate: (state) ->
    atom.themes.onDidChangeActiveThemes ->
      Config = require './config'
      Config.apply()
