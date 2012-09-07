# Set application user
set :user, "ApplicationUser"
set :use_sudo, false

# Set application info
set :application, "GitLabAPIServer"
set :repository,  "git@your_repo_url:GitLabAPIServer.git"
set :deploy_to,   "/__path__/__to__/#{application}"

# Set application environment
set :app_env, "production"
set :app_port, "4567"

set :scm, :git

role :web, "application_server.com"                   # Your HTTP server, Apache/etc
role :app, "application_server.com"                   # This may be the same as your `Web` server
role :db,  "application_server.com", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do
    run "cd #{current_path} && rackup config.ru -E #{app_env} -p #{app_port} -D"
  end
end
