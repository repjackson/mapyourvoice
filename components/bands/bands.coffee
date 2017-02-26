FlowRouter.route '/bands', action: (params) ->
    BlazeLayout.render 'layout',
        # cloud: 'cloud'
        main: 'bands'



if Meteor.isClient
    Template.bands.onCreated -> 
        @autorun -> Meteor.subscribe('bands', selected_tags.array())

    Template.bands.helpers
        bands: -> 
            Docs.find
                type: 'band'
    
        tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else 'basic'


    
    Template.band_item.helpers
        is_author: -> Meteor.userId() and @author_id is Meteor.userId()
    
        tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else 'basic'
    
        when: -> moment(@timestamp).fromNow()

    Template.band_item.events
        'click .tag': -> if @valueOf() in selected_tags.array() then selected_tags.remove(@valueOf()) else selected_tags.push(@valueOf())
    
    Template.bands.events
        'click #add_band': ->
            Meteor.call 'add_band', (err,id)->
                FlowRouter.go "/band/edit/#{id}"



if Meteor.isServer
    Meteor.methods
        add_band: ->
            id = Docs.insert
                type: 'band'
            return id
    
    
    
    Meteor.publish 'bands', (selected_tags)->
    
        self = @
        match = {}
        if selected_tags.length > 0 then match.tags = $all: selected_tags
        match.type = 'band'
    
        Docs.find match
    