module RedmineLandingPage
  module Patches
    module WelcomeControllerPatch
      def self.included(base)
        base.class_eval do
          unloadable

          alias_method :index_without_landing_page, :index

          def index
            if User.current.logged? &&
               User.current.landing_page.present?
              redirect_to User.current.landing_page
            else
              index_without_landing_page
            end
          end
        end
      end
    end
  end
end
