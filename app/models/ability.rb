class Ability
  include CanCan::Ability


  # @param [Usuario] user
  def initialize(user)

    can :read, [Destinatario, Lista]

    if user.role.identificador == 'admin'
      can :manage, :all
    end
  end
end
