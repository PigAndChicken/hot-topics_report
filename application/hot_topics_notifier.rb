require 'econfig'
require 'aws-sdk-sqs'

require_relative '../init.rb'

extend Econfig::Shortcut
Econfig.env = ENV['WORKER_ENV'] || 'development'
Econfig.root = File.expand_path('..', File.dirname(__FILE__))

ENV['AWS_ACCESS_KEY_ID'] = config.AWS_ACCESS_KEY_ID
ENV['AWS_SECRET_ACCESS_KEY'] = config.AWS_SECRET_ACCESS_KEY
ENV['AWS_REGION'] = config.AWS_REGION

queue = CodePraise::Messaging::Queue.new(config.REPORT_QUEUE_URL)

hot_topics = {}

puts "Checking hot topics"
queue.poll do |hot_topics_json|
  hot_topics_result = WiKey::TopicsRepresenter
                  .new(OpenStruct.new)
                  .from_json(hot_topics_json)
  hot_topics[hot_topics_result.id] = hot_topics.topics
  print '.'
end

if hot_topics.count > 0
  n = 1 
  hot_topics.values.each do |topic|
    puts "No#{n} is #{topic.name}."
    n = n + 1
  end

else
  puts "number of topic is not enough."
end