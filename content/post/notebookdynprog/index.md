---
# Documentation: https://docs.hugoblox.com/managing-content/

title: "TP1"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2024-12-16T22:38:00+01:00
lastmod: 2024-12-16T22:38:00+01:00
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

```


```python
# import packages

import numpy as np
import scipy
from scipy import optimize
from scipy.optimize import minimize
```

## Deterministic model

- Time scale: the decisions are taken every hour during the day.

- Optimization variables (at each time step) :
    - the amount of energy to be stored or withdrawn from the battery
    - the amount of energy bought or sold to the network.

- Contraints:
    -  nonnegativity of variables
    -  evolution of the battery
    -  storage capacity of the battery.

-  Cost function:
    - Cost of the energy bought on the network...
    - minus the cost of the energy sold on the network.

#### The problem is modeled by:

- Horizon: 24 hours, stepsize: 1 hour. 
- Optimization over $T= 24$ intervals.

- Optimisation variable :
    - $x(s)$ : state of charge of the battery at time $s$, $s= 0,...,T$
    - $a(s)$: amount of electricity bought on the network ($s= 0,...,T-1$).
    - $v(s)$: amount of energy sold on the network ($s= 0,...,T-1$). 


- Parameters:
    - $d(s)$: net demand of energy (load minus solar production) at time $s$, $s= 0,...,T-1$.
    - $P_a(s)$ : unitary buying price of energy at time $s$, $s= 0,...,T-1$
    - $P_v(s)$ : unitary selling price of energy at time $s$, $s= 0,...,T-1$
    - $x_{\max}$: storage capacity of the battery.

- Contraints:
    - $x(s+1)= x(s) - d(s) + a(s) - v(s)$, $\forall s= 0,...,T-1$
    - $x(0)= 0$
    - $a(s) \geq 0$, $\forall s=0,...,T-1$
    - $v(s) \geq 0$, $\forall s=0,...,T-1$
    - $0 \leq x(s) \leq x_{\max}$, $\forall s=0,...T$.

- Cost function to be minimized:
    $$J(x,a,v)= \sum_{s=0}^{T-1} \Big( P_a(s) a(s) - P_v(s) v(s) \Big).$$



## Exercice 1

Write the optimization problem in a form that is compatible with the function linprog

% Exercise 1: Indication: you should find optimal value= 124



```python
T= 24; # Time
x_max= 5; # battery maximum storage 
P_a= np.array([2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 3, 3, 2]); # unitary buying price of energy at time s
P_v= np.array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1]); # unitary selling price of energy at time s

d =np.array([-1, -1, -1, -1, -1, -2, 2 ,6, 8, 4, 2,  0,  0, -1, -2, -1,  0,  1, 3, 7, 9, 3, 2,  0]); # net demand of energy (already known)
#d =np.array([-2, -2, -2, -2, -2, -3, 1 ,4 ,6 ,3 ,1, -1, -1, -2, -3, -2, -1,  0, 2 ,5 ,5, 2, 1, -1]);
#d =np.array([-3 ,-3 ,-3 ,-3 ,-3 ,-4 ,0 ,2 ,4, 2, 0 ,-2 ,-2 ,-3 ,-4 ,-3 ,-2 ,-1 ,1 ,3 ,5 ,1 ,0 ,-2]);

d=d.reshape((T,1))
P_a=P_a.reshape(T,1)
P_v=P_v.reshape(T,1)

# with T=2 (for testing purposes ...)
# T = 2;
#x_max= 5;

#P_a=np.array([-1, -1])
#P_v=P_a
#d =np.array([-1, -1])
#d=d.reshape(T,1)
#P_a=P_a.reshape(T,1)
#P_v=P_v.reshape(T,1)
```


```python
def solve_deterministic_pb():
    global d, P_a,P_v
    """ print x,a,v and J(x,a,v) """ 
    
    """ 
    #######  Inequality constraints: #######
    
    xi<=xmax for i = 0.. T: concatenate A1=Identity matrix & A2 & A2
    ---------------
    -x<=0 (size T+1 ! )
    -a<=0 (size T)
    -v<=0 (size T) : identity matrix A3 (size 3T+1)
    ---------------
    
    #A X <= B 
    Indications: with A of shape((len(x)+1 + len(a)+1 + len(v)+1 , len(x) + len (a) + len(v))) #e.g. (10, 7) for T=2
    with B= [x_max*np.ones(T+1,1)],
             np.zeros((3*T+1,1))];
    """

    # xi<=xmax for i = 0.. T: concatenate A1=Identity matrix & A2 & A2
    A1=...
    A2=...
    A=np.concatenate((A1,A2,A2), axis=1)

    # -x, -a, -v <= 0,0,0
    A3=...
    A=...

    #print(np.shape(A))

    # xi<=xmax for i = 0.. T
    B1=...
    # -x, -a, -v <= 0,0,0
    B3=...
    
    B=np.concatenate((B1.transpose(),B3), axis=0);
    #print(B)

    """ 
    ####### Equality constraints: #######
    ---------------
    Aeq1:
    x(s+1)-x(s)-a(s)+v(s)=-d(s) for all s=0...T-1
    -1.  1. on the diagonal (-x(s)+x(s+1))
    -1 for a(s)
    1 for v(s) 
    
    ---------------
    Aeq2
     x(0)=0 
   
    ---------------
    
    # Aeq X = Beq 
    with Beq= [-d,0] # -d for Aeq1 and 0 for Aeq2
    
    """
    # Aeq1:
    M1=... #-x(s) and x(s+1) s=0, T-1
    M2=... #
    M=np.concatenate((-M1,M2), axis=1)+np.concatenate((M2,M1),axis=1)
    
    Aeq1=... # M & -a(s) & v(s) s=0, T-1
    Aeq2=... # #x(0)=0, (with concatenate, don't use axis=1 for only one line, use double parentheses)
    #print(Aeq2)
    Aeq=np.concatenate((Aeq1,Aeq2.transpose()),axis=0)
    #print(Aeq)
   
    Beq=np.concatenate((-d,np.zeros((1,1)))) 
    #print(Beq)
    """ 
    solving min c^T * X s.t. A X <= B and Aeq X= Beq
    no x in min: 0; 
    a P_a -v P_v
    """ 
    # min c^T [x,a,v]
    c=...#cost function: sum_s P_a a(s) - P_v(v)
    #print(c)  #columns of A must be equal to size of c
    X=optimize.linprog(...)
   
    print("x:", X.x[:T+1])
    print(np.shape(X.x[:T+1]))
    print("a:", X.x[T+1:2*T+1])
    print(np.shape(X.x[T+1:2*T+1]))
    print("v:", X.x[2*T+1:])
    print(np.shape(X.x[2*T+1:]))
    print("Optimal cost", X.fun)
```


```python
solve_deterministic_pb()
```

    x: [-0.  0.  0.  1.  2.  3.  5.  5.  0.  0.  0.  0.  0.  0.  1.  3.  5.  5.
      5.  5.  0.  0.  0.  0.  0.]
    (25,)
    a: [ 0.  0.  0.  0.  0.  0.  2.  1.  8.  4.  2. -0. -0.  0.  0.  1. -0.  1.
      3.  2.  9.  3.  2.  0.]
    (24,)
    v: [ 1.  1. -0.  0.  0.  0.  0.  0.  0.  0.  0.  0.  0.  0.  0.  0.  0.  0.
      0.  0.  0.  0.  0. -0.]
    (24,)
    Optimal cost 124.0


# Exercice 2
### interpolation d'ordre 2
% with y=[0 1 2] and val=[1 3 7], the solution is alpha= [1 1 1]


```python
from scipy.optimize import minimize
```


```python
def interpolate_2(y,val):

    def objective(alpha):
        return ...

    # initial guess
    n = 3
    alpha0 = np.zeros(n)

    # show initial objective
    #print('Initial SSE Objective: ' + str(objective(alpha0)))

    # optimize
 
    solution = minimize(...) 
    #print('Output SSE Objective: ' + str((solution.fun)))
    #print('Optimal minimizers: ' + str((solution.x)))
    return solution.x
```


```python
#% Exercise 2: with y=[0 1 2] and z=[1 3 7], the solution is alpha= [1 1 1]
y=np.array([0,1,2])
val=np.array([1,3,7])
interpolate_2(y,val)
```




    array([0.99999997, 1.00000017, 0.99999991])



# Exercice 3

### DP_solve


```python
def DP_solve(t,y,alpha):
    def cost(X):
        # X[0]=y X[1]=a, X[2]= v 
        # inf P_a*a -Pv*v + V(t+1,z) (V(t+1, z) en fonction de plusieurs valeurs de z
        return ...

    # x,a,v>=0, x<=xmax -> bounds
    # z -a +v = y -d[t] -> contraints
    
    #print(d[t])
   
    cons = ({'type': 'eq', 'fun': lambda x: ...})
    bnds = (...)
    res = minimize(...);
    X=res.x
    #print("objective solution: ",res.fun)
    #print("min solution: ",res.x)
    z= X[0];
    a= X[1];
    v= X[2];
    
    return z,a,v,res.fun
    


```


```python
t=0, 
y=0, 
alpha=np.array([ 1, -2,  1])
DP_solve(t,y,alpha)
# the solution is z= 0.5, a= 0, v= 0.5, the optimal value is -0.25.
```




    (0.49999999068677436, 0.0, 0.5000000093132256, -0.24999999999999992)



# Exercice 4


```python
J=10
def DP_backward():
    
    global T;
    global J;
    global x_max;
    
    alpha= np.zeros((3,T+1));#V(T+1,z)=0
    y_grid= np.zeros(J)
    
    for j in range(J):
        y_grid[j]=... #yj={0,...,x_max}, j=0...J-1
        
    for t in reversed(range(T)): # Backward in time 
    
        Val_update=np.zeros(J) #V(t+1,z)
        for j in range(J): # for all value y_j, we evaluate V(t,y_j) (first with alpha=0 )
            _,_,_,val= DP_solve(...)
            
            Val_update[j]= val;

        #print(y_grid,"z",z)
        alpha[:,t]= interpolate_2(...); # (then with alpha = interpolation of V(t,y_j) and so on...)

    return alpha
```


```python
DP_backward()
```




    array([[ 1.23631437e+02,  1.24791155e+02,  1.26095882e+02,
             1.27656100e+02,  1.29587347e+02,  1.31916134e+02,
             1.40773709e+02,  1.34773709e+02,  1.16773710e+02,
             9.30031462e+01,  8.08861154e+01,  7.68542717e+01,
             7.68635386e+01,  7.68814136e+01,  7.88586402e+01,
             8.30747352e+01,  8.49474625e+01,  9.49474620e+01,
             9.09474628e+01,  7.89474634e+01,  5.09474632e+01,
             1.49474628e+01,  5.94545415e+00,  1.67766160e-07,
             0.00000000e+00],
           [-1.08846000e+00, -1.17081109e+00, -1.32595089e+00,
            -1.59971656e+00, -2.00087060e+00, -2.43166594e+00,
            -2.99999953e+00, -2.99999935e+00, -2.99999937e+00,
            -3.26596357e+00, -2.19027431e+00, -1.61937311e+00,
            -1.63962941e+00, -1.67967549e+00, -2.05487349e+00,
            -2.29060523e+00, -1.99999953e+00, -3.99999898e+00,
            -3.99999937e+00, -4.00000031e+00, -4.00000033e+00,
            -3.19803556e+00, -3.32757498e+00, -1.00000005e+00,
             0.00000000e+00],
           [ 1.24663331e-02,  2.40182821e-02,  4.55023072e-02,
             8.18284764e-02,  1.27903185e-01,  1.59545303e-01,
            -4.14799962e-08, -1.31699557e-07, -1.29224448e-07,
             7.70765417e-02,  1.09805403e-01,  7.34671183e-02,
             7.91449183e-02,  9.06201514e-02,  1.27500734e-01,
             8.45452442e-02, -1.10380417e-07, -1.77990387e-07,
            -1.35081699e-07,  5.36456687e-08,  5.07712857e-08,
             5.81728157e-02,  3.19090748e-01,  1.73503868e-09,
             0.00000000e+00]])



# Exercice 5


```python
alpha= DP_backward(); # for any z, interpolation of V(t+1,z)
def DP_forward():
    
    global T;
    global P_a;
    global P_v;

    x= np.zeros(T+1); #initialization
    a= np.zeros(T);
    v= np.zeros(T);
    for t in range(0,T):
        z,a0,v0,_= ... # solve
        x[t+1]= ...;# update
        a[t]= ... ;
        v[t]= ... ;

    val= ... #cost
    return x, a, v, val
```


```python
x,a,v,val=DP_forward()
print("X",x,"a",a,"v",v)
print("val",val)
```

    X [0.00000000e+00 1.00000000e+00 2.00000000e+00 3.00000000e+00
     3.91260913e+00 4.48671136e+00 5.00000000e+00 3.00000000e+00
     0.00000000e+00 1.72531780e+00 0.00000000e+00 1.11022302e-15
     0.00000000e+00 0.00000000e+00 1.00000000e+00 3.00000000e+00
     4.00000000e+00 5.00000000e+00 4.00000000e+00 1.00000000e+00
     4.44089210e-16 0.00000000e+00 5.13294201e-01 0.00000000e+00
     0.00000000e+00] a [2.28983499e-16 0.00000000e+00 0.00000000e+00 0.00000000e+00
     0.00000000e+00 0.00000000e+00 2.22044605e-16 3.00000000e+00
     9.72531780e+00 2.27468220e+00 2.00000000e+00 0.00000000e+00
     0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00
     9.99999970e-01 0.00000000e+00 2.22044605e-16 6.00000000e+00
     9.00000000e+00 3.51329420e+00 1.48670580e+00 0.00000000e+00] v [1.11022302e-16 1.77635684e-15 0.00000000e+00 8.73908685e-02
     4.25897770e-01 1.48671136e+00 6.66133815e-16 0.00000000e+00
     0.00000000e+00 0.00000000e+00 1.44328993e-15 0.00000000e+00
     0.00000000e+00 1.11022302e-16 0.00000000e+00 0.00000000e+00
     0.00000000e+00 0.00000000e+00 0.00000000e+00 1.55431223e-15
     0.00000000e+00 0.00000000e+00 0.00000000e+00 0.00000000e+00]
    val [123.99999994]



```python

```


```python

```
