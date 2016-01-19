module ReadyTalk
  module API
    class List
      def initialize(json_data, klass, keys = nil)
        @data = JSON.parse(json_data)
        @klass = klass

        if keys.nil?
          @paging = {}
        else
          @paging = @data[keys[0]]['pagingCriteria'] || {}
          keys.each do |key|
            @data = @data[key] || @data
          end
        end

        @data = @data.map { |d| klass.new(d) }
      end

      def [](i)
        case i
        when Integer
          @data[i]
        else
          raise ArgumentError.new
        end
      end

      def each
        @data.each(&blk)
      end

      def empty?
        @data.empty?
      end

      def index
        @paging['firstResultIndex']
      end

      def count
        @paging['resultCount']
      end

      def total
        @paging['totalResultCount']
      end

    end
  end
end
