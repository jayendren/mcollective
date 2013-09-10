module MCollective
  module Agent
    class Log<RPC::Agent
      metadata  :name   => "log",
                :description => "grep Log file via MCollective",
                :author      => "Jayendren Maduray",
                :license     => "GPL",
                :version     => "0.0.2",
                :url         => "none",
                :timeout     => 5 
                
          action "grep" do
            validate :pattern, :shellsafe
            validate :logfile, :shellsafe

	          cmd = "grep #{request[:pattern]} #{request[:logfile]} "
	          out = ""
            status = run(cmd, :stdout => out, :chomp => true)
            reply[:output] = out
            reply.fail! "No lines matched #{request[:pattern]}" unless status == 0
          end

          action "bzgrep" do
            validate :pattern, :shellsafe
            validate :logfile, :shellsafe


	          cmd = "bzgrep #{request[:pattern]} #{request[:logfile]} "
	          out = ""
            status = run(cmd, :stdout => out, :chomp => true)
            reply[:output] = out
            reply.fail! "No lines matched #{request[:pattern]}" unless status == 0
          end
          
    end
  end
end
