assert = chai.assert

describe "blackjack", ->

  app = null
  deck = null
  hand = null
  dealerHand = null

  beforeEach ->
    app = new App()
    deck = app.get('deck')
    hand = app.get('playerHand')
    dealerHand = app.get('dealerHand')

  describe "initialize", ->
    it "should start game", ->
      assert.strictEqual deck.length, 48
    it "should give player 2 cards", ->
      assert.strictEqual hand.length, 2
    it "should give dealer 2 cards", ->
      assert.strictEqual dealerHand.length, 2
    it "should flip dealer's first card", ->
      assert.strictEqual dealerHand.at(0).get('revealed'), false

  describe "bust", ->
    it "should bust if player is over 21", ->
      hand.at(0).set('value',10)
      hand.at(1).set('value',10)
      hand.hit()
      hand.hit()
      assert.strictEqual hand.scores()[0] > 21, true

    it "should bust if dealer is over 21", ->
      dealerHand.at(0).set('value',10)
      dealerHand.at(0).set('revealed',true)
      dealerHand.at(1).set('value',10)
      dealerHand.hit()
      dealerHand.hit()
      assert.strictEqual dealerHand.scores()[0] > 21, true

  describe "dealer logic", ->
    it "should hit if player stands", ->
      ds = dealerHand.scores()[0]
      app.dealerTurn()
      assert.strictEqual dealerHand.scores()[0] > ds, true


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
