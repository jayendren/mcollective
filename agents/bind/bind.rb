module MCollective
  module Agent
    class Bind<RPC::Agent
      metadata  :name        => "bind",
                :description => "Manage BIND service via MCollective",
                :author      => "Todor Genov, Jayendren Maduray",
                :license     => "BSD",
                :version     => "0.0.1",
                :url         => "none",
                :timeout     => 120 
                
      action "lookup" do
        validate :query,     :shellsafe
        validate :querytype, :shellsafe

	      cmd = "dig \@127.0.0.1 #{request[:query]} #{request[:querytype]} +short"
	      out = ""
        status = run(cmd, :stdout => out, :chomp => true)
        reply[:output] = out
      end
          
	    action "status" do
	      cmd = "rndc status"
	      out = ""
        status = run(cmd, :stdout => out, :chomp => true)
        reply[:output] = out
      end

      action "flushname" do
      end
          
      action "flushtree" do
      end
 
      action "top" do
        reply[:total_packet_count], reply[:total_qps], reply[:ip_qps], reply[:dns_top_ip], reply[:runtime] = Bind.dns_top(request[:time_period], request[:max_hosts])
      end

      #defs for top action:
      def self.top_pcapture(pcap_timeout, pcap_filter, capture_dev, snap_len)
        require 'rubygems'
        require 'eventmachine'
        require 'pcaplet'

        EventMachine.run do
          stats = { }
          EM.add_timer(pcap_timeout) do #Return the "status" hash and terminate the EventMachine loop after _timeout_
            return stats
            EM.stop_event_loop
          end

          top_pcapture = Proc.new do
            inp = Pcap::Capture.open_live(capture_dev,1500)
            filter = Pcap::Filter.new(pcap_filter)
            inp.setfilter(filter)

            inp.each_packet { |packet|
              stats.has_key?(:packetcount) ? stats[:packetcount] += 1 : stats[:packetcount] = 1
              stats.has_key?(packet.ip_src.to_s) ? stats[packet.ip_src.to_s] +=1 : stats[packet.ip_src.to_s] = 1
            } 
          end
        
          EM.defer(top_pcapture) #Run the capture Proc in an EM thread

        end

      end

      def self.dns_top(runtime,top_count)
        begin
          pri_ip = `facter ipaddress`.chomp
          pri_if = `facter primary_interface`.chomp
          #result = Bind.top_pcapture(runtime,"dst port 53 and src host not #{pri_ip}","#{pri_if}",1500)
          result = Bind.top_pcapture(runtime,"dst port 53 and src host not #{pri_ip} and dst host not #{pri_ip}","#{pri_if}",1500)
          
          #Hash structure { :packetcount => $total_number_of_packets_captures, "IP_source_1" => $packet_count, "IP_source_2" => $packet_count"
          sorted = result.sort_by {|k,v| v}
          sorted.reverse!

          #Element 0 is always the total packet count (it's the largest number)
          total_packet_count = sorted[0][1]

          total_qps          = (total_packet_count.to_f / runtime)
          ip_qps             = (sorted[1..top_count])
          dns_top_ip         = (sorted[1])[0]

          #original format code does not return reply
          #@bind_top_runtime = ( printf "Total: %s, qps: %.2f runtime: %ss \n" % [ @total_packet_count, @total_packet_count.to_f/runtime,runtime ] )  
          #sorted[1..top_count].each  { |x|
            #@bind_top_stats = ( printf "Host: %s, Total queries: %s, qps: %s, percent %.2f\n" %  [x[0], x[1], x[1].to_f/runtime,x[1].to_f/total*100] )      
          #}

          return total_packet_count, total_qps, ip_qps, dns_top_ip, runtime

        end
      end

    end #class
  end #Agent
end #MCollective