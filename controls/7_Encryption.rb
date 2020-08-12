control "7.1 Ensure 'Symmetric Key encryption algorithm' is set to 'AES_128' or
higher in non-system databases" do
    title "Ensure Symmetric Key encryption algorithm is AES_128 or higher in non-system databases"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT db_name() AS Database_Name, name AS Key_Name FROM sys.symmetric_keys
    WHERE algorithm_desc NOT IN ('AES_128','AES_192','AES_256') AND db_id() > 4;") do
        it { should be_empty }
    end
end 

control "7.2 Ensure Asymmetric Key Size is set to 'greater than or equal to 2048'
in non-system databases" do
    title "Ensure asymmetric key size is greater than or equal to 2048 in non-system databases"
    impact 1.0
    sql = mssql_session
    describe sql.query("SELECT db_name() AS Database_Name, name AS Key_Name FROM sys.asymmetric_keys
    WHERE key_length < 2048 AND db_id() > 4;") do
        it { should be_empty }
    end
end
  