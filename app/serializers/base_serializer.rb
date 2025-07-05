# frozen_string_literal: true

class BaseSerializer
  include JSONAPI::Serializer

  set_key_transform :camel_lower # "some_key" => "someKey"
end
