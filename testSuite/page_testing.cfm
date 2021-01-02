<cfscript>
  // testsuite variables
  _env = structKeyExists(url,"env")? url.env: "dev";

  _sessiontoken = structKeyExists(url,"token")? url.token: "";
  _sessiontoken = trim(_sessiontoken);

  _sample = structKeyExists(url,"sample")? url.sample: "";
  _sample = listToArray(_sample);
  samples = new framework.testSamples(_env, _sessiontoken);

  _debug = structKeyExists(url,"debug")? url.debug: "html";
  _debug = listToArray(_debug);

  results = [];
  if(arrayContainsNocase(_sample, "testNac") > 0)         { arrayAppend(results, { title = "NAC Generic Query", result = samples.testNac()        }) }
  if(arrayContainsNocase(_sample, "testResidentLog") > 0) { arrayAppend(results, { title = "NAC Resident Logs", result = samples.testResidentLog()}) }
  if(arrayContainsNocase(_sample, "testVms") > 0)         { arrayAppend(results, { title = "VMS Generic Query", result = samples.testVms()        }) }
  if(arrayContainsNocase(_sample, "testVisitorLog") > 0)  { arrayAppend(results, { title = "VMS Visitor Logs" , result = samples.testVisitorLog() }) }
  if(arrayContainsNocase(_sample, "testSearch") > 0)      { arrayAppend(results, { title = "VMS Search"       , result = samples.testSearch()     }) }
  if(arrayContainsNocase(_sample, "testPairing") > 0)     { arrayAppend(results, { title = "VMS In/out Pairing" , result = samples.testPairing()     }) }
  if(arrayContainsNocase(_debug, "cfml") > 0) {
    for(r in results) {
      framework.helpers::printCFML( r[1], r[2] );
    }
  }

  stockEnv = new framework.environment(_env);
</cfscript>

<cfoutput>
<cfif arrayContainsNocase(_debug, "html") gt 0>
  <h1>#stockEnv.getHost()# </h1>
  <hr>
  <cfloop index="rr" array="#results#"> 
      <h2><u>#rr.title# </u></h2>
    <cfmodule template="/templates/htmlResult.cfm" jsonString=#serializeJson(rr.result)#>
  </cfloop>
</cfif>
</cfoutput>
