# frozen_string_literal: true

require_relative 'topic_representer'

# Represents essential Repo information for API output
module WiKey
  # Representer object for repo clone requests
  class HotTopicRepresenter < Roar::Decorator
    include Roar::JSON

    property :topic, extend: TopicRepresenter, class: OpenStruct
  end
end
