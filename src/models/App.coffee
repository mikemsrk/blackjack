# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  defaults:
    playerScore: 0
    dealerScore: 0

  lose: -> alert('You lose fatboy')
  win: -> alert('You win fatboy')
  newGame: ->
    context = this
    context.get('playerHand').reset()
    context.get('dealerHand').reset()
    context.set('deck', deck = new Deck())
    context.get('playerHand').hit()
    context.get('playerHand').hit()
    context.get('dealerHand').hit()
    context.get('dealerHand').at(0).flip()
    context.get('dealerHand').hit()

  check: ->
    ps = @get('playerScore')
    ds = @get('dealerScore')

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
    ps = @get('playerScore')
    ds = @get('dealerScore')

    if ps == ds
      @lose()
      @newGame()
    else if ds > ps
      @lose()
      @newGame()
    else if ps > ds
      @win()
      @newGame()
