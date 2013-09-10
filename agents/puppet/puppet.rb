module MCollective
  module Agent
    class Puppet<RPC::Agent
      metadata  :name   => "puppet",
                :description => "execute puppet faces via MCollective",
                :author      => "Jayendren Maduray",
                :license     => "GPL",
                :version     => "0.0.1",
                :url         => "none",
                :timeout     => 30

          action "face" do
            validate :subcommand, :shellsafe
            validate :action, :shellsafe

        cmd = "puppet #{request[:subcommand]} #{request[:action]} | grep -v warning"
        out = ""
            status = run(cmd, :stdout => out, :chomp => true)
            reply[:output] = out
        end
    end
  end
end
