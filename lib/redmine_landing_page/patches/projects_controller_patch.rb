module RedmineLandingPage
  module Patches
    module ProjectsControllerPatch
      def self.included(base)
        base.class_eval do
          unloadable

          alias_method :show_without_landing_page, :show

          def show
            if @project.landing_page.present?
              redirect_to @project.landing_page
            else
              show_without_landing_page
            end
          end
        end
      end
    end
  end
end
