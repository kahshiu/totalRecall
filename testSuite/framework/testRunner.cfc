component tesRunner {


  public any function init (
    required string envString
    ,required string usCred
    ,string sessionToken
  ) {
    this._env = new environment(arguments.envString);
    this._config = this._env.getConfig(arguments.usCred, arguments.sessionToken);
  }



  public any function getConfig() {
    return this._config;
  }



  public array function runLogin() {
    if(len(this._config.sessionToken) > 0) {
      var argsAuth = framework.helpers::argsSession(argumentCollection = this._config); 
      var resultAuth = framework.helpers::resultSession(argumentCollection = this._config); 

    } else {
      var argsAuth = framework.helpers::argsAuth(argumentCollection = this._config);
      argsAuth.body._payload = {
        username = this._config.username
        ,password = this._config.password
      } 
      var resultAuth = framework.helpers::httpResult(argumentCollection = argsAuth);
    }

    sleep("500");

    this._config.sessionToken = resultAuth.payload.token;
    return [argsAuth, resultAuth];
  }



  public array function runTests (
    required array argsArray
  ) {
    var login = runLogin();

    var zzz = framework.helpers::runArgs(
      this._config.targetHost, 
      this._config.sessionToken, 
      argsArray
    );
    zzz[1].insertAt("1",login[1]);
    zzz[2].insertAt("1",login[2]);

    return zzz;
  } 



  public void function runDoc(docId) {
    var argsAuth = runLogin();
    var a2 = framework.helpers::argsCopyFrom(argsAuth, {
      display = "cfml",
      route = "fw.getDocById",
      payload = { 
        docId = arguments.docId
      } 
    });
    var result = framework.helpers::httpCall(argumentCollection=a2);
    var result2 = {
      display = "cfml",
      route = "fw.getDocById",
      result = result.filecontent
    }

    //imgObj = imageReadBase64("data:image/jpeg;base64, #toBase64(result.filecontent)#");
    //cfimage(action="writeToBrowser", source=imgObj);

    writeOutput(
      '<img src="data:image/jpeg;base64, #toBase64(result.filecontent)#">'
    );
    writeDump(a2);
  }

  // public void function runQR(qrString) {
  //   var argsAuth = runLogin();
  //   var a2 = framework.helpers::argsCopyFrom(argsAuth, {
  //     display = "html",
  //     route = "fw.getDocQr",
  //     payload = { 
  //       coid = 2
  //       ,qrString = qrString
  //     } 
  //   });
  //   var result = framework.helpers::httpCall(argumentCollection=a2);

  //   //var result2 = {
  //   //  display = "cfml",
  //   //  route = "fw.getDocById",
  //   //  result = result.filecontent
  //   //}

  //   //imgObj = imageReadBase64("data:image/jpeg;base64, #toBase64(result.filecontent)#");
  //   //cfimage(action="writeToBrowser", source=imgObj);

  //   writeOutput(
  //     '<img src="data:image/jpeg;base64, #toBase64(result.filecontent)#">'
  //   );
  //   writeDump(a2);
  // }

}

