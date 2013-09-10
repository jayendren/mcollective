metadata        :name        => "bind",
                :description => "Managing BIND cluster via MCollective",
                :author      => "Todor Genov, Jayendren Maduray",
                :license     => "BSD",
                :version     => "0.0.1",
                :url         => "none",
                :timeout     => 120

action "lookup", :description => "Perform DNS lookup against localhost" do
	display :always
	
	input :query,
        :prompt      => "Hostname",
        :description => "Hostname",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => false,
        :maxlength   => 0	

  input :querytype,
        :prompt      => "Query type",
        :description => "RR",
        :type        => :string,
        :validation  => '^.+$',
        :optional    => false,
        :maxlength   => 0     

  output :output,
	       :description => "DNS Answer:",
		     :display_as  => "Response"

end

action "status", :description => "rndc status" do
	display :always
  output  :output,
          :description => "rndc status",
          :display_as  => "Response"
end

action "top", :description => "Top source IPs generating DNS queries" do
  display :always
  input   :time_period,
          :prompt      => "Time period in seconds to generate top source ip's",
          :description => "Time period in seconds to generate top source ip's",
          :type        => :integer,
          :maxlength   => 60,
          :optional    => false

  input   :max_hosts,
          :prompt      => "Maximum number of hosts to generate top source ip's",
          :description => "Maximum number of hosts to generate top source ip's",
          :type        => :integer,
          :maxlength   => 15,
          :optional    => false

  output  :runtime,
          :description => "Time period to execute scan",
          :display_as  => "Runtime (seconds)"

  output  :dns_top_ip,
          :description => "Top source IP generating DNS queries",
          :display_as  => "Top source IP generating DNS queries"
  
  output  :ip_qps,
          :description => "IP Address, Queries per second",
          :display_as  => "IP Address, Queries per second"   

  output  :total_packet_count,
          :description => "Total Packet Count",
          :display_as  => "Total Packet Count"      

  output  :total_qps,
          :description => "Total Queries per second",
          :display_as  => "Total Queries per second"          

  summarize do
    aggregate summary(:dns_top_ip)
    aggregate sum(:total_packet_count), 
          :description => "Total Packet Count in the cluster",
          :display_as  => "Total Packet Count in the cluster",
          :format      => "sum packet count: %.2f"
    aggregate sum(:total_qps), 
          :description => "Total Queries per second in the cluster",
          :display_as  => "Total Queries per second in the cluster",
          :format      => "sum qps: %.2f"   
    #aggregate top_srcs(:ip_qps),
    #      :description => "Top source IP/QPS generating DNS queries in cluster",
    #      :display_as  => "Top src ip/qps generating DNS queries in cluster",
    #      :format      => "Top source IP/QPS: %f"
  end

end