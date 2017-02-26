if Meteor.isClient
    Template.featured_bands.onCreated -> 
        @autorun -> Meteor.subscribe 'featured_bands'

    Template.featured_bands.helpers
        featured_bands: -> 
            Docs.find 
                type: 'band'
    
        tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else 'basic'


    
    Template.band_item.helpers
        is_author: -> Meteor.userId() and @author_id is Meteor.userId()
    
        tag_class: -> if @valueOf() in selected_tags.array() then 'primary' else 'basic'
    
        when: -> moment(@timestamp).fromNow()

    Template.band_item.events
        'click .tag': -> if @valueOf() in selected_tags.array() then selected_tags.remove(@valueOf()) else selected_tags.push(@valueOf())
    
    Template.featured_bands.events
        'click #add_band': ->
            Meteor.call 'add_band', (err,id)->
                FlowRouter.go "/edit_band/#{id}"



if Meteor.isServer
    Meteor.publish 'featured_bands', ->
    
        self = @
        match = {}
        match.type = 'band'
        match.featured = true
    
        Docs.find match,
            limit: 3
    
    
    
