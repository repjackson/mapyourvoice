if Meteor.isClient
    Template.favorite_button.helpers
        favorite_count: -> Template.parentData(0).favorite_count
        
        favorite_item_class: -> 
            if Meteor.userId()
                if Template.parentData(0).favoriters and Meteor.userId() in Template.parentData(0).favoriters then 'red' else 'outline'
            else 'grey disabled'
        
    Template.favorite_button.events
        'click .favorite_item': -> 
            if Meteor.userId() then Meteor.call 'favorite', Template.parentData(0)
            else FlowRouter.go '/sign-in'




Meteor.methods
    favorite: (doc)->
        if doc.favoriters and Meteor.userId() in doc.favoriters
            Docs.update doc._id,
                $pull: favoriters: Meteor.userId()
                $inc: favorite_count: -1
        else
            Docs.update doc._id,
                $addToSet: favoriters: Meteor.userId()
                $inc: favorite_count: 1
