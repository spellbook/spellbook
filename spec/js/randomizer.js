describe('Spellbook.randomizer', function() {
  return it('should return a random value from a collection', function() {
    var collection;
    collection = ['one', 'two', 'three'];
    return expect(Spellbook.randomizer(collection)).toMatch(/one|two|three/);
  });
});
