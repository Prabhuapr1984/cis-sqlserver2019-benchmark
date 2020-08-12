control "5.1 Ensure 'Maximum number of error log files' is set to greater than or
equal to '12'" do
    title "Set the 'Maximum number of error log files' setting to greater than or equal to 12"
    impact 1.0
    sql = mssql_session
    describe sql.query("BEGIN\n DECLARE @NumErrorLogs int;\n EXEC master.sys.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\\Microsoft\\MSSQLServer\\MSSQLServer', N'NumErrorLogs', @NumErrorLogs OUTPUT;\n SELECT ISNULL(@NumErrorLogs, -1) AS [NumberOfLogFiles];\n END").row(0).column('NumberOfLogFiles') do
      its("value") { should_not be_empty }
    end
    describe sql.query("BEGIN\n DECLARE @NumErrorLogs int;\n EXEC master.sys.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\\Microsoft\\MSSQLServer\\MSSQLServer', N'NumErrorLogs', @NumErrorLogs OUTPUT;\n SELECT ISNULL(@NumErrorLogs, -1) AS [NumberOfLogFiles];\n END").row(0).column('NumberOfLogFiles') do
      its("value") { should cmp >= 12 }
   end
end

control "5.2 Ensure 'Default Trace Enabled' Server Configuration Option is set to
'1'" do
    title "Ensure 'Default Trace Enabled' Server Configuration Option is set to '1'"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT CAST(value as int) as value_configured,\n CAST(value_in_use as int) as value_in_use\n FROM sys.configurations\n  WHERE name = 'Default trace enabled';").row(0).column('value_configured') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n CAST(value_in_use as int) as value_in_use\n FROM sys.configurations\n  WHERE name = 'Default trace enabled';").row(0).column('value_configured') do
      its("value") { should cmp == 1 }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n CAST(value_in_use as int) as value_in_use\n FROM sys.configurations\n  WHERE name = 'Default Trace Enabled';").row(0).column('value_in_use') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT CAST(value as int) as value_configured,\n CAST(value_in_use as int) as value_in_use\n FROM sys.configurations\n  WHERE name = 'Default Trace Enabled';").row(0).column('value_in_use') do
      its("value") { should cmp == 1 }
   end 
end

control "5.3 Ensure 'Login Auditing' is set to 'failed logins'" do
    title "Set 'Login Auditing' to failed logins"
    impact 1.0
    sql = mssql_session
    describe sql.query("BEGIN\n  exec xp_loginconfig 'audit level';\n END").row(0).column('config_value') do
      its("value") { should_not be_empty }
    end
    describe sql.query("BEGIN\n  exec xp_loginconfig 'audit level';\n END").row(0).column('config_value') do
      its("value") { should eq "failure" }
    end 
end
  
control "5.4 Ensure 'SQL Server Audit' is set to capture both 'failed' and
'successful logins'" do
    title "Ensure 'SQL Server Audit' is set to capture both 'failed' and 'successful logins'"
    impact 0.0
    sql = mssql_session
    describe sql.query("SELECT count(1) count1
    FROM sys.server_audit_specification_details AS SAD
    JOIN sys.server_audit_specifications AS SA
    ON SAD.server_specification_id = SA.server_specification_id
    JOIN sys.server_audits AS S
    ON SA.audit_guid = S.audit_guid
    WHERE SAD.audit_action_id IN ('CNAU', 'LGFL', 'LGSD')
    AND S.is_state_enabled=1
    AND SA.is_state_enabled=1
    AND SAD.audited_result like '%SUCCESS%' and SAD.audited_result like '%FAILURE%'
    AND SAD.audit_action_name in ('AUDIT_CHANGE_GROUP', 'FAILED_LOGIN_GROUP', 'SUCCESSFUL_LOGIN_GROUP');").row(0).column('count1') do
        its("value") { should cmp 3 }
    end 
end
