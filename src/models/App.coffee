# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  lose: -> alert('You lose fatboy')
  win: -> alert('You win fatboy')


  dealerTurn: ->
    # check his cards
    ds = @get('dealerHand').scores()
    # while ds < 16
    while(ds[0] < 16)
      @get('dealerHand').hit()
      ds = @get('dealerHand').scores()


  newGame: ->
    context = this
    context.get('playerHand').reset()
    context.get('dealerHand').reset()
    context.set('deck', deck = new Deck())
    context.get('playerHand').deck = deck
    context.get('dealerHand').deck = deck

    context.get('playerHand').hit()
    context.get('playerHand').hit()
    context.get('dealerHand').hit()
    context.get('dealerHand').at(0).flip()
    context.get('dealerHand').hit()

    @bjcheck()

  bjcheck: ->
    ps = @get('playerHand').scores()[0]
    ps2 = @get('playerHand').scores()[1]
    ds = @get('dealerHand').scores()[0]
    if ps2 == 21 and ds != 21
      @win()
      @newGame()


  check: ->
    ps = @get('playerHand').scores()[0]
    ds = @get('dealerHand').scores()[0]

    if ps == 21 and ds == 21
      @lose()
      @newGame()
    else if ds == 21
      @lose()
      @newGame()
    else if ps == 21
      @win()
      @newGame()
    else if ds > 21
      @win()
      @newGame()
    else if ps > 21
      @lose()
      @newGame()

  standCheck: ->
    @dealerTurn()
    ps = @get('playerHand').scores()[0]
    ds = @get('dealerHand').scores()[0]

    if ps == ds
      @lose()
      @newGame()
    else if ds > 21
      @win()
      @newGame()
    else if ds > ps
      @lose()
      @newGame()
    else if ps > ds
      @win()
      @newGame()
