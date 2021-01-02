<cfset targetHost = "http://localhost:8888/testing">
<cfoutput>
<html>
  <head>
    <script>
      function isValueSingle(inputType) {
        return inputType === "radio" 
          || inputType === "text"
          || inputType === "password"
          || inputType === "email";
      }
      function getValueByProp(e) {
        if( e.type === "radio"
          || e.type === "checkbox"
        ) return e.checked? e.value: null;

        if(e.type === "text"
          || e.type === "password"
          || e.type === "email"
        ) return e.value
      }
      function getInputValues(inputType, n) {
        const values = [];
        const isSingle = isValueSingle(inputType);

        const els = document.getElementsByName(n);
        for(const [index, e] of els.entries()) {

          if(e.type === inputType.toLowerCase()) {
            const v = getValueByProp(e);

            if(v !== null) values.push(v); 
            if(v !== null && isSingle) break;
          }
        }
        return values;
      }


      function setValueByProp(e, values) {
        let flag = false;

        if( e.type === "radio"
          || e.type === "checkbox"
        ) {
          flag = values.includes(e.value);
          e.checked = flag;
        }

        if(e.type === "text"
          || e.type === "password"
          || e.type === "email"
        ) {
          flag = true;
          e.value = values[0];
        }

        return flag 
      }
      function setInputValues (inputType, n, values) {
        const isSingle = isValueSingle(inputType);

        const els = document.getElementsByName(n);
        for(const [index, e] of els.entries()) {

          if(e.type === inputType.toLowerCase()) {
            const isDone = setValueByProp(e, values);
            if(isDone && isSingle) break;
          }
        }
      }

// groping mechanics
function push2Level(flag, obj, key, value) {
  if(flag) {
    if(obj[key] === undefined) obj[key] = [];
    obj[key].push(value);
  }
}

      // join params
      function joinParam(obj, joinKV, joinPair) {
        const _joinKV = joinKV !== undefined? joinKV: "=";
        const _joinPair = joinPair !== undefined? joinPair: "&";

        const pairs = [];
        for(const [index, value] of Object.entries(obj) ) {
          pairs.push( [index,value].join(_joinKV) );
        }
        return pairs.join(_joinPair);
      }
    </script>
  </head>
  <body>
    <br><input type="radio" id="env1" name="env" value="DEV" checked> <label for="env1"> DEV </label>
    <br><input type="radio" id="env2" name="env" value="PROD">        <label for="env2"> PROD </label>
    <br>
    <br><label for="sessionToken"> SessionToken </label>
    <br><input type="text" id="sessionToken" name="sessionToken" value=""> 
    <br>
    <br> <button id="checkAll"  > Check all</button> <button id="uncheckAll"  > Uncheck All</button>
    <br><input type="checkbox" id="sample1" name="sample" value="testNac"        > <label for="sample1"> testNac        </label>
    <br><input type="checkbox" id="sample2" name="sample" value="testResidentLog"> <label for="sample2"> testResidentLog</label>
    <br><input type="checkbox" id="sample3" name="sample" value="testVms"        > <label for="sample3"> testVms        </label>
    <br><input type="checkbox" id="sample4" name="sample" value="testVisitorLog" > <label for="sample4"> testVisitorLog </label>
    <br><input type="checkbox" id="sample5" name="sample" value="testSearch"     > <label for="sample5"> testSearch     </label>
    <br><input type="checkbox" id="sample6" name="sample" value="testPairing"    > <label for="sample6"> testPairing     </label>
    <br>
    <br><button id="launch"  > Launch testing pages </button>

    <script>
      document.getElementById("checkAll").onclick = function(){ 
        setInputValues("checkbox", "sample",[
          "testNac"
          ,"testResidentLog"
          ,"testVms"
          ,"testVisitorLog"
          ,"testSearch"
          ,"testPairing"
        ]);
      }
      document.getElementById("uncheckAll").onclick = function(){ 
        setInputValues("checkbox", "sample", [ ]);
      }

function grouping(store) {
  return function(v) {
    const group0 = [
      "testNac"
      ,"testResidentLog"
    ];
    const group1 = [
      "testVms"
      ,"testVisitorLog"
      ,"testSearch"
      ,"testPairing"
    ]
    push2Level(group0.includes(v), store, "group1", v);
    push2Level(group1.includes(v), store, "group2", v);
    return store;
  }
}

      const targetHost = "#targetHost#/page_testing.cfm";
      document.getElementById("launch").onclick = function(){ 
        const chosenEnv = getInputValues("radio", "env");
        const chosenSample = getInputValues("checkbox", "sample");
        const sessionToken = getInputValues("text", "sessionToken");

        console.log("ENV", chosenEnv);
        console.log("SAMPLE", chosenSample);
        console.log("TOKEN", sessionToken);

        const grouped = {};
        const sampleGroups = grouping(grouped);
        const targetUrls = [];

        for(const p of chosenSample) sampleGroups(p);
        console.log("tracing groups", grouped);

        for(const [index,p] of Object.entries(grouped)) {
          targetUrls.push([
            targetHost
            ,joinParam({
              env: chosenEnv[0]
              ,sample: p.join(",")
              ,token: sessionToken[0]
            })
          ].join("?"))
        }

        for(const u of targetUrls) {
          console.log("tracing urls", u);
          window.open(u, "_blank");
        }
      }
    </script>
  </body>
</html>
</cfoutput>
