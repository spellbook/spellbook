Spellbook.Services.shortcut
===========================

Markup
------

First, add a `data-shortcut` for the keyboard shortcut you want:

```html
<a href="/about" class="btn" data-shortcut="1">About</a>
```

Now, when you hit `1` on the keyboard, it will click this button.

JavaScript (CoffeeScript)
-------------------------

```coffeescript
Spellbook.Services.shortcut()
```

