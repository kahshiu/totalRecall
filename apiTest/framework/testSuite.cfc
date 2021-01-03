component testSuite {

  public any function init(
    required string envString
    ,string sessionToken
  ) {
    this._env = arguments.envString
    this._sessionToken = arguments.sessionToken
  }



  public array function run (
    required string testIdentity
    ,required array argsArray
  ) {
    var testSuite = new framework.testRunner( argumentCollection = {
      envstring = this._env
      ,usCred = testIdentity
      ,sessionToken = this._sessionToken
    });
    return testSuite.runTests(argsArray);
  }

}
