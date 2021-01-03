component helpers {
  public static struct function httpCall (
    required string targetHost,
    required string contentType,
    required string method,
    required struct urlParams,
    required string body
  ) {
    httpService = new http(
      url = arguments.targetHost
      ,method = arguments.method
    );
    httpService.addParam(
      type = "header"
      ,name = "content-type"
      ,value = arguments.contentType
    );
    for(k in arguments.urlParams) {
      httpService.addParam(
        type = "url"
        ,name = k
        ,value = urlParams[k]
      );
    }
    httpService.addParam(
      type = "body"
      ,name = "json"
      ,value = arguments.body
    );

    var result = httpService.send().getPrefix();
// DEBUG: base http call
// writeDump( label="helpers/ httpCall/ tracing body", var=arguments.body );
// abort;
    return result;
  }



  public static any function httpResult (
    required string targetHost,
    required string contentType,
    required string method,
    required struct urlParams,
    required struct body
  ) {
    try {
      var result = httpCall( argumentCollection = {
         targetHost  = arguments.targetHost 
        ,contentType = arguments.contentType
        ,method      = arguments.method     
        ,urlParams   = arguments.urlParams  
        ,body        = serializeJson(arguments.body)       
      });

      if(result.status_code == 400) { 
        writeDump( label="helpers/ httpResult/ ERR_STATUS/ args", var=arguments.body );
        //writeDump( label="helpers/ httpResult/ ERR_STATUS/ content", var=result );
        writeOutput( result.filecontent );
        throw(type="custom", message="ERR_STATUS"); 
      }
// {
// charset = "UTF-8"
// ,cookies = query
// ,errorDetail = ""
// ,filecontent = ""
// ,header = ""
// ,http_version = ""
// ,mimetype = ""
// ,responseHeader = {
//   content-length
//   ,content-type
//   ,date
//   ,explanation
//   ,status_code
// }
// ,status_code
// ,status_text
// ,statuscode
// ,text
// }

      var content = deserializeJson(result.filecontent);
      if(not content.success) { 
        writeDump( label="helpers/ httpResult/ UNSUCCESSFUL_QUERY/ args", var=arguments.body );
        writeDump( label="helpers/ httpResult/ UNSUCCESSFUL_QUERY/ content", var=content );
        throw(type="custom", message="UNSUCCESSFUL_QUERY"); 
      }

      return {
        success = content.success, 
        message = content.message,
        payload = content.payload
      };

    } catch (any e){
      writeOutput( "ERROR: <br> " );
      writeDump( label="helpers/ httpResult/ ERROR", var=cfcatch );
      rethrow;
    }
  }



  public static struct function argsAuth (
    required string targetHost,
    required string username default="",
    required string password default=""
  ) {
    var username = arguments.username; 
    var password = arguments.password;

// DEBUG: base http call
//writeDump(label="helpers/ argsAuth/ username", var=username);
//writeDump(label="helpers/ argsAuth/ password", var=password);

    var args = {
      targetHost = arguments.targetHost
      ,contentType = "application/json"
      ,method = "POST"
      ,urlParams = {
        route = "fw.auth"
        ,token = ""
      }
      ,body = {
        payload = {
          username = hash(arguments.username,"sha-512")
          ,password = hash(arguments.password,"sha-512") 
        }
        ,token = ""
      }
    };
    return args;
  }



  public static struct function argsSession (
    required string targetHost,
  ) {
    var args = {
      targetHost = arguments.targetHost
      ,contentType = "application/json"
      ,method = "POST"
      ,urlParams = {
        route = "SESSION DETECTED: Artificial Login"
        ,token = ""
      }
      ,body = {
        payload = {
          username = ""
          ,password = ""
        }
        ,token = ""
      }
    };
    return args
  }



  public static struct function resultSession (
    required string sessionToken
  ) {
    return {
      MESSAGE = "Authorisation successful"
      ,PAYLOAD = {
        TOKEN = arguments.sessionToken
        ,CACHE = {}
      }
      ,SUCCESS = true
    }
  }



  public static struct function argsHttp (
    required string targetHost,
    required string token,
    required string route,
    required struct payload,
  ) {
    var result = {
      targetHost = arguments.targetHost
      ,contentType = "application/json"
      ,method = "POST"
      ,urlParams = {
        route = arguments.route
        ,token = arguments.token
      }
      ,body = {
        payload = arguments.payload
        ,token = arguments.token
      } 
    };
    return result; 
  }



  // base is the authentication object returned
  // argsAll is the array of other endpoint payload to test on
  public static array function runArgs (
    required string targetHost,
    required string sessionToken,
    required array argsAll,
  ) {
    var argBase = {
      targetHost = arguments.targetHost
      ,token = arguments.sessionToken
    }
    var args = [];
    var results = [];
    for( a in argsAll) {
      var a2 = argsHttp(
        targetHost = arguments.targetHost
        ,token = arguments.sessionToken
        ,route = a.route
        ,payload = a.payload
      );
      var result = httpResult(argumentCollection = a2);

      arrayAppend(args, a2);
      arrayAppend(results, result);
    }
    return [args, results]; 
  }



  public static void function printCFML (
    required array args,
    required array results,
  ) {

    for(i=1; i<=arrayLen(arguments.args); i=i+1) {
      var a = arguments.args[i];
      var r = arguments.results[i];

      var route = a.urlparams.route;
      writeDump( label="#route#-parameters", var=a );
      writeDump( label="#route#-results", var=r );
      writeOutput("<br><br><br>");
    }
  }
}
