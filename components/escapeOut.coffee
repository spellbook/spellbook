# *************************************
#
#   Escape Out
#   -> Run a function when escape key is hit
#
# *************************************
#
# options.run - the function to run
#
# *************************************

@Spellbook.escapeOut = (options) ->
  $(document).on 'keyup', (event) ->
    switch event.which
      when 27 then options.run()

# -------------------------------------
#   Usage
# -------------------------------------
#
# Spellbook.escapeOut
#   run: ->
#     # ...
#
