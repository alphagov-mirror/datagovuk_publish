# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

if %w([development test]).include? Rails.env
  require "rubocop/rake_task"
end

Rails.application.load_tasks

tasks = %i[spec brakeman]

if %w([development test]).include? Rails.env
  RuboCop::RakeTask.new
  tasks = %i[spec brakeman rubocop]
end

task default: tasks
