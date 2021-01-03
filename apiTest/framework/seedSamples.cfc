component seedSamples extends testSuite {

  public any function init(
    required string envString
    ,string token
  ) {
    this._suite = new testSuite(argumentCollection=arguments);
  }

// invoice/ payment related
  public array function integration3 () {
    return this._suite.run("root", [
      {
        route = "taman.savePayment"
        ,payload: {
          myaccount = 1,
          chargeraccount = 6,
          payamount = 40,
          itemIds = "1|2"
        }
      },
      {
        route = "taman.getCharges"
        ,payload: {
          usId = 11
        }
      },
      {
        route = "taman.saveSecurityCharges"
        ,payload: {
          coId = 2
        }
      },
      // {
      //   route = "fw.saveAccount"
      //   ,payload: {
      //     entityType = 2,
      //     entityId = 11
      //   }
      // },
      // {
      //   route = "fw.saveAccount"
      //   ,payload: {
      //     entityType = 2,
      //     entityId = 12
      //   }
      // },
      // {
      //   route = "fw.saveAccount"
      //   ,payload: {
      //     entityType = 2,
      //     entityId = 13
      //   }
      // },
      // {
      //   route = "fw.saveAccount"
      //   ,payload: {
      //     entityType = 2,
      //     entityId = 14
      //   }
      // },
      // {
      //   route = "fw.saveAccount"
      //   ,payload: {
      //     entityType = 1,
      //     entityId = 2
      //   }
      // },
    ])
  }

  public array function integration2 () {
    return this._suite.run("allen", [
      {
        route = "fw.synchCompany",
        payload = { 
          coId = 2
        } 
      },
      {
        route = "fw.synchCompanyUsers",
        payload = { 
          coId = 2
        } 
      },
      // {
      //   route = "fw.updateCompanyHash",
      //   payload = { coId = 2 } 
      // },
      // {
      //   route = "fw.updateUserVeriHash",
      //   payload = { coId = 2, usId = 11 } 
      // },
      // {
      //   route = "fw.updateUserVeriHash",
      //   payload = { coId = 2, usId = 12 } 
      // },
      // {
      //   route = "fw.updateUserVeriHash",
      //   payload = { coId = 2, usId = 13 } 
      // },
      // {
      //   route = "fw.updateUserVeriHash",
      //   payload = { coId = 2, usId = 14 } 
      // },
      {
        route = "fw.checkUserVeriHash",
        payload = { 
          coHash = "A9BD4F2903227B2A7EBA1853171FA794D0D1B157D71FA9548595F20284C67A9AC1B8DD0735FA264889661E325D0F9C2DACF4CCA01A38B800CB4413E14FBA07A5", 
          idHash = hash("754845164688", "sha-512")
          //idHash = hash("1212", "sha-512")
        } 
      },
      {
        route = "taman.getAnnouncements",
        payload = { 
          coId = 2
        } 
      },
      // {
      //   route = "taman.saveAnnouncements",
      //   payload = { 
      //     annId = 0,
      //     content="hello smartjaga",
      //     startOn="2020-01-01",
      //     expireOn="2020-12-31",
      //     coId = 2
      //   } 
      // },
      // {
      //   route = "taman.saveAnnouncements",
      //   payload = { 
      //     annId = 0,
      //     content="hello jaja bing",
      //     startOn="2020-01-01",
      //     expireOn="2020-12-31",
      //     coId = 2
      //   } 
      // },
      // {
      //   route = "taman.saveAnnouncements",
      //   payload = { 
      //     annId = 0,
      //     content="hello world",
      //     startOn="2020-01-01",
      //     expireOn="2020-01-31",
      //     coId = 2
      //   } 
      // },
      // {
      //   route = "taman.saveAnnouncements",
      //   payload = { 
      //     annId = 0,
      //     content="hello announcements",
      //     startOn="2020-01-01",
      //     expireOn="2020-01-31",
      //     coId = 2
      //   } 
      // },
    ])
  }

  public array function integration () {
    return this._suite.run("root", [
      // DEV: coid=6, usid=40
      //{
      //  route = "fw.saveCompany"
      //  ,payload: {
      //    coId = 0,
      //    coName = "Ionsoft",
      //    coCode = "ionsoft",
      //    coType = 3,
      //    coStatus = 1,
      //    address1 = "",
      //    address2 = "",
      //    address3 = "",
      //    postcode = "",
      //    town = 362,
      //    state = 13
      //  }
      //},

      // {
      //   route = "fw.saveUser"
      //   ,payload = {
      //     usId = 0 
      //     ,usType = 6 
      //     ,usName = "allen"          
      //     ,coId = 5 
      //     ,idType = 0 
      //     ,idNo = "" 
      //     ,contact1 = "" 
      //     ,contact2 = "" 
      //     ,usStatus = 1
      //   }
      // },

      // {
      //   route = "fw.saveUserPassword",
      //   payload = { 
      //     usId = 31
      //     ,userName = hash("allen","sha-512")       
      //     ,password = hash("test123","sha-512")       
      //   } 
      // },

    ]);
  }

  public array function updateUser () {
    return this._suite.run("root", [
          {
            route = "fw.saveUser"
            ,payload = {
              usId = 28 
              ,usType = 3 
              ,usName = "puteri_11_vms_2"          
              ,coId = 2 
              ,idType = 0 
              ,idNo = "" 
              ,contact1 = "" 
              ,contact2 = "" 
              ,usStatus = 1
              ,houses = [
                {
                  houseId = 480
                  ,ownershipType = 4
                  ,ownershipStatus = 1
                  ,isPrimary = 1
                },
              ]
            }
          },
          {
            route = "fw.saveUser"
            ,payload = {
              usId = 29 
              ,usType = 2 
              ,usName = "puteri_11_nac_2"          
              ,coId = 2 
              ,idType = 0 
              ,idNo = "" 
              ,contact1 = "" 
              ,contact2 = "" 
              ,usStatus = 1
              ,houses = [
                {
                  houseId = 480
                  ,ownershipType = 3
                  ,ownershipStatus = 1
                  ,isPrimary = 1
                },
              ]
            }
          }
    ]);
  }


  public array function createCred () {
    return this._suite.run("root", [
        // {
        //   route = "fw.saveUserPassword",
        //   payload = { 
        //     usId = 28
        //     ,userName = hash("puteri_11_vms_2","sha-512")       
        //     ,password = hash("test123","sha-512")       
        //   } 
        // },
        {
          route = "fw.saveUserPassword",
          payload = { 
            usId = 9
            ,userName = hash("pua","sha-512")       
            ,password = hash("test123","sha-512")       
          } 
        },
    ]);
  }

  public array function createUser () {
    return this._suite.run("root", [
        {
          route = "fw.saveUser",
          payload = { 
             usId = 0 
            ,usType = 3 
            ,usName = "puter_11_vms_2"       
            ,coId = 2 
            ,idType = 0 
            ,idNo = "" 
            ,contact1 = "" 
            ,contact2 = "" 
            ,usStatus = 1
          } 
        },
        {
          route = "fw.saveUser",
          payload = { 
             usId = 0 
            ,usType = 2 
            ,usName = "puter_11_nac_2"       
            ,coId = 2 
            ,idType = 0 
            ,idNo = "" 
            ,contact1 = "" 
            ,contact2 = "" 
            ,usStatus = 1
          }, 
        },
    ]);
  }


}
