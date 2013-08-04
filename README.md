Morris-python
=============

This package implements the test function of Morris as presented in *Factorial Sampling Plans for Preliminary Computational Experiments*. This function is commonly used to test algorithms that seek to identify subsets of parameters that are the most important contributors to total model variation. If you want to know more, I refer you to the classic original paper from 1991.

It can be difficult to implement this function efficiently in pure Python or NumPy, thus this code mixes Fortran and Python for maximum speed.

Requirements
------------

To compile you will need:

* Python (tested on 2.7.3)
* NumPy
* SciPy 
* A Fortran 95 compiler (tested with gFortran)

You need to build the Fortran module using f2py:

*Build function signatures*

    f2py -m morris_test -h morris.pyf morris.f95 --overwrite-signature

*Compile*

    f2py -c morris.pyf morris.f95

This will output morris_test.so, which is the Fortran code built into a Python module. Copy this and morris.py into your directory. If you use something other than gFortran you will need to configure it to work with SciPy.

morris.py is a convenient interface for the Fortran code and contains all of the initialization code. I do not recommend using the Fortran module directly unless you know what you are doing. Calling is simple:

````python
from morris import morris
import numpy as np 
print morris(np.ones(20))
````

Notes
-----

This is probably not the most efficient implementation possible. It's *fast enough* for my purposes, so take it for what it's worth.
