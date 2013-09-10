metadata  :name   => "nettest",
          :description => "network port (tcp) test via MCollective",
          :author      => "Jayendren Maduray",
          :license     => "GPL",
          :version     => "0.0.1",
          :url         => "none",
          :timeout     => 15

action "connect", :description => "Check connectivity of remote server on port" do

    input :ipv4addr,
          :prompt      => "ipv4addr",
          :description => "The ipv4 address of the destination host to test",
          :validation  => :ipv4address,
          :type        => :string,
          :optional    => false,
          :maxlength   => 80

    input :port,
          :prompt      => "Port",
          :description => "The port to connect on",
          :type        => :integer,
          :maxlength   => 4,
          :optional    => false

    output :connect,
           :description => "Boolean value stating if connection was possible",
           :display_as  => "Connected"

    output :connect_status,
           :description => "Connection status string",
           :display_as  => "Connection Status"

    output :connect_time,
           :description => "Time it took to connect to host",
           :display_as  => "Connection time"

    output :agent_fqdn,
           :description => "Failed agent fqdn",
           :display_as  => "Failed Connections"

    summarize do
      aggregate summary(:connect_status)
      aggregate summary(:agent_fqdn)
    end
end