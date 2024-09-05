---
# Documentation: https://docs.hugoblox.com/managing-content/

title: "Exercice Gradient descent - Notebook"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2024-09-05T21:21:34+02:00
lastmod: 2024-09-05T21:21:34+02:00
featured: false
draft: false

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder.
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false

# Projects (optional).
#   Associate this post with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `projects = ["internal-project"]` references `content/project/deep-learning/index.md`.
#   Otherwise, set `projects = []`.
projects: []
---
```python
import sys
!{sys.executable} -m pip install numpy
!{sys.executable} -m pip install matplotlib
!{sys.executable} -m pip install amplpy
```

    Requirement already satisfied: numpy in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (2.0.0)
    
    [1m[[0m[34;49mnotice[0m[1;39;49m][0m[39;49m A new release of pip is available: [0m[31;49m24.0[0m[39;49m -> [0m[32;49m24.2[0m
    [1m[[0m[34;49mnotice[0m[1;39;49m][0m[39;49m To update, run: [0m[32;49m/usr/local/Cellar/jupyterlab/4.2.1/libexec/bin/python -m pip install --upgrade pip[0m
    Requirement already satisfied: matplotlib in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (3.9.1)
    Requirement already satisfied: contourpy>=1.0.1 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (1.2.1)
    Requirement already satisfied: cycler>=0.10 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (0.12.1)
    Requirement already satisfied: fonttools>=4.22.0 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (4.53.1)
    Requirement already satisfied: kiwisolver>=1.3.1 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (1.4.5)
    Requirement already satisfied: numpy>=1.23 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (2.0.0)
    Requirement already satisfied: packaging>=20.0 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (24.0)
    Requirement already satisfied: pillow>=8 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (10.4.0)
    Requirement already satisfied: pyparsing>=2.3.1 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (3.1.2)
    Requirement already satisfied: python-dateutil>=2.7 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from matplotlib) (2.9.0.post0)
    Requirement already satisfied: six>=1.5 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from python-dateutil>=2.7->matplotlib) (1.16.0)
    
    [1m[[0m[34;49mnotice[0m[1;39;49m][0m[39;49m A new release of pip is available: [0m[31;49m24.0[0m[39;49m -> [0m[32;49m24.2[0m
    [1m[[0m[34;49mnotice[0m[1;39;49m][0m[39;49m To update, run: [0m[32;49m/usr/local/Cellar/jupyterlab/4.2.1/libexec/bin/python -m pip install --upgrade pip[0m
    Requirement already satisfied: amplpy in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (0.14.0)
    Requirement already satisfied: ampltools>=0.7.5 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from amplpy) (0.7.5)
    Requirement already satisfied: requests in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from ampltools>=0.7.5->amplpy) (2.32.2)
    Requirement already satisfied: charset-normalizer<4,>=2 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from requests->ampltools>=0.7.5->amplpy) (3.3.2)
    Requirement already satisfied: idna<4,>=2.5 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from requests->ampltools>=0.7.5->amplpy) (3.7)
    Requirement already satisfied: urllib3<3,>=1.21.1 in /usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages (from requests->ampltools>=0.7.5->amplpy) (2.2.1)
    Requirement already satisfied: certifi>=2017.4.17 in /usr/local/opt/certifi/lib/python3.12/site-packages (from requests->ampltools>=0.7.5->amplpy) (2024.6.2)
    
    [1m[[0m[34;49mnotice[0m[1;39;49m][0m[39;49m A new release of pip is available: [0m[31;49m24.0[0m[39;49m -> [0m[32;49m24.2[0m
    [1m[[0m[34;49mnotice[0m[1;39;49m][0m[39;49m To update, run: [0m[32;49m/usr/local/Cellar/jupyterlab/4.2.1/libexec/bin/python -m pip install --upgrade pip[0m



```python
from amplpy import AMPL # import AMPL
```


```python
from amplpy import ampl_notebook

ampl = ampl_notebook(
    modules=["cplex"],  # modules to install
    license_uuid="default",  # license to use
)  # instantiate AMPL object and register magics
```

    AMPL Development Version 20240606 (Darwin-21.6.0, 64-bit)
    Demo license with maintenance expiring 20260131.
    Using license file "/usr/local/Cellar/jupyterlab/4.2.1/libexec/lib/python3.12/site-packages/ampl_module_base/bin/ampl.lic".
    



```python
%%ampl_eval
# define decision variables

reset;

# Declaration of optimization variables
var xx;
var yy;
# Declaration of parameters
param aa=-4;
param bb=2;
```


```python
%%ampl_eval
# Cost function
minimize f: 
    xx**2 + aa*(xx+yy) + 2*yy**2;
# Constraints
subject to g: xx+yy = bb;
subject to h: xx >= 0;
```


```python
%%ampl_eval
let xx:= 1;
let yy:=2;
```


```python
# exhibit the model that has been built
ampl.eval("show;")
ampl.eval("expand;")

# solve using two different solvers
ampl.option["solver"] = "cplex"
ampl.solve()

#ampl.option["solver"] = "highs"
#ampl.solve()
```

    
    parameters:   aa   bb
    
    variables:   xx   yy
    
    constraints:   g   h
    
    objective:   f
    minimize f:
    	xx^2 + 2*yy^2 - 4*xx - 4*yy;
    
    subject to g:
    	xx + yy = 2;
    
    subject to h:
    	xx >= 0;
    
    CPLEX 22.1.1.0: optimal solution; objective -5.333333333
    6 separable QP barrier iterations
    No basis.



```python
ampl.display("xx");# xx,yy;
ampl.display("f");
ampl.display("g.dual");
ampl.display("h.dual");
```

    xx = 1.33333
    
    f = -5.33333
    
    g.dual = -1.33333
    
    h.dual = 0
    



```python

```