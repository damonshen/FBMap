initialize = ->
  mapOptions =
    center: new google.maps.LatLng(-34.397, 150.644)
    zoom: 8
    mapTypeId: google.maps.MapTypeId.ROADMAP
  map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions)
###
FB.login(
  (response) ->
    console.log response
  {scope: 'email,user_likes'}
)
###

getFriends = () ->
  FB.api(
    {
      method: 'fql.query'
      query: 'select name from profile where id in (select uid2 from friend where uid1 = me())'
    },
    (response)->
      data = JSON.stringify(response)
      console.log(data)
  )

getFriendsBygraph = ()->
  FB.api(
    '/me/friends',
    (response)->
      data = JSON.stringify(response)
      console.log(data)
  )

getCheckins = () ->
  FB.api(
    {
      method: 'fql.query'
      query: 'select message, description, type, actor_id from stream where source_id in ( SELECT uid2 from friend where uid1 = me())'
    },
    (response)->
      data = JSON.stringify(response)
      console.log(data)
  )


getPermission = ()->
  FB.api('/me/permissions',
    (response) ->
      console.log(response)
      data = JSON.stringify(response)
      console.log(data)
  )


$('#get-checkins').click ()->
  getCheckins()
