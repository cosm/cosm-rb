module Cosm
  module Parsers
    module JSON
      module DatapointDefaults
        def from_json(json)
          begin
            ::JSON.parse(json)
          rescue ::JSON::ParserError => e
            raise InvalidJSONError, e.message
          end
        end
      end
    end
  end
end

