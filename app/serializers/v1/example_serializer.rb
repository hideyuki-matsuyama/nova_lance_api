# frozen_string_literal: true

module V1
  class ExampleSerializer < BaseSerializer
    include JSONAPI::Serializer

    attributes :first_name, :last_name, :created_at, :updated_at
  end
end
