-- local cjson = require("cjson")
-- ngx.var.request:split(" ")[2]
-- local m = ngx.re.match(path,[=[/([^/]+)\.(json|xml)$]=])
-- local res = ngx.location.capture(/home/ivan/json/m[1] .. ".json" )
-- local value=cjson.new().decode(res.body)

work_dir = '/home/ivan/nginx_configs/lua_configs/'

function get_data(filename)
        f = io.open(filename, "rb")
        if f == nill then 
            ngx.header["Erorr"] = "JSON FILE NOT FOUND"
            return false
        else
            local content = f:read("*all")
            f:close()
            local cjson = require("cjson")
            local value = cjson.decode(content)
            for key,val in pairs(value) do
                success, err, forcible = ngx.shared.data:set(key, val)
                if not success then
                    ngx.header["Erorr"] = "JSON FILE "..filename.."Cannot decode"
                    return false
                end
            end
        end
      return true
end

local lfs = require('lfs')
for file in lfs.dir(work_dir) do
    if (lfs.attributes(file,"mode") == "file") and string.find(file, 'a%.json') then
        ngx.say(file)
       if not get_data(work_dir..file) then
            ngx.exit(404)
        end
    end
end
ngx.exit(200)