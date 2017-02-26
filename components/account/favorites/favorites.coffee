FlowRouter.route '/account/favorites/', action: (params) ->
    BlazeLayout.render 'layout',
        sub_nav: 'account_nav'
        main: 'favorites'

if Meteor.isClient
    # bands
    Template.favorite_bands.onCreated ->
        @autorun -> Meteor.subscribe 'favorite_bands'
    
    Template.favorite_bands.helpers
        favorite_bands: ->
            Docs.find
                type: 'band'
                # favoriters: $in: [@userId] 
    
    # festivals
    Template.favorite_festivals.onCreated ->
        @autorun -> Meteor.subscribe 'favorite_festivals'
    
    Template.favorite_festivals.helpers
        favorite_festivals: -> 
            Docs.find
                type: 'festival'
                # favoriters: $in: [@userId] 
    


if Meteor.isServer
    Meteor.publish 'favorite_bands', ->
        Docs.find
            type: 'band'
            favoriters: $in: [@userId]
            
    Meteor.publish 'favorite_festivals', ->
        Docs.find
            type: 'festival'
            favoriters: $in: [@userId]
            
            
            