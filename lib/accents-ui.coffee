Config = require './config'

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
        fontSize:
            description: 'Set the global font size for this theme. A bit finicky at the moment, can sometimes take a few reloads to see changes.'
            type: 'integer'
            default: 12
            minimum: 8
            maximum: 24
        useSyntax:
            description: 'Override the gutter, background, and selection colours'
            type: 'boolean'
            default: 'true'

    activate: (state) ->
        atom.themes.onDidChangeActiveThemes ->
            Config.apply()
