require File.expand_path('../server', __FILE__)

# Record apache like access log
require 'logger'
logdir = File.dirname(__FILE__) + "/log"
logger = Logger.new(logdir + '/access.log', 'daily')
logger.instance_eval { alias :write :'<<' unless respond_to?(:write) }
use Rack::CommonLogger, logger

run Sinatra::Application
