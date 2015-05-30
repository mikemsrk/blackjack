class window.CardView extends Backbone.View
  className: 'card'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.attr('style','background-image: url(img/cards/' + @model.get('rankName') + '-' + @model.get('suitName').toLowerCase() + '.png)')
    @$el.attr('style', 'background-image: url(img/card-back.png)') if !@model.get('revealed')
    @$el.addClass 'covered' unless @model.get 'revealed'

