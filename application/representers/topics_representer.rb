# frozen_string_literal: true

# represent essential Wiki article information for API output
require_relative 'topic_representer'

module WiKey
  class TopicsRepresenter < Roar::Decorator
    include Roar::JSON

    collection :topics, extend: TopicRepresenter, class: OpenStruct
  end
end
