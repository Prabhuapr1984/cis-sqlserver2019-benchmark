control "2.1 Ensure 'Ad Hoc Distributed Queries' Server Configuration Option is
set to '0' " do
    title "Set the 'Ad Hoc Distributed Queries' Server Configuration Option to 0"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Ad Hoc Distributed Queries';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Ad Hoc Distributed Queries';").row(0).column('value_configured') do
      its("value") { should cmp == 0 }
    end
end

control "2.2 Ensure 'CLR Enabled' Server Configuration Option is set to '0'" do
    title "Set the 'CLR Enabled' Server Configuration Option to 0"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'clr enabled';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'clr enabled';").row(0).column('value_configured') do
      its("value") { should cmp == 0 }
    end
end

control "2.3 Ensure 'Cross DB Ownership Chaining' Server Configuration Option is
set to '0' " do
    title "Set the 'Cross DB Ownership Chaining' Server Configuration Option to 0"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Cross db ownership chaining';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Cross db ownership chaining';").row(0).column('value_configured') do
      its("value") { should cmp == 0 }
    end
end

control "2.4 Ensure 'Database Mail XPs' Server Configuration Option is set to '0'" do
    title "Set the 'Database Mail XPs' Server Configuration Option to 0"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Database Mail XPs';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Database Mail XPs';").row(0).column('value_configured') do
      its("value") { should cmp == 0 }
    end
end

control "2.5 Ensure 'Ole Automation Procedures' Server Configuration Option is
set to '0' " do
    title "Set the 'Ole Automation Procedures' Server Configuration Option to 0"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Ole Automation Procedures';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Ole Automation Procedures';").row(0).column('value_configured') do
      its("value") { should cmp == 0 }
    end
end

control "2.6_Set_the_Remote_Access_Server_Configuration_Option_to_0" do
    title "Set the 'Remote Access' Server Configuration Option to 0"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Remote access';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Remote access';").row(0).column('value_configured') do
      its("value") { should cmp == 0 }
    end
end

control "2.7_Set_the_Remote_Admin_Connections_Server_Configuration_Option_to_0" do
    title "Set the 'Remote Admin Connections' Server Configuration Option to 0"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Remote admin connections';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Remote admin connections';").row(0).column('value_configured') do
      its("value") { should cmp == 0 }
    end
end

control "2.8_Set_the_Scan_For_Startup_Procs_Server_Configuration_Option_to_0" do
    title "Set the 'Scan For Startup Procs' Server Configuration Option to 0"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Scan for startup procs';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n  CAST(value_in_use as int) as value_in_use\n  FROM sys.configurations\n  WHERE name = 'Scan for startup procs';").row(0).column('value_configured') do
      its("value") { should cmp == 0 }
    end
end

control "2.9_Set_the_Trustworthy_Database_Property_to_Off" do
    title "Set the 'Trustworthy' Database Property to Off"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT name\n  FROM sys.databases\n  WHERE is_trustworthy_on = 1\n  AND name != 'msdb'\n  AND state = 0;") do
      it { should be_empty }
    end
end

=begin
control "2.10 Ensure Unnecessary SQL Server Protocols are set to 'Disabled' " do
    title "Disable Unnecessary SQL Server Protocols"
    desc  "
      SQL Server supports Shared Memory, Named Pipes, TCP/IP and VIA protocols. However, SQL Server should be configured to use the bare minimum required based on the organization's needs.
      Rationale: Using fewer protocols minimizes the attack surface of SQL Server and in some cases can protect it from remote attacks.
    "
    impact 0.0
	sql = mssql_session
end
=end

control "2.11 Ensure SQL Server is configured to use non-standard ports" do
    title "Configure SQL Server to use non-standard ports"
    impact 0.5
    sql = mssql_session
  describe sql.query("DECLARE @value nvarchar(256); \n EXECUTE master.dbo.xp_instance_regread \n N\'HKEY_LOCAL_MACHINE', \n N'SOFTWARE\\Microsoft\\Microsoft SQL
  Server\\MSSQLServer\\SuperSocketNetLib\\Tcp\\IPAll', \n N'TcpPort', \n @value OUTPUT, \n N'no_output'; \n SELECT @value AS TCP_Port WHERE @value = '1433';") do
  it { should be_empty }
  end
end

control "2.12 Ensure 'Hide Instance' option is set to 'Yes' for Production SQL
Server instances" do
    title "Set the 'Hide Instance' option to 'Yes' for Production SQL Server instances"
    impact 1.0
    sql = mssql_session
  describe sql.query("DECLARE @getValue INT;EXEC master..xp_instance_regread @rootkey = N'HKEY_LOCAL_MACHINE',
  @key = N'SOFTWARE\\Microsoft\\Microsoft SQL Server\\MSSQLServer\\SuperSocketNetLib',
  @value_name = N'HideInstance',
  @value = @getValue OUTPUT;SELECT @getValue as result;").row(0).column('result') do
  its("value") { should_not be_empty }
  its("value") { should cmp 1 }
  end
end

control "2.13 Ensure the 'sa' Login Account is set to 'Disabled'" do
    title "Disable the 'sa' Login Account"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT name FROM sys.server_principals  
    WHERE sid = 0x01 and is_disabled = 0;") do
      it { should be_empty }
    end
end

control "2.14 Ensure the 'sa' Login Account has been renamed " do
    title "Rename the 'sa' Login Account"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT name \n  FROM sys.server_principals\n  WHERE name = 'sa';")do
      it { should be_empty }
    end
end

control "2.15 Ensure 'AUTO_CLOSE' is set to 'OFF' on contained databases " do
    title "Set AUTO_CLOSE OFF on contained databases"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT name, containment, containment_desc, is_auto_close_on \n  FROM sys.databases\n  WHERE containment <> 0 and is_auto_close_on = 1;") do
      it { should be_empty }
    end
end

control "2.16 Ensure no login exists with the name 'sa' " do
    title "Verify No Login Has the Name 'sa'"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT principal_id, \n name \n FROM sys.server_principals \n WHERE name = 'sa';").row(0).column('principal_id') do
        its("value") { should be_empty }
    end
end
