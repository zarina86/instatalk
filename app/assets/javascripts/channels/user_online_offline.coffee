App.user_online_offline = App.cable.subscriptions.create "UserOnlineOfflineChannel",
  connected: ->
    console.log("connected to online channel")
    
  disconnected: ->
    console.log("diconnected to online channel")
    

  received: (data) ->
    console.log(data)
    users = data['users'].map (nickname) -> "<span>#{nickname}</span>"
    $('#online').html(users.join(", "))
    
