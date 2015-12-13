{CompositeDisposable} = require 'atom'
module.exports = semicol =
  subscriptions: null
  config:
    lang:
      title: 'Supported languages'
      description: 'Type the languages you want to apply this package to'
      type: 'array'
      default: ['JavaScript', 'Java']
      items:
        type: 'string'

  activate: ->
    positions = []
    supportedLanguages = atom.config.get('semicol.lang')
    atom.workspace.observeTextEditors (editor) ->
      if editor.getGrammar().name in supportedLanguages
        @subscriptions = new CompositeDisposable
        @subscriptions.add editor.onWillInsertText ({cancel, text}) =>
          console.log 'text', text
          char = text
          editorView = atom.views.getView(editor)
          position = editor.getCursorBufferPosition()
          console.log 'position', position
          if char == ';'
            positions.push(editor.getCursorBufferPosition())
            if positions.length == 1
              editor.moveToEndOfLine()
            else
              editor.moveToEndOfLine()
              editor.moveLeft()
              editor.delete()
              editor.setCursorScreenPosition(positions[0])
              positions = []
          else
            positions = []

  deactivate: ->
    @subscriptions.dispose()
