// environment specific settings
environments {
    
    
	production {
	    dataSource {
	        dbCreate = "update"
	        driverClassName = "org.postgresql.Driver"
	        dialect = org.hibernate.dialect.PostgreSQLDialect
	         System.out.println(System.env.DATABASE_URL);

	        uri = new URI(System.env.DATABASE_URL?:"postgres://test:test@localhost/test")

	        url = "jdbc:postgresql://" + uri.host + ":" + uri.port + uri.path
	        username = uri.userInfo.split(":")[0]
	        password = uri.userInfo.split(":")[1]
	    }
	}
}
