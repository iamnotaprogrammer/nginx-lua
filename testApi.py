import unittest
import requests

class TestAPIMethods(unittest.TestCase):

    def test_purge_parameters(self):
        'http://localhost:8080/clear/'
    
    def test_add_parameters(self):
        """http://localhost:8086/ """
        pass
    
    def test_custom(self):
        '''curl -v --header 'prefix: sbr_' --header 'filename: data.json' http://localhost:8089/'''
        pass
    
    def test_use_header(self):
        pass



    
if __name__ == '__main__':
    unittest.main()