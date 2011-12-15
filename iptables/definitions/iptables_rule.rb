define :iptables_rule,
  :action => :create, :table => nil, :chain => nil, :target => "ACCEPT",
  :protocol => nil, :state => nil, :dport => nil, :sport => nil, :options => nil do

  include_recipe "iptables"

  raise ArgumentError,
    "Missing required argument: chain" unless params[:chain]

  def run_iptables_rule(action, chain, table, protocol, state,
                        dport, sport, target, options)
    iptables_path = "$(which iptables)"
    rule_name = "chef::iptables_rule::#{target}::#{params[:name]}"
    exec_command = []
    chk_command = []
    exec_command += (:remove == action) ?
      [iptables_path, "-D", chain] : [iptables_path, "-A", chain]
    chk_command += (:remove == action) ?
      [iptables_path, "-S", chain] : ["!", iptables_path, "-S", chain]
    exec_command << "--table" << table if table
    exec_command << "-m" << "state" << "--state" << state if state
    exec_command << "-m" << protocol << "-p" << protocol if protocol
    exec_command << "--dport" << dport if dport
    exec_command << "--sport" << sport if sport
    exec_command << "-j" << target if target
    exec_command << options if options
    exec_command << "-m" << "comment" << "--comment" << "\"#{rule_name}\""

    chk_command << "--table" << table if table
    chk_command << "|" << "grep" << rule_name

    execute rule_name do
      command exec_command.join(' ')
      only_if chk_command.join(' ')
    end

    execute "#{rule_name}:save" do
      command "service iptables save"
    end
  end

  run_iptables_rule(params[:action], params[:chain], params[:table], params[:protocol], params[:state],
                    params[:dport], params[:sport], params[:target], params[:options])
end
