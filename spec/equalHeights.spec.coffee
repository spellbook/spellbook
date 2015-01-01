describe 'Spellbook.equalHeights', ->
  beforeEach ->
    loadFixtures('equal_heights.html')

    @element = $('.js-equalHeight')

    Spellbook.equalHeights.init()

  it 'should set equal heights on the elements', ->
    expect(@element).toHaveProp('style')
