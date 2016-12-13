data = ngx.shared.data

-- my_data = {'proxy_cache_key', 'proxy_pass', 'proxy_hide_header', 'proxy_cache', 'proxy_temp_path', 'expired_time'}
h = ngx.req.get_headers()
prefix = h['prefix']
filename = h['filename']


function get_data(key)
        f = io.open(filename, "rb")
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


ngx.var.cdn_proxy_cache_key =  data:get(prefix.."proxy_cache_key") or get_data(prefix.."proxy_cache_key")
ngx.var.cdn_proxy_pass = data:get(prefix.."proxy_pass") or get_data(prefix.."proxy_pass")
ngx.var.cdn_proxy_hide_header = data:get(prefix.."proxy_hide_header") or get_data(prefix.."proxy_hide_header")
ngx.var.cdn_proxy_cache = data:get(prefix.."proxy_cache") or get_data(prefix.."proxy_cache")
ngx.var.cdn_proxy_temp_path = data:get(prefix.."proxy_temp_path") or get_data(prefix.."proxy_temp_path")