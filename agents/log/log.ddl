metadata  :name   => "log",
                :description => "grep Log file via MCollective",
                :author      => "Jayendren Maduray",
                :license     => "GPL",
                :version     => "0.0.2",
                :url         => "none",
                :timeout     => 15

action "grep" , :description => "grep for pattern in Log file" do
	display :always
	
  input :pattern,
   :prompt      => "pattern",
         :description => "pattern",
         :type        => :string,
         :validation  => '^.+$',
         :optional    => false,
         :maxlength   => 0  

  input :logfile,
         :prompt      => "logfile",
         :description => "full path to log file",
         :type        => :string,
         :validation  => '^.+$',
         :optional    => false,
         :maxlength   => 0     

   output :output,
    :description => "Found",
    :display_as => "Matched"

end

action "bzgrep" , :description => "bzgrep for pattern in compressed Log file/s" do
	display :always

	input :pattern,
	 :prompt      => "pattern",
         :description => "pattern",
         :type        => :string,
         :validation  => '^.+$',
         :optional    => false,
         :maxlength   => 0	

	input :logfile,
         :prompt      => "logfile",
         :description => "full path to log file",
         :type        => :string,
         :validation  => '^.+$',
         :optional    => false,
         :maxlength   => 0     

	 output :output,
		:description => "Found",
		:display_as => "Matched"

end
