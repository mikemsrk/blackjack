class window.AppView extends Backbone.View
  template: _.template '
    <div class="chips"> Chimps: <%= chips %> </div>
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': 'hit'
    'click .stand-button': 'stand'

  hit: ->
    @model.get('playerHand').hit()
    @model.set('playerScore',@model.get('playerHand').scores())
    @model.set('dealerScore',@model.get('dealerHand').scores())
    @model.check()

  stand: ->
    @model.get('playerHand').stand() # doesn't do anything.
    @model.get('dealerHand').flip()
    @model.set('playerScore',@model.get('playerHand').scores())
    @model.set('dealerScore',@model.get('dealerHand').scores())
    @model.standCheck()

  bet: ->
    amount = prompt("How many chimps, fatboy?")
    @model.bet(amount)

  initialize: ->
    @model.on('change:chips',this.render,this)
    @render()
    @bet()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template(@model.attributes)
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

