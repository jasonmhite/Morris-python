import morris_test as mt
import numpy as np

b0 = np.array(np.random.randn(), 'f')
b1 = np.random.randn(20)
b2 = np.random.randn(20, 20)
b3 = np.random.randn(20, 20, 20)
b4 = np.random.randn(20, 20, 20, 20)


for i in xrange(10):
    b1[i] = 20.

for i in xrange(6):
    for j in xrange(6):
        b2[i, j] = -15.

for i in xrange(5):
    for j in xrange(5):
        for k in xrange(5):
            b3[i, j, k] = -10.

for i in xrange(4):
    for j in xrange(4):
        for k in xrange(4):
            for l in xrange(4):
                b4[i, j, k, l] = 5.

b1 = b1.copy('f')
b2 = b2.copy('f')
b3 = b3.copy('f')
b4 = b4.copy('f')

def morris(x):
    xt = x.copy('f')
    return mt.morris(xt, b0, b1, b2, b3, b4)
