import os
import sys
import unittest

# Make src/ importable without installation
CURRENT_DIR = os.path.dirname(__file__)
SRC_DIR = os.path.join(CURRENT_DIR, "..", "src")
sys.path.insert(0, os.path.abspath(SRC_DIR))

from python_app.core import greet, add  # type: ignore


class CoreTests(unittest.TestCase):
    def test_greet(self):
        self.assertEqual(greet("AI"), "Hello, AI!")

    def test_add(self):
        self.assertEqual(add(2, 3), 5)


if __name__ == "__main__":
    unittest.main(verbosity=2)
