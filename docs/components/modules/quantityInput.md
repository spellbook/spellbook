Spellbook.Modules.QuantityInput
===============================

Markup
------

```haml
%h1
  %span.js-quantityInput-target $29
  %b Per Month

%form(action="")
  %fieldset.js-quantityInput-field
    %a.js-quantityInput-decrease(href="#") Decrease
    %input.js-quantityInput(type="text" value="1")
    %a.js-quantityInput-increase(href="#") Increase
```

JavaScript (CoffeeScript)
-------------------------

```coffeescript
Spellbook.Modules.QuantityInput.init()
```