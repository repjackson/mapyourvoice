
FlowRouter.route '/band/view/:doc_id', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'band_page'



if Meteor.isClient
    Template.band_page.onCreated ->
        self = @
        self.autorun ->
            self.subscribe 'doc', FlowRouter.getParam('doc_id')
    
    
    
    Template.band_page.helpers
        band: ->
            Docs.findOne FlowRouter.getParam('doc_id')
    

    
    Template.band_page.events
        'click .edit': ->
            doc_id = FlowRouter.getParam('doc_id')
            FlowRouter.go "/band/edit/#{doc_id}"
