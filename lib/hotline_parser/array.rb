require 'thread'

class Array
  def async_map &block
    queue   = Queue.new
    workers = []
    result  = []

    self.each do |element|
      workers << Thread.start do
        queue << \
          begin
          block.call(element)
        rescue StandardError => exception
          exception
        end
      end
    end
    workers.each &:join

    while !queue.empty?
      result << queue.pop
    end

    result
  end
end