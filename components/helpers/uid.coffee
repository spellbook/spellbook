# *************************************
#
#   UID
#   -> Generate a unique ID
#      Credit: http://coffeescriptcookbook.com/chapters/strings/generating-a-unique-id
#
# *************************************
#
# @param length { integer }
#
# *************************************

@Spellbook.Helpers.uid = ( length = 10 ) ->
  id = ''

  while id.length < length
    id += Math.random().toString( 36 ).substr( 2 )

  id.substr( 0, length )

# -------------------------------------
#   Usage
# -------------------------------------
#
# Spellbook.Helpers.uid( 10 )
#
