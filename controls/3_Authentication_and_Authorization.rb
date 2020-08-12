control "3.1 Ensure 'Server Authentication' Property is set to 'Windows
Authentication Mode'" do
    title "Set The 'Server Authentication' Property To Windows Authentication mode"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT SERVERPROPERTY('IsIntegratedSecurityOnly') as login_mode;").row(0).column('login_mode') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT SERVERPROPERTY('IsIntegratedSecurityOnly') as login_mode;").row(0).column('login_mode') do
      its("value") { should cmp == 1 }
    end
end

control "3.2 Ensure CONNECT permissions on the 'guest' user is Revoked within
all SQL Server databases excluding the master, msdb and tempdb" do
    title "Revoke CONNECT permissions on the 'guest user' within all SQL Server databases excluding the master, msdb and tempdb"
    impact 1.0
    sql = mssql_session
  describe sql.query("SELECT DB_NAME() AS DatabaseName, 'guest' AS Database_User,
  [permission_name], [state_desc]
  FROM sys.database_permissions
  WHERE [grantee_principal_id] = DATABASE_PRINCIPAL_ID('guest')
  AND [state_desc] LIKE 'GRANT%'
  AND [permission_name] = 'CONNECT'
  AND DB_NAME() NOT IN ('master','tempdb','msdb');") do
      it { should be_empty }
  end
end

control "3.3 Ensure 'Orphaned Users' are Dropped From SQL Server Databases" do
    title "Drop Orphaned Users From SQL Server Databases"
    impact 1.0
    sql = mssql_session
    describe sql.query("EXEC sp_change_users_login @Action='Report';") do
      it { should be_empty }
    end
end
  
control "3.4 Ensure SQL Authentication is not used in contained databases" do
    title "Do not use SQL Authentication in contained databases"
    impact 1.0
    sql = mssql_session
  describe sql.query("SELECT name AS DBUser
  FROM sys.database_principals
  WHERE name NOT IN ('dbo','Information_Schema','sys','guest')
  AND type IN ('U','S','G')
  AND authentication_type = 2;") do
      it { should be_empty }
  end
end 
  
=begin
control "3.5_Ensure_the_SQL_Server's_MSSQL_Service_Account_is_Not_an_Administrator" do
  title "Ensure the SQL Server's MSSQL Service Account is Not an Administrator"
  impact 1.0
    script = <<-EOH
    (Get-WmiObject Win32_Service -Filter "Name='MSSQLSERVER'").StartName
    EOH
    describe powershell(script) do
    its('stdout') { should_not be_empty }
    its('stdout') { should_not eq "LocalSystem\r\n" }
    its('stdout') { should_not eq "Administrator\r\n" }
    end
end

control "3.6_Ensure_SQLAgent_Service_Account_is_Not_an_Administrator" do
  title "Ensure SQLAgent Service Account is Not an Administrator"
  impact 1.0
    script = <<-EOH
    (Get-WmiObject Win32_Service -Filter "Name='SQLSERVERAGENT'").StartName
    EOH
    describe powershell(script) do
    its('stdout') { should_not be_empty }
    its('stdout') { should_not eq "LocalSystem\r\n" }
    its('stdout') { should_not eq "Administrator\r\n" }
    end
end

control "3.7_Ensure_SQL_Server's_Full-Text_Service_Account_is_Not_an_Administrator" do
  title "Ensure SQL Server's Full-Text Service_Account is Not an Administrator"
  impact 1.0
    script = <<-EOH
    (Get-WmiObject Win32_Service -Filter "Name='MSFTESQL'").StartName
    EOH
    describe powershell(script) do
    its('stdout') { should_not be_empty }
    its('stdout') { should_not eq "LocalSystem\r\n" }
    its('stdout') { should_not eq "Administrator\r\n" }
    end
end
=end

control "3.8 Ensure only the default permissions specified by Microsoft are
granted to the public server role" do
    title "Ensure only the default permissions specified by Microsoft are granted to the public server role"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT *
    FROM master.sys.server_permissions
    WHERE (grantee_principal_id = SUSER_SID(N'public') and state_desc LIKE 'GRANT%') 
    AND NOT (state_desc = 'GRANT' and [permission_name] = 'VIEW ANY DATABASE' 
    and class_desc = 'SERVER') 
    AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and 
    class_desc = 'ENDPOINT' and major_id = 2)
    AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and 
    class_desc = 'ENDPOINT' and major_id = 3)
    AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and 
    class_desc = 'ENDPOINT' and major_id = 4)
    AND NOT (state_desc = 'GRANT' and [permission_name] = 'CONNECT' and 
    class_desc = 'ENDPOINT' and major_id = 5);
    ") do
    it { should be_empty }
  end
end

control "3.9 Ensure Windows BUILTIN groups are not SQL Logins" do
    title "Ensure Windows BUILTIN groups are not SQL Logins"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT pr.[name], pe.[permission_name], pe.[state_desc]
    FROM sys.server_principals pr
    JOIN sys.server_permissions pe
    ON pr.principal_id = pe.grantee_principal_id
    WHERE pr.name like 'BUILTIN%';
    ") do
    it { should be_empty }
 end
end

control "3.10 Ensure Windows local groups are not SQL Logins" do
    title "Ensure Windows local groups are not SQL Logins"
    impact 1.0
    sql = mssql_session
    describe sql.query("USE [master]; 
    GO;
    SELECT pr.[name] AS LocalGroupName, pe.[permission_name], pe.[state_desc]
    FROM sys.server_principals pr
    JOIN sys.server_permissions pe
    ON pr.[principal_id] = pe.[grantee_principal_id]
    WHERE pr.[type_desc] = 'WINDOWS_GROUP'
    AND pr.[name] like CAST(SERVERPROPERTY('MachineName') AS nvarchar) + '%';") do
    it { should be_empty }
  end
end

control "3.11 Ensure the public role in the msdb database is not granted access
to SQL Agent proxies" do
    title "Ensure the public role in the msdb database is not granted access to SQL Agent proxies"
    impact 1.0
    sql = mssql_session
    describe sql.query("USE [msdb];
    GO;
    SELECT sp.name AS proxyname
    FROM dbo.sysproxylogin spl
    JOIN sys.database_principals dp
    ON dp.sid = spl.sid
    JOIN sysproxies sp
    ON sp.proxy_id = spl.proxy_id
    WHERE principal_id = USER_ID('public');
    ") do
      it { should be_empty }
  end
end
  