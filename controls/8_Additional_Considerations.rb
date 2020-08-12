=begin
control "8.1 Ensure 'SQL Server Browser Service' is configured correctly" do
  title "Ensure 'SQL Server Browser Service' is configured correctly"
  desc  "No recommendation is being given on disabling the SQL Server Browser service.
	
    Rationale: In the case of a default instance installation, the SQL Server Browser service is disabled by default. Unless there is a named instance on the same server, there is no typically reason for the SQL Server Browser service to be running. In this case it is strongly suggested that the SQL Server Browser service remain disabled.
    When it comes to named instances, given that a security scan can fingerprint a SQL Server listening on any port, it's therefore of limited benefit to disable the SQL Server Browser service .
    However, if all connections against the named instance are via applications and are not visible to end users, then configuring the named instance to listening on a static port, disabling the SQL Server Browser service, and configuring the apps to connect to the specified port should be the direction taken. This follows the general practice of reducing the surface area, especially for an unneeded feature.
    On the other hand, if end users are directly connecting to databases on the instance, then typically having them use ServerName\\InstanceName is best. This requires the SQL Server Browser service to be running. Disabling the SQL Server Browser service would mean the end users would have to remember port numbers for the instances. When they don't that will generate service calls to IT staff. Given the limited benefit of disabling the service, the trade-off is probably not worth it, meaning it makes more business sense to leave the SQL Server Browser service enabled.
  "
  impact 0.0
  #sql = mssql_session
end
=end
