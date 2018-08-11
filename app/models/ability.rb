class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can [:read], List , :all

      # Can create and read lists,
      # can [:create, :read], List

      # Can remove/update and assign/unassign members his own lists,
      can [:update, :destroy,:assign_member, :unassign_member], List do |list|
        list.creator == user
      end

      # Admin Can Create Cards on any list,
      can [:create, :read], Card

      can [:update, :destroy], Card do |card|
        (card.user == user) || (card.list.creator == user)
      end

      can [:create, :read], Comment

      can [:update, :destroy], Comment do |comment|
        comment.user == user || comment.card.list.creator == user
      end
      
    else
      can :read, List, creator_id: user.id

      cannot [:create, :update, :destroy], List

      can [:create, :read], Card  do |card|
        card.list.users.include? user
      end

      can [:update, :destroy], Card do |card|
        card.user == user
      end

      can [:create, :read], Comment do |comment|
        comment.card.list.users.find(user.id) == user
      end
      can [:update, :destroy], Comment do |comment|
        comment.user == user
      end
    end
  end
end
