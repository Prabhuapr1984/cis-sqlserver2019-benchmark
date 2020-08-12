=begin
control "6.1 Ensure Database and Application User Input is Sanitized" do
  title "Sanitize Database and Application User Input"
  desc  "
    Always validate user input received from a database client or application by testing type, length, format, and range prior to transmitting it to the database server.
    Rationale: Sanitizing user input drastically minimizes risk of SQL injection.
  "
  impact 0.0
end
=end

control "6.2 Ensure 'CLR Assembly Permission Set' is set to 'SAFE_ACCESS' for All
CLR Assemblies" do
    title "Set the 'CLR Assembly Permission Set' to SAFE_ACCESS for All CLR Assemblies"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT name, permission_set_desc FROM sys.assemblies
    where permission_set_desc <> 'SAFE_ACCESS' and is_user_defined = 1;") do
        it { should be_empty }
    end
end
