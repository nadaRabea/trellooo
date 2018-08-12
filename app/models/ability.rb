class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can [:read], List , :all

      # Can create and read lists,
      can [:create, :read], List

      # Can remove/update and assign/unassign members his own lists,
      can [:update, :destroy, :assign_member, :unassign_member], List do |list|
        list.creator == user
      end

      # Can Create Cards on any list,
      can [:create, :read], Card

      # Can remove/update his own cards and any
      # other card in his own lists
      can [:update, :destroy], Card do |card|
        (card.user == user) || (card.list.creator == user)
      end

      # Can create a comment any where, can read all comments
      can [:create, :read], Comment

      # Can update/remove his own comments and any other comment on
      # his own lists,
      can [:update, :destroy], Comment do |comment|
        comment.user == user || comment.commentable.list.creator == user || comment.commentable.commentable.list.creator == user
      end
      
    else
      # can access only lists assigned to member
      can :read, List  do |list|
        list.users.include? user
      end

      # Member can't create , update, destroy, assign_member and unassign_member
      cannot [:create, :update, :destroy, :assign_member, :unassign_member], List

      # Member Can create a card on his lists, can read all cards on his lists
      can [:create, :read], Card  do |card|
        card.list.users.include? user
      end

      # can update/remove his own cards
      can [:update, :destroy], Card do |card|
        card.user == user
      end

      can [:create, :read], Comment do |comment| 
        comment.commentable.list.users.include? user || comment.commentable.commentable.list.users.include? user
      end

      can [:update, :destroy], Comment do |comment|
        comment.user == user
      end
    end
  end
end