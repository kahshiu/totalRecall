<cfscript>
  // testsuite variables
  _env = structKeyExists(url,"env")? url.env: "dev";

  _token = structKeyExists(url,"token")? url.token: "";
  _token = trim(_token);
  if(len(_token) != 128) _token = "";

  _seed = structKeyExists(url,"seed")? url.seed: "";
  _seed = listToArray(_seed);
  seeding = new framework.seedSamples(_env, _token);

  _debug = structKeyExists(url,"debug")? url.debug: "html";
  _debug = listToArray(_debug);

  results = [];






  //arrayAppend(results, { title = "Seeding new user", result = seeding.createUser() }) 
  // arrayAppend(results, { title = "Seeding user password", result = seeding.createCred() }) 
//  arrayAppend(results, { title = "Updating user details", result = seeding.updateUser() }) 
  //arrayAppend(results, { title = "Integration Endpoints", result = seeding.integration2() }) 
  arrayAppend(results, { title = "Integration Endpoints", result = seeding.integration3() }) 






  if(arrayContainsNocase(_debug, "cfml") > 0) {
    for(r in results) {
      framework.helpers::printCFML( r[1], r[2] );
    }
  }

  stockEnv = new framework.environment(_env);
</cfscript>

<cfoutput>
<cfif arrayContainsNocase(_debug, "html") gt 0>
  <h1> SEEDING </h1>
  <h1> #stockEnv.getHost()# </h1>
  <hr>
  <cfloop index="rr" array="#results#"> 
      <h2><u>#rr.title# </u></h2>
    <cfmodule template="/templates/htmlResult.cfm" jsonString=#serializeJson(rr.result)#>
  </cfloop>
</cfif>
</cfoutput>
