var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

this.Spellbook.Classes.Dematerialize = (function(superClass) {
  extend(Dematerialize, superClass);

  function Dematerialize() {
    return Dematerialize.__super__.constructor.apply(this, arguments);
  }

  Dematerialize.prototype._item = '';

  Dematerialize.prototype.init = function() {
    this._setDefaults({
      $element: $('.js-dematerialize'),
      $trigger: $('.js-dematerialize-trigger'),
      itemTitle: 'hidden_element',
      hiddenClass: 'is-hidden'
    });
    this._setEventHandlers();
    return this._setInitialState();
  };

  Dematerialize.prototype._setEventHandlers = function() {
    if (this._settings.$trigger instanceof jQuery) {
      return this._settings.$trigger.on('click', (function(_this) {
        return function(event) {
          event.preventDefault();
          return _this._toggleState();
        };
      })(this));
    } else {
      return this._toggleStateViaKey();
    }
  };

  Dematerialize.prototype._setInitialState = function() {
    this._item = localStorage.getItem(this._settings.itemTitle);
    if (this._item !== 'true') {
      return this._settings.$element.removeClass(this._settings.hiddenClass);
    }
  };

  Dematerialize.prototype._toggleState = function() {
    if (!this._settings.$element.hasClass(this._settings.hiddenClass)) {
      this._settings.$element.addClass(this._settings.hiddenClass);
      return this._item = localStorage.setItem(this._settings.itemTitle, 'true');
    } else {
      this._settings.$element.removeClass(this._settings.hiddenClass);
      return this._item = localStorage.removeItem(this._settings.itemTitle);
    }
  };

  Dematerialize.prototype._toggleStateViaKey = function() {
    return $(document).on('keyup', (function(_this) {
      return function(event) {
        var tag;
        tag = event.target.tagName.toLowerCase();
        switch (event.which) {
          case _this._settings.$trigger:
            if (!(tag === 'input' || tag === 'textarea')) {
              return _this._toggleState();
            }
        }
      };
    })(this));
  };

  return Dematerialize;

})(Spellbook.Classes.Base);
