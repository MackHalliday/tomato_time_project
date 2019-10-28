class Match < ApplicationRecord

  def self.create(id)
    if !REDIS.get("matches").blank?
      # Get the id of the player waiting
      opponent = REDIS.get("matches")

      Game.start(id, opponent)
      # Clear the waiting key as no one new is waiting
      REDIS.set("matches", nil)
    else
      REDIS.set("matches", id)
    end
  end

  def self.remove(id)
    if id == REDIS.get("matches")
      REDIS.set("matches", nil)
    end
  end

  def self.clear_all
    REDIS.del("matches")
  end
end
