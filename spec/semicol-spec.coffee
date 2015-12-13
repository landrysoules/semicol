Semicol = require '../lib/semicol'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Semicol", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('semicol')

  describe "when typing a semi-colon in the middle of a line", ->
    it "move the semicolon to the end of the line", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      waitsForPromise ->
        atom.workspace.open('Test.java').then (editor) ->
          # TODO: get opened file content

    it "don't move semicolon if previous typed character was already semicolon", ->
    
