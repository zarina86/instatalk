class UserOnlineOfflineChannel < ApplicationCable::Channel
  def subscribed
    @list_name = 'current_users_nicknames'

    stream_from 'user_online_offline_channel'

    $redis.rpush(@list_name, nickname)
    appear
  end

  def unsubscribed
    $redis.lrem(@list_name, 1, nickname)
    appear
  end

  def appear
    @users = nicknames_list
    broadcast
  end

  private

  def nicknames_list
    $redis.lrange(@list_name, 0, -1)
  end

  def broadcast
    ActionCable.server.broadcast('user_online_offline_channel', {users: @users.uniq})
  end

  def nickname
    current_user.nickname
  end
end
