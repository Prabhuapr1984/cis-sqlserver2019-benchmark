=begin
control "4.1 Ensure 'MUST_CHANGE' Option is set to 'ON' for All SQL
Authenticated Logins" do
  title "Set the 'MUST_CHANGE' Option to ON for All SQL Authenticated Logins"
  desc  "
    SQL Server will prompt for an updated password the first time the altered login is used.
    Rationale: Enforcing password change will prevent the account administrators or anyone accessing the initial password to misuse the SQL login created without being noticed.
  "
  impact 1.0
end
=end

control "4.2 Ensure 'CHECK_EXPIRATION' Option is set to 'ON' for All SQL
Authenticated Logins Within the Sysadmin Role" do
  title "Ensure 'CHECK_EXPIRATION' Option is set to 'ON' for All SQL Authenticated Logins Within the Sysadmin Role"
  impact 1.0
  sql = mssql_session
  describe sql.query("SELECT l.[name], 'sysadmin membership' AS 'Access_Method'
  FROM sys.sql_logins AS l
  WHERE IS_SRVROLEMEMBER('sysadmin',name) = 1
  AND l.is_expiration_checked <> 1
  UNION ALL
  SELECT l.[name], 'CONTROL SERVER' AS 'Access_Method'
  FROM sys.sql_logins AS l
  JOIN sys.server_permissions AS p
  ON l.principal_id = p.grantee_principal_id
  WHERE p.type = 'CL' AND p.state IN ('G', 'W')
  AND l.is_expiration_checked <> 1;") do
      it { should be_empty }
 end
end

control "4.3 Ensure 'CHECK_POLICY' Option is set to 'ON' for All SQL
Authenticated Logins" do
  title "Ensure 'CHECK_POLICY' Option is set to 'ON' for All SQL Authenticated Logins"
  impact 1.0
  sql = mssql_session
  describe sql.query("SELECT name, is_disabled
  FROM sys.sql_logins
  WHERE is_policy_checked = 0;") do
    it { should be_empty }
  end
end
