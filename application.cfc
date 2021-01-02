component {
  this.sessionCluster = false;
  this.sessionManagement = false;
  this.sessionCookie = false;
  this.sessionStorage = false;

  this.clientCluster = false;
  this.clientManagement = false;
  this.setClientCookies = false;

  this.mappings["/apis"] = getDirectoryFromPath(getCurrentTemplatePath()&"apis");
  this.mappings["/testing"] = getDirectoryFromPath(getCurrentTemplatePath()&"testing");
  this.myEnv = "DEV";


  // eventhandlers: application 
  public boolean function onApplicationStart(){
    resetVars(this.myEnv, true)
    return true;
  }

  public void function onApplicationEnd( struct applicationScope){
  }


  // eventhandlers: session 
  public void function onSessionStart(){
    return "";
  }
  public void function onSessionEnd(struct sessionScope, struct applicationScope){
    return "";
  }

  
  // eventhandlers: request regular 
  public boolean function onRequestStart(string targetPage){
    resetVars(this.myEnv, true)
    return true;
  }
  public void function onRequestEnd(){
    return "";
  }
  public any function onRequest(string targetPage){

    var req = getHttpRequestData(true);
    var urlRoute = structKeyExists(url,"route")? trim(url.route): "";

    router::run(
      application.vars.mappings,
      router::resolve(application.vars.mappings, urlRoute),
      router::getParams(req)
    );

    // implement public/ private route
        // group indicator
        // var result = {};
        // result.isPublic = structKeyExists(publicMapping, route);
        // result.isPrivate = structKeyExists(privateMapping, route);
        // result.isSubdir = structKeyExists(subdirMapping, route);

        // // combine mappings in sequence
        // var routeMapping = structNew("ordered");
        // structAppend(routeMapping, publicMapping, false);
        // structAppend(routeMapping, privateMapping, false);
        // structAppend(routeMapping, subdirMapping, false);

        // // perform mapping + default unmatched route
        // result.target = structFind(routeMapping, arguments.route, "error.cfm")
        // return result;
  }


  // eventhandlers: request cfc
  public void function onCFCRequest(string cfcName, string method, struct args){
    writeDump(cfcName);
    writeDump(method);
    writeDump(args);
  }


  // eventhandlers: error 
  public void function onAbort(string targetPage){
    writeDump("tracing from abort handler: #targetPage#");
  }

  public void function onError(struct exception, string eventName){
    writeDump(exception)
    //writeDump("tracing from error handler: #eventName#");
    //writeDump("tracing from error handler: #exception#");

    // cfheader(statusCode="400", statusText="#exception.message#")

    // if(application.vars.environment == "DEV") {
    // } else {
    // }
  }

  public boolean function onMissingTemplate (string targetPage) {
    writeDump("tracing from missing template: #arguments#")
    return true;
  }

  public void function allowOrigin (array allowDomains, struct req) {
    if(structKeyExists(req.header, "Origin")) {}

  }

  public void function resetVars (
    required string environment, 
    boolean force = true, 
  ) {

    // vars already set, return prematurely
    if(structKeyExists(application, "vars") and !force) return;

    application.vars = {};
    application.vars.mappings = {
      "apis" = {
        "error" = "apis/error.cfm",
      },
      "apis/fw" = {
        "auth" = "apis/fw/auth.cfm",
      },
      "apis/app" = {
        "announcement" = "apis/app/announcement.cfm",
      },
    }

    if(environment == "DEV") {
      application.vars.hostname = "localhost:8888";
      application.vars.appname = "test";
      application.vars.webroot = "http://#application.vars.hostname#/#application.vars.appname#";
      application.vars.db = "recall_staging";
      application.vars.hash = hash("recall");
      application.vars.tokenLifetime = ["n","15"];
      application.vars.tempPathId = 1;
      application.vars.filePathId = 2;

    } else if (environment == "PROD") {
      // application.vars.hostname = "localhost:8888";
      // application.vars.appname = "test";
      // application.vars.webroot = "http://#application.vars.hostname#/#application.vars.appname#";
      // application.vars.db = "recall_staging";
      // application.vars.hash = hash("recall");
      // application.vars.tokenLifetime = ["n","15"];
      // application.vars.tempPathId = 1;
      // application.vars.filePathId = 2;
    }
  }
}
