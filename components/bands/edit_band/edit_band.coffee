FlowRouter.route '/band/edit/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'edit_band'



if Meteor.isClient
    Template.edit_band.onCreated ->
        self = @
        self.autorun ->
            self.subscribe 'doc', FlowRouter.getParam('doc_id')
    
    
    Template.edit_band.helpers
        band: ->
            Docs.findOne FlowRouter.getParam('doc_id')
        
    
            
            
    Template.edit_band.events
        'click #save': ->

            FlowRouter.go "/band/view/#{FlowRouter.getParam('doc_id')}"
