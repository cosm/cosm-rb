module Cosm
  module Parsers
    module CSV
      class UnknownVersionError < StandardError ; end
      module FeedDefaults
        def from_csv(csv, csv_version = nil)
          array = Cosm::CSV.parse(csv.strip)
          version = detect_version(array, csv_version)
          hash = Hash.new
          if version == :v2
            hash["datastreams"] = array.collect {|row|
              timestamp = {}
              if row.size == 3
                timestamp["updated"] = row[1]
              end
              { "id" => row.first.to_s,
                "current_value" => row.last.to_s
              }.merge(timestamp)
            }
          elsif version == :v1
            hash["datastreams"] = []
            array.first.each_with_index do |current_value, stream_id|
              hash["datastreams"] << { "id" => stream_id.to_s, "current_value" => current_value }
            end
          end
          hash["csv_version"] = version
          hash
        end

        private

        def detect_version(array, version = nil)
          return version if version
          return :v2 if array.size >= 2
          return :v1 if array.size == 1 && array.first.size != 2
          raise UnknownVersionError, "CSV Version could not be detected"
        end
      end
    end
  end
end

