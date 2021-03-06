describe('Spellbook.Classes.Dispatcher', function() {
  beforeEach(function() {
    loadFixtures('dispatcher.html');
    this.element = $('.js-dispatcher');
    this.dataAttr = 'dispatcher-page';
    return new Spellbook.Classes.Dispatcher({
      events: [
        {
          page: 'home',
          run: function() {
            return $('#home').addClass('is-active');
          }
        }, {
          page: 'about',
          run: function() {
            return $('#about').addClass('is-active');
          }
        }, {
          page: 'contact',
          run: function() {
            return $('#contact').addClass('is-active');
          }
        }
      ]
    });
  });
  it('should add an active class to the home container when on the home page', function() {
    return expect($('#home')).toHaveClass('is-active');
  });
  return it('should add an active class to all containers', function() {
    new Spellbook.Classes.Dispatcher({
      events: [
        {
          page: 'all',
          run: function() {
            $('#home').addClass('is-active');
            $('#about').addClass('is-active');
            return $('#contact').addClass('is-active');
          }
        }
      ]
    });
    expect($('#home')).toHaveClass('is-active');
    expect($('#about')).toHaveClass('is-active');
    return expect($('#contact')).toHaveClass('is-active');
  });
});
