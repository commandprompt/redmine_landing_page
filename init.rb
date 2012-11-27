require 'redmine'

Redmine::Plugin.register :redmine_landing_page do
  name 'Redmine Landing Page plugin'
  author 'Igor Zubkov'
  description 'Forked off https://github.com/biow0lf/redmine_landing_page'
  version '0.2.0'
  url 'https://github.com/biow0lf/redmine_landing_page'
  author_url 'https://github.com/biow0lf'
end

prepare_block = Proc.new do
  ProjectsController.send(:include, RedmineLandingPage::Patches::ProjectsControllerPatch)
  Project.send(:include, RedmineLandingPage::Patches::ProjectPatch)
  User.send(:include, RedmineLandingPage::Patches::UserPatch)
  WelcomeController.send(:include, RedmineLandingPage::Patches::WelcomeControllerPatch)
end

if Rails.env.development?
  ActionDispatch::Reloader.to_prepare { prepare_block.call }
else
  prepare_block.call
end

require 'redmine_landing_page/hooks/view_projects_form_hook'
require 'redmine_landing_page/hooks/view_my_account_hook'
require 'redmine_landing_page/hooks/view_users_form_hook'
