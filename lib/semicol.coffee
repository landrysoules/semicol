{CompositeDisposable} = require 'atom'
module.exports = semicol =
  positions: []
  subscriptions: null
  config:
    lang:
      title: 'Supported languages'
      description: 'Type the languages you want to apply this package to'
      type: 'array'
      default: ['JavaScript', 'Java', 'TypeScript']
      items:
        type: 'string'

  activate: ->
    supportedLanguages = atom.config.get('semicol.lang')
    atom.workspace.observeTextEditors (editor) =>
      if editor.getGrammar().name in supportedLanguages
        @subscriptions = new CompositeDisposable
        @subscriptions.add editor.onWillInsertText ({cancel, text}) =>
          this.go(editor, text)

  deactivate: ->
    @subscriptions.dispose()

  go: (editor, text) ->
    char = text
    position = editor.getCursorBufferPosition()
    if char == ';'
      @positions.push(position)
      if @positions.length == 1
        editor.moveToEndOfLine()
      else
        if @positions[0].row == @positions[1].row
          editor.moveToEndOfLine()
          editor.moveLeft()
          editor.delete()
          editor.setCursorScreenPosition(@positions[0])
          @positions = []
        else
          @positions = []
          this.go(editor, text)
    else
      @positions = []
