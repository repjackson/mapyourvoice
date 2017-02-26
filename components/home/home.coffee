FlowRouter.route '/', action: (params) ->
    BlazeLayout.render 'layout',
        main: 'home'


if Meteor.isClient
    Template.home.onRendered ->
        # L.Icon.Default.imagePath = '/packages/bevanhunt_leaflet/images/'
        # map = L.map('map')
        # L.tileLayer.provider('Stamen.Watercolor').addTo(map);

        # GoogleMaps.load()
        
        
        map = L.map('map').setView([
                51.505
                -0.09
            ], 13)
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors').addTo map
        L.marker([
            51.5
            -0.09
        ]).addTo(map).bindPopup('A pretty CSS3 popup.<br> Easily customizable.').openPopup()

    

    Template.home.onCreated ->
        # GoogleMaps.ready 'exampleMap', (map) ->
        #     marker = new (google.maps.Marker)(
        #         position: map.options.center
        #         map: map.instance)

    Template.home.helpers
        # exampleMapOptions: ->
        #     if GoogleMaps.loaded()
        #         return {
        #             center: new (google.maps.LatLng)(-37.8136, 144.9631)
        #             zoom: 8
        #         }