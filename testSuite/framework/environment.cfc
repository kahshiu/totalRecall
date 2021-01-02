component environment {

  public void function init (targetEnv) {
    this._env = arguments.targetEnv;
  }

  public struct function getCreds (
    required string usCred, 
  ) {
    var creds = {
      none = {
        username = "",
        password = "",
      },
      allen = {
        username = "allen",
        password = "test123",
      },
      root = {
        username = "root",
        password = "test123",
      },
      nac = {
        username = "puteri_11_nac_2",
        password = "test123",
      },
      vms = {
        username = "puteri_11_vms_2",
        password = "test123",
      }
    }
    return structFind(creds, usCred, "none");
  }

  public string function getHost () {
    var targetHost = {
      dev = "http://localhost:8888/silamasuk_endpoint/?",
      prod = "http://test.smartjaga.com/?"
    }
    return targetHost[this._env];
  }

  public struct function getConfig (
    required string usType, 
    string sessionToken,
  ) {
    if( arguments.sessionToken > 0 ) {
      var _myIdentity = getCreds("none", arguments.sessionToken);
      var _myToken = arguments.sessionToken;

    } else {
      var _myIdentity = getCreds(arguments.usType);
      var _myToken = "";
    }
    _myIdentity.append({
      sessionToken = _myToken,
      targetHost = getHost(),
    })
    return _myIdentity; 
  }
}
