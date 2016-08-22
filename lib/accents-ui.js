module.exports = {
    config: {
        accentColor: {
            description: 'Set a color that will influence accents in the theme',
            type: 'color',
            'default': '#d2372b',
        },
        accentHex: {
            description: 'Set an accent color by hex value (cannot be shorthand, use #rrggbb)',
            type: 'string',
            'default': '#d2372b',
        },
        scale: {
            description: 'Set the global scaling; affects all ui elements',
            type: 'number',
            'default': 1,
            minimum: 0.5,
            maximum: 2,
        },
        useSyntax: {
            description: 'Override the gutter, background, and selection colours',
            type: 'boolean',
            'default': 'true',
        },
    },
    activate: function () {
        require('./config');
    },
};
