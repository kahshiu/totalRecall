component router {

    public static array function resolve (
        required struct mapRoute, 
        required string urlRoute,
        string basePath = "api",
        string baseRoute = "error", 
    ) {
        var _path = basePath;
        var _route = baseRoute;

        if(urlRoute != "") {
            var brokenRoute = listToArray(urlRoute,".");

            // assume subdirectories
            if(arrayLen(brokenRoute) > 1) {
                var part1 = trim(brokenRoute[1]);
                var part2 = trim(brokenRoute[2]);
                var path = arrayToList([basePath, part1],"/");
                if(
                    structKeyExists(mapRoute, path) and 
                    structKeyExists(mapRoute[path], part2)
                ) {
                    _path = path; 
                    _route = part2;
                }

            // assume base directory
            } else if (arrayLen(brokenRoute) > 0) {
                var part1 = trim(brokenRoute[1]);
                if(
                    structKeyExists(mapRoute, basePath) and 
                    structKeyExists(mapRoute[basePath], part1)
                ){
                    _path = basePath;
                    _route = part1;
                }
            }
        }
        return [_path, _route];
    }

    public static struct function getParams (
        required struct req,
    ) {
        var params = url;
        if(req.method == "post") {
            params = structAppend(form, url, false);
        }
        return params;
    }

    public static any function run (
        required struct mapRoute,
        required array target,
        required struct params,
    ) {
        var _path = target[1];
        var _route = target[2];
        var pagePath = mapRoute[_path][_route];
        cfmodule(template=pagePath);
    }

}
