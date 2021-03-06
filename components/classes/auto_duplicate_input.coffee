# *************************************
#
#   Auto Duplicate Input
#   -> Duplicate valid inputs as you go
#
# *************************************
#
# @param $element              { jQuery object }
# @param $container            { jQuery object }
# @param clonedDataAttribute   { string }
# @param validateDataAttribute { string }
# @param invalidClass          { string }
# @param validClass            { string }
# @param onDuplicate           { function }
# @param onInvalid             { function }
# @param onValid               { function }
#
# *************************************

class @Spellbook.Classes.AutoDuplicateInput extends Spellbook.Classes.Base

  # -------------------------------------
  #   Private Variables
  # -------------------------------------

  _count      : 0
  _field      : null
  _validators :
    email : /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

  # -------------------------------------
  #   Initialize
  # -------------------------------------

  init : ->
    @_setDefaults
      $element              : $( '.js-autoDuplicateInput' )
      $container            : $( '.js-autoDuplicateInput-container' )
      clonedDataAttribute   : 'cloned'
      validateDataAttribute : 'validate'
      invalidClass          : 'is-invalid'
      validClass            : 'is-valid'
      onDuplicate           : null
      onInvalid             : null
      onValid               : null

    @_setEventHandlers()

  # -------------------------------------
  #   Set Event Handlers
  # -------------------------------------

  _setEventHandlers : ->
    @_settings.$element.on 'keyup', ( event ) =>
      event.preventDefault()

      @_field = $( event.currentTarget )

      if @_isValid()
        @_setInputState( 'valid' )
        @_settings.onValid?( @_settings )

        @_duplicate() unless @_field.data( 'cloned' ) is 'true'
        @_settings.onDuplicate?( @_settings, @_count )
      else
        @_setInputState( 'invalid' )
        @_settings.onInvalid?( @_settings )

  # -------------------------------------
  #   Get Validation Type
  # -------------------------------------

  _getValidationType : ->
    @_field.data( @_settings.validateDataAttribute )

  # -------------------------------------
  #   Is Valid
  # -------------------------------------

  _isValid :  ->
    validator = @_getValidationType( @_field )

    @_validators[ "#{ validator }" ].test( @_field.val() )

  # -------------------------------------
  #   Duplicate
  # -------------------------------------

  _duplicate : ->
    ++ @_count

    @_field
      .data( @_settings.clonedDataAttribute, 'true' )
      .clone( true )
      .appendTo( @_settings.$container )
      .removeClass( @_settings.validClass )
      .val( '' )
      .data( @_settings.clonedDataAttribute, '' )

  # -------------------------------------
  #   Set Input State
  # -------------------------------------

  _setInputState : ( type ) ->
    switch type
      when 'invalid'
        @_field
          .removeClass( @_settings.validClass )
          .addClass( @_settings.invalidClass )
      when 'valid'
        @_field
          .removeClass( @_settings.invalidClass )
          .addClass( @_settings.validClass )

  # -------------------------------------
  #   Get Count
  # -------------------------------------

  getCount : -> return @_count

# -------------------------------------
#   Usage
# -------------------------------------
#
# new Spellbook.Classes.AutoDuplicateInput()
#
