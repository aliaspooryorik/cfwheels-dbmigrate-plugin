<!---
    |----------------------------------------------------------------------------------------------------------------------------|
	| Parameter     | Required | Type    | Default | Description                                                                 |
    |----------------------------------------------------------------------------------------------------------------------------|
	| table         | Yes      | string  |         | table name                                                                  |
	| columnNames   | Yes      | string  |         | one or more column names to index, comma separated                          |
	| unique        | No       | boolean |  false  | if true will create a unique index constraint                               |
	| indexName     | No       | string  |         | use for index name. Defaults to table name + underscore + first column name |
    |----------------------------------------------------------------------------------------------------------------------------|

    EXAMPLE:
      addIndex(table='members',columnNames='username',unique=true);
--->
<cfcomponent extends="[extends]" hint="[description]">
  <cffunction name="up">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{
	    		addIndex(table='tableName',columnNames='columnName',unique=true);
	    	}
	    	catch (any ex){
	    		hasError = true;
		      	catchObject = ex;
	    	}
			
	    </cfscript>
	    <cfif hasError>
	    	<cftransaction action="rollback" />
	    	<cfthrow 
			    detail = "#catchObject.detail#"
			    errorCode = "1"
			    message = "#catchObject.message#"
			    type = "Any">
	    <cfelse>
	    	<cftransaction action="commit" />
	    </cfif>
	 </cftransaction>
  </cffunction>
  <cffunction name="down">
  	<cfset hasError = false />
  	<cftransaction>
	    <cfscript>
	    	try{
	    		removeIndex(table='tableName', indexName='');
	    	}
	    	catch (any ex){
	    		hasError = true;
		      	catchObject = ex;
	    	}
		    
	    </cfscript>
	     <cfif hasError>
	    	<cftransaction action="rollback" />
	    	<cfthrow 
			    detail = "#catchObject.detail#"
			    errorCode = "1"
			    message = "#catchObject.message#"
			    type = "Any">
	    <cfelse>
	    	<cftransaction action="commit" />
	    </cfif>
	 </cftransaction>
  </cffunction>
</cfcomponent>