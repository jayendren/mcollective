metadata  :name   => "Puppet",
                :description => "puppet faces via MCollective",
                :author      => "Jayendren Maduray",
                :license     => "GPL",
                :version     => "0.0.1",
                :url         => "none",
                :timeout     => 30

action "face" , :description => "execute puppet face" do
        display :always

        input :subcommand,
         :prompt      => "subcommand",
         :description => "ca catalog certificate certificate_request certificate_revocation_list config facts file help instrumentation_data instrumentation_listener instrumentation_probe key man module node parser plugin report resource resource_type secret_agent status",
         :type        => :string,
         :validation  => '^.+$',
         :optional    => false,
         :maxlength   => 0

        input :action,
         :prompt      => "action",
         :description => "puppet help subcommand/face",
         :type        => :string,
         :validation  => '^.+$',
         :optional    => false,
         :maxlength   => 0

         output :output,
                :description => "Result",
                :display_as  => "Result"

end
