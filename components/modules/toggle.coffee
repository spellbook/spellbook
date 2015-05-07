# *************************************
#
#   Toggle
#   -> Toggle state on given elements
#
# *************************************
#
# @param $element     { jQuery object }
# @param proximity    { string }
# @param event        { string }
# @param toggleClass  { string }
# @param activeClass  { string }
# @param initialState { function }
# @param onClick      { function }
# @param onMouseover  { function }
# @param onMouseout   { function }
#
# *************************************

@Spellbook.Modules.Toggle = do ->

  # -------------------------------------
  #   Private Variables
  # -------------------------------------

  _settings = {}

  # -------------------------------------
  #   Initialize
  # -------------------------------------

  init = ( options ) ->
    _settings = $.extend
      $element     : $( '.js-toggle' )
      proximity    : 'next' # prev, parent, nextParent, prevParent, $( '.element' ), '> span'
      event        : 'click' # hover
      toggleClass  : 'is-hidden'
      activeClass  : 'is-active'
      initialState : null
      onClick      : null
      onMouseover  : null
      onMouseout   : null
    , options

    _setEventHandlers()

  # -------------------------------------
  #   Set Event Handlers
  # -------------------------------------

  _setEventHandlers = ->
    switch _settings.event
      when 'click' then _handleClickEvent()
      when 'hover' then _handleHoverEvent()

  # -------------------------------------
  #   Handle Click Event
  # -------------------------------------

  _handleClickEvent = ->
    _settings.$element.on 'click', ( event ) ->
      event.preventDefault()
      $element = $(@)

      _settings.onClick( _settings ) if _settings.onClick?

      _settings.$element.toggleClass( _settings.activeClass )

      switch _settings.proximity
        when 'next'
          $element
            .next()
            .toggleClass( _settings.toggleClass )
        when 'prev'
          $element
            .prev()
            .toggleClass( _settings.toggleClass )
        when 'nextParent'
          $element
            .parent()
            .next()
            .toggleClass( _settings.toggleClass )
        when 'prevParent'
          $element
            .parent()
            .prev()
            .toggleClass( _settings.toggleClass )
        else
          if typeof _settings.proximity is 'object'
            _settings.proximity
              .toggleClass( _settings.toggleClass )
          else
            $element
              .find( _settings.proximity )
              .toggleClass( _settings.toggleClass )

  # -------------------------------------
  #   Handle Hover Event
  # -------------------------------------

  _handleHoverEvent = ->
    _settings.initialState( _settings ) if _settings.initialState

    _settings.$element.on
      mouseenter: -> _handleHoverStateEvent( $(@), 'on' )
      mouseleave: -> _handleHoverStateEvent( $(@), 'off' )

  # -------------------------------------
  #   Toggle Class
  # -------------------------------------
  #
  # @param $element      { object }
  # @param classToToggle { string }
  #
  # -------------------------------------

  _toggleClass = ( $element, classToToggle = _settings.toggleClass ) ->
    if $element.hasClass( classToToggle )
      $element.removeClass( classToToggle )
    else
      $element.addClass( classToToggle )

  # -------------------------------------
  #   Handle Hover State Event
  # -------------------------------------
  #
  # @param $element { object }
  # @param state    { string }
  #
  # -------------------------------------

  _handleHoverStateEvent = ( $element, state ) ->
    switch state
      when 'on'  then $element.addClass( _settings.activeClass )
      when 'off' then $element.removeClass( _settings.activeClass )

    switch _settings.proximity
      when 'next'
        _toggleClass( $element.next() )
      when 'prev'
        _toggleClass( $element.prev() )
      when 'nextParent'
        _toggleClass( $element.parent().next() )
      when 'prevParent'
        _toggleClass( $element.parent().prev() )
      else
        if typeof _settings.proximity is 'object'
          _toggleClass( _settings.proximity )
        else
          _toggleClass( $element.find( _settings.proximity) )

  # -------------------------------------
  #   Public Methods
  # -------------------------------------

  init : init

# -------------------------------------
#   Usage
# -------------------------------------
#
# Spellbook.Modules.Toggle.init()
#
