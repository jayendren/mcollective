module MCollective
  module Agent
    class Nettest<RPC::Agent
      metadata  :name   => "nettest",
                :description => "network port (tcp) test using MCollective",
                :author      => "Jayendren Maduray",
                :license     => "GPL",
                :version     => "0.0.1",
                :url         => "none",
                :timeout     => 15

      action "connect" do
        reply[:connect], reply[:connect_status], reply[:connect_time], reply[:agent_fqdn] = Nettest.testconnect(request[:ipv4addr], request[:port])
      end

      # Does the actual work of the connect action
      # #testconnet will try and make a connection to a
      # given ip address, returning the time it took to
      # establish the connection, the connection status
      # and a boolean value stating if the connection could
      # be made.
      def self.testconnect(ipaddr, port)
        require 'timeout'
        require 'socket'
        connected      = false
        connect_string = nil
        connect_time   = nil
        agent_fqdn     = `facter fqdn`.chomp

        begin
          Timeout.timeout(2) do
            begin
              time = Time.now
              t    = TCPSocket.new(ipaddr, port)
              t.close
              connect_time   = Time.now - time
              connected      = true
              connect_string =  'Connected'
            rescue
              connect_string = 'Connection Refused'
            end
          end
        rescue Timeout::Error
          connect_string =  'Connection Timeout'
        end

        if connect_string.match(/Connection Refused|Connection Timeout/)
          return connected, connect_string, connect_time, agent_fqdn
        else
          return connected, connect_string, connect_time
        end

      end
    end
  end
end