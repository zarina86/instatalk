class UserOnlineOfflineService
  def initialize(users)
    @users = users
  end

  def perform
    broadcast_online
  end

  private

  def broadcast_online
    ActionCable.server.broadcast 'user_online_offline_channel',
                                 user: @users
  end
end