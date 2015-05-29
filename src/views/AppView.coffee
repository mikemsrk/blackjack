class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': 'hit'
    'click .stand-button': 'stand'

  hit: ->
    @model.get('playerHand').hit()
    @model.set('playerScore',@model.get('playerHand').scores()[0])
    @model.set('dealerScore',@model.get('dealerHand').scores()[0])
    @model.check()

  stand: ->
    @model.get('playerHand').stand() # doesn't do anything.
    @model.get('dealerHand').flip()
    @model.set('playerScore',@model.get('playerHand').scores()[0])
    @model.set('dealerScore',@model.get('dealerHand').scores()[0])
    @model.standCheck()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

