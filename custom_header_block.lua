data = ngx.shared.data
h = ngx.req.get_headers()
prefix = h['prefix']
filename = h['filename']
work_dir = '/home/ivan/nginx_configs/lua_configs/'
exstentions = {
    "jpg", "jpeg", "gif", "png", "bmp", 
    "tif", "tiff", "zip", "gz" ,"bz2", 
    "flv", "mp3", "mp4", "m4v", "m4a", "ts"
}

-- local headers = {'X-Forwarded-For', 'X-Real-IP', 'Accept-Encoding', 'Host'}
                
-- for i, header_name in pairs(headers) do
--     ngx.header[prefix..header_name] = data:get(prefix..header_name)
-- end
function get_add_data(name)
        f = io.open(work_dir..filename, "rb")
        if f == nill then 
            ngx.header["Erorr"] = "JSON FILE NOT FOUND"
            return ngx.exit(404)
        else
            local content = f:read("*all")
            f:close()
            local cjson = require("cjson")
            local value = cjson.decode(content)
            for key,val in pairs(value) do
                success, err, forcible = ngx.shared.data:set(key, val)
                data[key] = val
                if not success then
                    ngx.header["Erorr"] = "JSON FILE "..filename.."Cannot decode"
                    return ngx.exit(404)
                end
            end
        end
      return data:get(name)
end



ngx.header[prefix.."X-Forwarded-For"] = data:get(prefix.."X-Forwarded-For") or get_data(prefix.."X-Forwarded-For")
ngx.header[prefix.."X-Real-IP"] = data:get(prefix.."X-Real-IP") or get_data(prefix.."X-Real-IP")
ngx.header[prefix.."Accept-Encoding"] = data:get(prefix.."Host") or get_data(prefix.."Host")

if ngx.var.http_accept_encoding then
    if string.find(ngx.var.http_accept_encoding, "gzip") then
        ngx.var.acpt_enc = "gzip"
        ngx.var.colon = ""
        ngx.header['Accept-Encoding'] = "gzip"
    end           
else
    _, uri_exstension = ngx.var.uri:match("([^,]+),([^,]+)")
    for i, val in pairs(exstentions) do
        if val == uri_exstension then
            ngx.var.acpt_enc =  ""
            ngx.var.colon  = ""
            ngx.header['Accept-Encoding'] = ""
            break     
        end
    end
end