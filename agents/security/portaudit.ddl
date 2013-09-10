metadata  :name   => "Portaudit",
                :description => "FreeBSD Portaudit checks & update",
                :author      => "Jayendren Maduray",
                :license     => "GPL",
                :version     => "0.0.1",
                :url         => "none",
                :timeout     => 30

action "check" , :description => "check for vulnerabilities" do
        display :always

         output :portaudit_remote_stats,
                :description => "FreeBSD portaudit vulnerabilities check",
                :display_as  => "FreeBSD portaudit (remote vulnerabilities)"
end

action "update" , :description => "FreeBSD portaudit update database" do
        display :always

         output :portaudit_update_stats,
                :description => "FreeBSD portaudit update",
                :display_as  => "FreeBSD portaudit update output"
end