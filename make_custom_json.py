import os
import sys
import json


prefix = sys.argv[1]

data = {}
data[prefix +'proxy_cache_key'] = 'http://127.0.0.1:8002/showheaders/'
data[prefix +'proxy_pass'] = 'http://127.0.0.1:8082/'
data[prefix +'proxy_hide_header'] = 'X-CDN-Cache-Status'
data[prefix +'proxy_cache'] = 'sberbank'
data[prefix +'X-Forwarded-For'] = 'sbr_X-Forwarded-For'
data[prefix +'X-Real-IP'] = 'sbr_X-Real-IP'
data[prefix +'Accept-Encoding'] =  'sbr_Accept-Encoding' 
data[prefix +'Host'] = 'sbr_HOST'
data[prefix +'proxy_temp_path'] =  '/path/to/cache/'

with open(prefix + '.json', 'w') as f :
    json.dump(data,f)
