assert = chai.assert

describe 'deck', ->
  deck = null
  hand = null
  dealerHand = null

  beforeEach ->
    deck = new Deck()
    hand = deck.dealPlayer()
    dealerHand = deck.dealDealer()

  describe 'hit', ->
    it 'should give the last card from the deck', ->
      assert.strictEqual deck.length, 48
      assert.strictEqual deck.last(), hand.hit()
      assert.strictEqual deck.length, 47

  describe 'deal', ->
    it 'should deal the player 2 cards from deck', ->
      assert.strictEqual hand.length, 2
    it 'should deal the dealer 2 cards from the deck', ->
      assert.strictEqual dealerHand.length, 2
    it 'should flip the dealer\'s first card', ->
      assert.strictEqual dealerHand.at(0).get('revealed'), false

  describe 'hands', ->
    it 'should check if it has an ace', ->
      hand.reset()
      hand.add(new Card({value:12}))
      hand.at(0).set('value',1)
      assert.strictEqual hand.hasAce(), true
    it 'should return the score from the hand', ->
      score = hand.scores()[0]
      assert.strictEqual hand.scores()[0], score
      hand.hit()
      assert.strictEqual hand.scores()[0], score + hand.last().get('value')
    it 'should return two different scores for an ace', ->
      hand.reset()
      hand.add(new Card({value:12}))
      hand.at(0).set('value',1)
      score = hand.scores()[0]
      assert.strictEqual hand.scores()[0], score
      assert.strictEqual hand.scores()[1], score+10



