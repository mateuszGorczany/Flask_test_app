#!/usr/bin/env python

import unittest
import xmlrunner
import app

class TestApp(unittest.TestCase):
    
    def setUp(self):
        app.app.testing = True
        self.app = app.app.test_client()
        
    def test_home(self):
        rv = self.app.get("/")
        self.assertEqual(rv.status, "200 OK")
        self.assertEqual(rv.data, b"Witaj\n")

    def test_greet(self):
        rv = self.app.get("/greet/")
        self.assertEqual(rv.status, "200 OK")
        self.assertEqual(rv.data, b"Witaj\n")

    def test_greet_user(self):
        name = "Mateusz"
        rv = self.app.get(f"/greet/{name}")
        self.assertEqual(rv.status, "200 OK")
        self.assertEqual(rv.data, b"Witj Mateusz\n")
        

if __name__ == "__main__":
    runner = xmlrunner.XMLTestRunner(output="test_report")
    unittest.main(testRunner=runner)
    unittest.main(verbosity=2)