import math
from basic_ops_calculator.operations import basic, advanced
import unittest

class Test_basic_ops_calculator(unittest.TestCase):

    def test_soma(self):
        a = 6
        b = 3
        c = basic.make_sum(a, b)
        self.assertEqual(c, 9)

    def test_subtracao(self):
        a = 6
        b = 3
        c = basic.make_subtraction(a, b)
        self.assertEqual(c, 3)

    def test_multiplicacao(self):
        a = 6
        b = 3
        c = basic.make_multiplication(a, b)
        self.assertEqual(c, 18)

    def test_divisao(self):
        a = 6
        b = 3
        c = basic.make_division(a, b)
        self.assertEqual(c, 2)

    def test_log(self):
        a = 3
        b = 9
        c = advanced.logarithm(a, b)
        self.assertEqual(c, 0.5)

    def test_ln(self):
        a = 1
        c = advanced.natural_logarithm(a)
        self.assertEqual(c, 0)

    def test_exponencial(self):
        a = 1
        c = advanced.exponential_base_e(a)
        self.assertEqual(c, math.e)