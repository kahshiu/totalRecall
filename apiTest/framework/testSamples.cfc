component testSamples {

  public any function init(
    required string envString
    ,string sessionToken
  ) {
    this._suite = new testSuite(argumentCollection=arguments);
  }
  public array function testPairing () {
    return this._suite.run("vms", [
        //{ 
        //  route = "fw.authSession",
        //  payload = { }
        //}
        { 
          route = "taman.pairVisitorAccess",
          payload = { 
            "COID" = "2",
          }, 
        },
    ]);
  }

  public array function testSearch () {
    return this._suite.run("vms", [
        //{ 
        //  route = "fw.authSession",
        //  payload = { }
        //}
        { 
          route = "taman.getVisitorAccess",
          payload = { 
            // fromDatetime = "November, 19 2020 10:48:14 +0800",
            // toDatetime = now(),
            // guardHouseId = 480,
            // entryType = 'active',
            // residentStreet = '11/1',
            // houseId = 3,
            // carregno = 'www',
            // visitorId = 'fff',
            // reason = '',

            "SERIALNO"       = "",
            "FROMDATETIME"   = "November, 01 2020 00:48:14 +0800",
            "TODATETIME"     = "December, 19 2020 10:48:14 +0800",
            "GUARDHOUSEID"   = 0,

            "RESIDENTSTREET" = "",
            "ENTRYTYPE"      = "",

            "HOUSEID"        = 0,
            "CARREGNO"       = "",
            "VISITORID"      = "",
            "REASON"         = "",
          }, 
        },
    ]);
  }

  public array function testNac () {
    return this._suite.run("nac", [
        {
          route = "taman.getRFIDSeq",
          payload = { } 
        },
        { 
          route = "taman.getRFIDSet",
          payload = { }, 
        },
    ]);
  }



  public array function testResidentLog() {
    return this._suite.run("nac", [
        {
          route = "taman.logResidentAccess",
          payload =  {
            logs = [
              {
                type = "in"
                ,datetime = #dateAdd("n", now(), 10)#
                ,entryGranted = 1
                ,serialNo = "48615"
                ,entryType = "active"
                ,carRegNo = "WDB 7717"
                ,carImage = framework.data::getImageBase64()
              },
              { 
                type = "in"
                ,datetime = now()
                ,entryGranted = "yes"
                ,serialNo = "48612"
                ,entryType = "active"
                ,carRegNo = "from endpoint tester"
                ,carImage = framework.data::getImageBase64()
              },
              {
                type = "out"
                ,datetime = "2020-04-18T02:01:51.356Z"
                ,entryGranted = "YES"
                ,serialNo = "testing_card2"
                ,entryType = "active"
              },
            ]
          }
        }
    ])
  }



  public array function testRoot () {
    return this._suite.run("root", [
        { 
          route = "taman.pairVisitorAccess",
          payload = { 
            coid = 2,
          } 
        },
        { 
          route = "taman.getCardList",
          payload = { 
            coid = 2,
            cardType = 1,
          } 
        },
        { 
          route = "taman.getCardList",
          payload = { 
            coid = 2,
            cardType = 2,
          } 
        },
        { 
          route = "taman.saveCard",
          payload = {
            coId = 2, 
            usId = 4,
            cardId = 0, 
            cardType = 1, 
            cardStatus = 1, 
            cardCode = 'another_card1'
          } 
        },
    ]);
  }



  public array function testVms () {
    return this._suite.run("vms", [
      { 
        route = "taman.getTamanSet"
        ,payload = { } 
      },
      { 
        route = "taman.getTamanGuardSet"
        ,payload = { } 
      },
      { 
        route = "taman.getVisitorAccess"
        ,payload = { 
          fromDatetime = dateAdd('yyyy',-1, now())
          ,toDatetime = now()
          ,guardHouseId = 0
          ,entryType = "active"
          ,residentStreet = "11/1"
          ,houseId = 0
          ,carregno = "xxf"
          ,visitorId = ""
          ,reason = ""
        } 
      },
      { 
        route = "taman.VMSPing",
        payload = { }, 
      },
      {
        route = "taman.getQRSeq",
        payload = { } 
      },
      { 
        route = "taman.getQRSet",
        payload = { }, 
      },
    ]);
  }



  public array function testVisitorLog () {
    return this._suite.run("vms", [
        {
          route = "taman.logVisitorAccess",
          payload =  {
            logs = [
              // {
              //   type = "in"
              //   ,datetime = #dateAdd("n", now(), 10)#
              //   ,entryGranted = 1
              //   ,serialNo = "48615"
              //   ,serialType = 2
              //   ,entryType = "active"
              //   ,carRegNo = "WDB 7717"
              //   ,carImage = framework.data::getImageBase64()
              //   ,houseId = 6
              //   ,visitorType =2 
              //   ,visitorContact1 = "contact2"
              //   ,visitorContact2 = "contact2"
              //   ,visitorIdType = 1
              //   ,visitorIdNo = "hasfsadf"
              //   ,visitorICImage = framework.data::getImageBase64()
              // },
              { 
                datetime = "2020-11-23T01:01:17.968Z"
                ,serialNo = "testing_visitor2"
                ,entryType = "active"
                ,entryGranted = "yes"
                ,type = "in"
                ,houseId = 3
                ,carRegNo = "ABC1234"
                ,carImage = "" // framework.data::getImageBase64()
                ,visitorId = ""
                ,visitorImage = framework.data::getImageBase64()
                ,reason = "Others"
              },
              { 
                type = "in"
                ,datetime = now()
                ,entryGranted = "yes"
                ,serialNo = "48612"
                //,serialType = 2
                ,entryType = "active"
                ,carRegNo = "from endpoint tester"
                ,carImage = framework.data::getImageBase64()
                ,houseId = 6
                //,visitorType =2 
                //,visitorContact1 = "contact2"
                //,visitorContact2 = "contact2"
                //,visitorIdType = 1
                ,visitorId = "hasfsadf"
                ,visitorImage = framework.data::getImageBase64()
                ,reason = "testing"
              },
              {
                type = "out"
                ,datetime = "2020-04-18T02:01:51.356Z"
                ,entryGranted = "YES"
                ,serialNo = "testing_visitor2"
                ,entryType = "active"
              },
            ]
          }
        }
    ]);
  }



  public array function testDoc () {
    // Doc testing
    // var testDoc = new framework.testRunner( argumentCollection = this._env.configForRunner("vms") );
    // writeOutput("
    //   <h1> Doc </h1>
    //   <h3>(targetHost: #this._env.getHost()#)</h3>
    // ");
    // testDoc.runDoc(1);
  }
}
