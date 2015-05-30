assert = chai.assert

describe "deck constructor", ->

  it "should create a card collection", ->
    collection = new Deck()
    assert.strictEqual collection.length, 52

describe "card", ->

  collection = new Deck()

  describe "reveal", ->
    it "should have revealed property", ->
      assert.strictEqual collection.first().get('revealed'), true

  describe "flip", ->
    it "should be able to flip card", ->
      collection.first().flip()
      assert.strictEqual collection.first().get('revealed'), false
    it "should flip back", ->
      collection.first().flip()
      assert.strictEqual collection.first().get('revealed'), true
