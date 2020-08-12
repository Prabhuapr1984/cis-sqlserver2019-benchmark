control "1.1_Ensure_Latest_SQL_Server_Service_Packs_and_Hotfixes_are_Installed" do
    title "Install the Latest SQL Server Service Packs and Hotfixes"
    impact 1.0
    # <Test for matching databases> sql = mssql_session(user: 'my_user', password: 'password')
    # <Test a specific host and instance> sql = mssql_session(user: 'my_user', password: 'password', host: 'mssqlserver', instance: 'foo')
    # <Test a specific database> sql = mssql_session(user: 'my_user', password: 'password', db_name: 'test')
    
    # Test using Windows authentication
    sql = mssql_session
    describe sql.query("SELECT SERVERPROPERTY('ProductVersion') as result").row(0).column('result') do
      its("value") { should_not be_empty }
    end
    describe sql.query("SELECT SERVERPROPERTY('ProductVersion') as result").row(0).column('result') do
      its("value") { should cmp >= '15.0.4043.16' } # SQL Server 2019 CU5
    end
end

# control "1.2 Ensure Single-Function Member Servers are Used" do
#     title "Install on dedicated single-function member servers"
#     desc  "
#       It is recommended that SQL Server software be installed on a dedicated server. This architectural consideration affords security flexibility in that the database server can be placed on a separate subnet allowing access only from particular hosts and over particular protocols. Degrees of availability are easier to achieve as well - over time, an enterprise can move from a single database server to a failover to a cluster using load balancing or to some combination thereof.
#       Rationale: It is easier to manage (i.e. reduce) the attack surface of the server hosting SQL Server software if the only surfaces to consider are the underlying operating system, SQL Server itself, and any security/operational tooling that may additionally be installed. As noted in the description, availability can be more easily addressed if the database is on a dedicated server.
#     "
#     impact 0.0
#   end
  