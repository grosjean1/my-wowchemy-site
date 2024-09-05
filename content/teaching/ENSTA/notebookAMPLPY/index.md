---
# Documentation: https://docs.hugoblox.com/managing-content/

title: "NotebookAMPLPY"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2024-09-05T21:34:11+02:00
lastmod: 2024-09-05T21:34:11+02:00
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
#Install package
import sys
!{sys.executable} -m pip install numpy
!{sys.executable} -m pip install matplotlib
!{sys.executable} -m pip install amplpy
```


```python
from amplpy import AMPL # import pyAMPL
```


```python
from amplpy import ampl_notebook

ampl = ampl_notebook(
    modules=["cplex"],  # modules to install
    license_uuid="default",  # license to use
)  # instantiate AMPL object and register magics
```


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


```python
ampl.display("xx");# xx,yy;
ampl.display("f");
ampl.display("g.dual");
ampl.display("h.dual");
```


```python

```
