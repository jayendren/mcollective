module MCollective
  module Agent
    class Portaudit<RPC::Agent
      metadata  :name   => "checkradiator",
                :description => "FreeBSD Portaudit checks & update",
                :author      => "Jayendren Maduray",
                :license     => "GPL",
                :version     => "0.0.1",
                :url         => "none",
                :timeout     => 30

      def portaudit_remote
        cmd = "/usr/local/sbin/portaudit | grep -A1 -i remote"
          out = ""
          status = run(cmd, :stdout => out, :chomp => true)
          reply[:portaudit_remote_stats] = out
      end

      def portaudit_update
        cmd = "/usr/local/sbin/portaudit -Fda"
          out = ""
          status = run(cmd, :stdout => out, :chomp => true)
          reply[:portaudit_update_stats] = out
      end              

      action "check" do
        portaudit_remote
      end    

      action "update" do
        portaudit_update
      end    

    end
  end
end