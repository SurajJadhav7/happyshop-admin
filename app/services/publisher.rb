# class Publisher
#     def self.publish(exchange, message = {}) 
#         x = channel.fanout("happyshop-admin.#{exchange}")
#         x.publish(message.to_json)
#       end
    
#       def self.channel
#         @channel ||= connection.create_channel
#       end
    
#       def self.connection
#         @connection ||= Bunny.new.tap do |c|
#           c.start
#         end
#       end
# end

class Publisher
    DEFAULT_OPTIONS = { durable: true, auto_delete: false }.freeze

    def self.publish(queue_name:, payload:)
      channel = ConnectionManager.instance.channel
      queue = channel.queue(queue_name, DEFAULT_OPTIONS)
      queue.publish(payload.to_json, routing_key: queue.name)
    end
end