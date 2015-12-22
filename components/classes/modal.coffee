# *************************************
#
#   Modal
#   -> Trigger a dialog window
#
# *************************************
#
# @param $close          { jQuery object }
# @param $trigger        { jQuery object }
# @param classActive     { string }
# @param classBackdrop   { string }
# @param classBodyActive { string }
# @param classInactive   { string }
# @param dataAttr        { string }
#
# *************************************

class @Spellbook.Classes.Modal extends Spellbook.Classes.Base

  # -------------------------------------
  #   Private Variables
  # -------------------------------------

  _$modal    : null
  _$backdrop : null

  # -------------------------------------
  #   Initialize
  # -------------------------------------

  init : ->
    @_setDefaults
      $close          : $( '.js-modal-close' )
      $trigger        : $( '.js-modal-trigger' )
      classActive     : 'is-active'
      classBackdrop   : 'modal-backdrop'
      classBodyActive : 'is-modal-active'
      classInactive   : 'is-inactive'
      dataAttr        : 'modal'

    @_setEventHandlers()

  # -------------------------------------
  #   Trigger
  # -------------------------------------
  #
  # @param $element       { jQuery object }
  # @param event          { string }
  # @param removeBackdrop { boolean }
  # @param callback       { function }
  #
  # -------------------------------------

  trigger : ( $element, event, removeBackdrop = false, callback = null ) ->
    @_$modal = $element

    switch event

      when 'open'

        $element.addClass( @_settings.classActive )
        $( 'body' ).addClass( @_settings.classBodyActive )

      when 'close'

        $element.removeClass( @_settings.classActive )
        $( 'body' ).removeClass( @_settings.classBodyActive )

        @_cleanupEvents()

    @_toggleOverlay( event ) unless removeBackdrop

    callback?()

    @_setActiveEventHandlers()

  # -------------------------------------
  #   Toggle Overlay
  # -------------------------------------

  _toggleOverlay : ( event ) ->
    switch event

      when 'open'

        $( '<div class=' + @_settings.classBackdrop + '></div>' )
          .appendTo( $( 'body' ) )

        @_$backdrop = $( ".#{ @_settings.classBackdrop }" )

        setTimeout =>
          @_$backdrop.addClass( @_settings.classActive )
        , 25

      when 'close'

        @_$backdrop.removeClass( @_settings.classActive )

        setTimeout =>
          @_$backdrop.remove()
        , 500

  # -------------------------------------
  #   Set Event Handlers
  # -------------------------------------

  _setEventHandlers : ->
    @_settings.$trigger.on 'click', ( event ) =>
      event.preventDefault()

      selector = $( event.currentTarget ).data( @_settings.dataAttr )
      @_$modal = $( selector )

      @trigger( @_$modal, 'open' )

  # -------------------------------------
  #   Set Active Event Handlers
  # -------------------------------------

  _setActiveEventHandlers : ->

    # ----- Close ----- #

    @_settings.$close.on 'click', ( event ) =>
      event.preventDefault()
      @trigger( @_$modal, 'close' )

    # ----- Backdrop ----- #

    @_$backdrop.on 'click', ( event ) =>
      @trigger( @_$modal, 'close' )

    # ----- Escape ----- #

    $( document ).on 'keydown', ( event ) =>
      switch event.which
        when 27 then @trigger( @_$modal, 'close' )

  # -------------------------------------
  #   Clean Up Events
  # -------------------------------------

  _cleanupEvents : ->
    @_settings.$close.off( 'click' )
    $( document ).off( 'keydown' )

# -------------------------------------
#   Usage
# -------------------------------------
#
# new Spellbook.Classes.Modal()
#
