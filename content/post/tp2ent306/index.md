---
# Documentation: https://docs.hugoblox.com/managing-content/

title: "Tp2"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2024-12-13T10:19:20+01:00
lastmod: 2024-12-13T10:19:20+01:00
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


We call demand scenario a vector $(D(s))_{s=1,...,T}$.

Two set of scenarios are available:

- Training set $D_T$ : history of $NT$ demand scenarios.
  Used to build a probabilistic model for the demand and an appropriate control strategy.
- Simulation set $D_S$ : history of $NS$ demand scenarios.
  Used to test the control strategies. Avoid to build biased strategies.

Shifting of the time index:

The two available histories of demand scenarios contain $T_0$ values of the demand from the “previous day”, corresponding to the time intervals $-T0, −(T0 − 1),...,-2,-1$.
A demand scenario is a vector of size $T + T0$. The training and simulation sets are matrices with $(T + T0)$ columns and respectively $NT$ and $NS$ rows.
We “get access” to the demand at time $t$, for the scenario $l$ with $DT(l,t +T0)$ or $DS(l,t +T0)$.


#### Optimization problem in a form that is compatible with the function linprog

% Exercise 1: Indication: you should find optimal value= 124 with $d$ a-priori known

we changed the function to take $d$ as an input parameter




```python
T= 24; # Time
T0=10 #Training times
x_max= 10; # battery maximum storage 
P_a= np.array([2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 2, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 3, 3, 2]); # unitary buying price of energy at time s
P_v= np.array([1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 1, 1]); # unitary selling price of energy at time s

#d =np.array([-1, -1, -1, -1, -1, -2, 2 ,6, 8, 4, 2,  0,  0, -1, -2, -1,  0,  1, 3, 7, 9, 3, 2,  0]); # net demand of energy (already known)
#d=d.reshape((T,1))
P_a=P_a.reshape(T,1)
P_v=P_v.reshape(T,1)

NT=200
NS=200
import scipy.io
mat = scipy.io.loadmat('scenarios.mat')
DS = mat['D_S'] 
DT = mat['D_T'] 
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
#same as exercice 1
def solve_deterministic_pb(d):
    ...
    
    c=np.concatenate((np.zeros((T+1,1)),P_a,-P_v),axis=0) #cost function: sum_s P_a a(s) - P_v(v)
    #print(c)  #columns of A must be equal to size of c
    X=optimize.linprog(c,A_ub=A,b_ub=B,A_eq=Aeq,b_eq=Beq)
    x=X.x[:T+1]
    a=X.x[T+1:2*T+1]
    v=X.x[2*T+1:]
    #print("x:", X.x[:T+1])
    #print(np.shape(X.x[:T+1]))
    #print("a:", X.x[T+1:2*T+1])
    #print(np.shape(X.x[T+1:2*T+1]))
    #print("v:", X.x[2*T+1:])
    #print(np.shape(X.x[2*T+1:]))
    #print("Optimal cost", X.fun)
    return x,a,v,X.fun
    
```

# Exercice 6
### compute $J_{anti}$, the optimal cost
Given a scenario $D$, compute $J_{anti}=\frac1{NS} \sum_{l=1}^{NS} J_{anti}(DS(l,.))$ ,
where $J_{anti}(DS(l,.))= \sum_{s=0}^{T-1} \Big( P_a(s) a(s) - P_v(s) v(s) \Big).$

expected result: J_eval= 10.2490


```python
def lower_bound():
    global T0,DS,NS

    J= 0;
    for l in range(0,NS):#=0:N_S-1
        _, _, _, val = ... #only simulation D_S (pay attention to time shifting!)
        J= ...
        #print("val",val)
    J= ...
    return J
```


```python
#% Exercise 6: 
J=lower_bound()
print(J)
```

    10.249021164754385


# Exercice 7
### The naive strategy (we don't exploit the training set: $\mathcal{I}=0$)
online step: at time $s$, given $d(s)$, we choose
$$(a(s),v(s))= 
\begin{align*}
& (d(s),0) \textrm{ if } d(s) \geq 0,\\
& (0,-d(s)) \textrm{ otherwise.} 
\end{align*}$$

Input: Demand scenario


```python
def naive_online(D):
    global T;
    global P_a;
    global P_v;

    J=0;
    for s in range(T):
        if ...
            a=...
            v=...
        else:
            a=...
            v=...

        J= ...
    return J
```


```python
#% Exercise 7: 
def naive_eval():

    global DS,NS,T0;

    J=0
    for l in range(NS):
        J=...
    J= ...
    return J

J=naive_eval()

print(J)
# the solution is 52.8324
```

    NS 200
    (200, 34)
    10
    [52.8323865]


# Exercice 8
The reasonable strategy
- if $d(s) \geq 0 :$ we dip into the reserve x(s) and we buy electricity if $d(s) \geq x(s)$ (assert that $x=0$ in that case).
- if $d(s) \leq 0 :$ we stock energy in the battery as much as possible. If $d(s)\leq x(s) -x_{max}$, the surplus is sold.

Expected result:
 28.0550


```python
def raisonnable_online(D):
    global T, P_a,P_v, x_max
    x=0
    J=0
    for s in ...:
        if D[s]>0:
            if D[s]<x: # if demand less than our stock
                x=... # no cost added
            else:
                J=... #we buy electricity for the demand
                x= ...
        else: #since D=net demand of energy load minus solar production: if D<0, we produce electricity via the solar prod
           
            if D[s]>x-x_max:
                x=... # we add -D[s] to stock, no cost
            else:
                J=...#surplus that we sold
                x=...
    return J
    
def raisonnable_eval():
    global DS,NS, T0
    J=0
    for l in range(NS):
        J=...
        #print(J)
    J=...
    return J
```


```python
raisonnable_eval()
```




    array([28.05501615])



# Exercice 9

Write a fonction sample realising the sampling of an arbitrary vector $h \in NE$ values. Use the function sort.

Write a function sample_training_set with output a matrix $E \in \mathbb{R}^{NE \times T}$ such that each column contains the sampled values of the vectors $DT[:,T0], DT[:,T0 +1],... DT[:,T0 +T-1]$.

Expected result: 

First column : $[-4.77725278, -4.01198924, -3.38314885, -2.93038295, -2.57365075, -2.14186728, -1.76473744, -1.29947285 ,-0.66349418,  0.27839677]$


```python
def sample(h,NE):
    global NT
    q= ...
    
    h2=...
    #print(h2)
    z= np.zeros(NE)
    for j in range(NE):
        z[j]= sum(...)/q #! from j*q to (j+1)*q-1 
    return z


def sample_training_set(NE):
    global T, T0,DT;

    E= np.zeros((NE,T));
    for t in range(T):
        E[:,t]= ...    
    return E
```


```python
E=sample_training_set(10)
print(E[:,0])
```

    [-4.77725278 -4.01198924 -3.38314885 -2.93038295 -2.57365075 -2.14186728
     -1.76473744 -1.29947285 -0.66349418  0.27839677]


# Exercice 10

Write a function auto_reg_1 realizing the approximation of $d(t)$ as an autoregressive process of order 1

Input: $NE$

Output variables: $\gamma \in \mathbb{R}^T, \beta_1 \in \mathbb{R}^T, E \in \mathbb{R}^{NE\times T}.$

Optional. Write a function auto_reg which realizes the approximation of d(t) by an autoregressive process of arbitrary order (given as input variable).

Expected results:

$\gamma[0]= -0.3649, \beta_1[0]= 0.7682, $
$E[:,0]=[
    -1.0069,
    -0.8394,
    -0.7178,
    -0.5657,
    -0.0792,
     0.4544,
     0.5283,
     0.6303,
     0.7166,
     0.8794]$



```python
def auto_reg_1(NE):

    global T,T0,DT
    beta1= np.zeros(T)
    gamma= np.zeros(T)
    E= np.zeros((NE,T))
    for t in range(T):
        fun= lambda x: ...
        sol= minimize(fun,[0,0]);
        x=sol.x
        #print(x)
        beta1[t]= ...
        gamma[t]= ...
        E[:,t]= sample(...)

    return gamma, beta1, E
    
```


```python
gamma,beta1,E=auto_reg_1(10)
print(gamma)
print(beta1)
#print(E)
```

    [-3.64920596e-01  3.39541820e-01 -2.32134334e-03 -2.16750096e-01
     -8.59434452e-02 -1.12819996e+00  4.16569707e+00  3.37867512e+00
      1.27918380e+00 -4.71137843e+00 -1.23576099e+00 -1.39483077e+00
      6.40439724e-01 -8.69026959e-01 -7.29476724e-01  1.11208561e+00
      6.42515437e-01  6.23130647e-01  1.67544278e+00  3.71966527e+00
      1.42443036e+00 -6.44641462e+00  2.90174094e-01 -1.54561913e+00]
    [0.76823356 0.71200769 0.81019918 0.97478824 1.0888146  0.93996108
     0.85514147 0.70638915 0.76137643 0.9463442  1.0131899  0.99646022
     0.83403957 0.70257359 0.77274986 0.91298702 1.01864786 0.99926106
     0.86872348 0.72124587 0.6993772  0.83272378 0.99200363 1.00905716]



```python
def auto_reg_l(NE,l): #order l

    global T,T0,DT
    beta= np.zeros((l,T))
    gamma= np.zeros(T)
    E= np.zeros((NE,T))
    for t in range(T):
        fun= lambda x: ...
        sol= minimize(fun,[0]*(l+1));
        x=sol.x
        #print(x)
        gamma[t]= ...
        for lelement in range(0,l):
            beta[lelement,t]= ...
        E[:,t]=...

    return gamma, beta, E

```


```python
gamma,beta1,E=auto_reg_l(10,2)
print(gamma)
print(beta1)
```

    [-0.49447424  0.37501009  0.18948557 -0.11351881 -0.05104727 -1.09606017
      4.02081014  4.0484273   1.77241686 -4.76320081 -1.99718931 -1.73921763
      0.45573183 -0.76584273 -0.79697917  1.1130644   0.88768632  0.76513303
      1.76105607  3.77394906  1.77363576 -6.53771775 -1.53916139 -1.22538599]
    [[0.66697329 0.53738259 0.6436579  0.77253464 0.83114445 0.81528601
      0.68730267 0.56168645 0.58927249 0.83395878 0.8950604  0.71590124
      0.66891166 0.614444   0.61605273 0.81281008 0.88831695 0.84428652
      0.74462709 0.68757048 0.59189968 0.65814097 0.77891484 0.72289816]
     [0.11560664 0.17299553 0.17671066 0.24259814 0.3360263  0.16978016
      0.18828213 0.15055124 0.16505034 0.1262086  0.15323632 0.35379428
      0.20047631 0.09107688 0.15360972 0.11485738 0.16338539 0.2025645
      0.14954614 0.03640317 0.10365213 0.18856198 0.26854245 0.38785429]]


# Exercice 11

## Predictive model.

#### Phase offline. 

Approximation of $d(t)$ with an autoregressive process of order 1, with the help of coefficients $\gamma$ and $\beta_1$.

#### Phase online. 

Let $t$ be the current time step. Let $x_t$ denote the current state-of-charge of the battery and let $d_t$ denote the demand at time $t$.

1/ Prediction. 

Compute $(D_p(s))_{s=t,...,T}$ as follows:
$$
\begin{align*}
&D_p(t)= d_t,\\
&D_p(t + 1) = \gamma(t + 1) + \beta_1(t + 1)D_p(t), D_p(t+2)= \gamma(t+2)+\beta_1(t+2)D_p(t+1),\\
&... \\
&D_p(T)=\gamma(T)+\beta_1(T)D_p(T −1).
\end{align*}$$

2/ Optimization.

We solve:
    $$
   inf_{((x(t),...,x(T+1)),(a(t),...,a(T)),(v(t),...,v(T))} \sum_{s=t}^{T} \Big( P_a(s) a(s) - P_v(s) v(s) \Big).
 $$
s.t

- $x(s+1)= x(s) - D_p(s) + a(s) - v(s)$, $\forall s= t,...,T$
- $x(t)= x_t$
- $a(s) \geq 0$, $\forall s=t,...,T$
- $v(s) \geq 0$, $\forall s=t,...,T$
- $0 \leq x(s) \leq x_{\max}$, $\forall s=t,...T$.

Implement the predictive method

Expected results: 

- $N_E= 10$
- Evaluation cost: $5.0205275654553985$.


```python
def predictive_online(D,gamma,beta,t,y):
    # t= init time, y= init energy stock
    global T,P_a,P_v,xmax

    D_p= np.zeros([T-t])#for t0=0, we want to approximate all the D(s) from s=0 to s=T-1
    ## First we approximate by an autoregressive processus
    D_p[0]= ...
    for s in range(1,T-t):
        # s=1 corresponds to t+1 and s=T-t-1 correponds to T-1
        # thus, D_p[s+1]=gamma[s+1] + beta[s+1]*D_p[s] for an autoregressive of order 1
        # gives D_p[1]=gamma[t+1] + beta[t+1]*D_p[0];
        # and more generally for any s, yields D_p[s]=...?
        D_p[s]=...

    ## Then solve the optimization problem
    # xi<=xmax for i = 0.. T: concatenate A1=Identity matrix & A2 & A2
    A1=np.matrix(np.eye(...))# should give T+1 for t=0
    A2=np.zeros((...)) #should give (T+1,T) for t=0
    A=np.concatenate((A1,A2,A2), axis=1)

    # -x, -a, -v <= 0,0,0
    A3=-np.eye(...)
    A=np.concatenate((A,A3), axis=0)

    #print(np.shape(A))
    # xi<=xmax for i = 0.. T
    
    B1=np.array([...])
    # -x, -a, -v <= 0,0,0
    B3=np.zeros((...))
    
    B=np.concatenate((B1.transpose(),B3), axis=0);
    #print(B)

    """ 
    ####### Equality constraints: #######
    """
    # Aeq1:
    M1=np.eye(...) #-x(s) and x(s+1) s=0, T-1
    M2=np.zeros((...)) #

    M=np.concatenate((-M1,M2), axis=1)+np.concatenate((M2,M1),axis=1)

    Aeq1=np.concatenate((M,-M1,M1), axis=1) # M & -a(s) & v(s) s=0, T-1
    Aeq2=np.concatenate((...)) # #x(0)=0, (with concatenate, don't use axis=1 for only one line, use double parentheses)
    
    Aeq=np.concatenate((Aeq1,Aeq2.transpose()),axis=0)
    Beq=np.concatenate((...))#.reshape((1,1)))) 
    #print(Beq)
    
    """ 
    solving min c^T * X s.t. A X <= B and Aeq X= Beq
    no x in min: 0; 
    a P_a -v P_v
    """ 
    # min c^T [x,a,v]
    c=np.concatenate((...),axis=0) #cost function: sum_s P_a a(s) - P_v v(s)
    #print(c)  #columns of A must be equal to size of c
    X=optimize.linprog(c,A_ub=A,b_ub=B,A_eq=Aeq,b_eq=Beq)
   
    x=X.x[:T-t+1]
    a=X.x[T+1-t:2*(T-t)+1]
    v=X.x[2*(T-t)+1:]
    J= X.fun 
    #print("J",J)
    return x,a,v,J#X.fun



```


```python
def predictive_eval(gamma,beta1):

    global DS,NS,T0;

    GlobalJ= 0;
    for l in range(NS):
        _,_,_,J= ...
        GlobalJ= ...

    GlobalJ= ...
    return GlobalJ
```


```python
J=predictive_eval(gamma,beta1)
print(J)
```

    5.0205275654553985


In fact, the previous implementation respects the constraints $x(s+1)=x(s)+a(s)−v(s)−D_p(s)$ with the autoregressive demand $D_p$ but not with the true demand $D(s)$, such that we can't compare this cost (5.0205275654553985) with the optimal cost from exercice 1.

Since at every time $t$ the demand $D(t)$ is revealed, we can use it to enhance our model (such that the constraint with the true demand holds):

In that case, we only save the solution $x(s+1)$, $a(s)$, $v(s)$ for one time $s$ and then update the cost with these saved solutions (and proceed with $s+1$ and so on...) for $s$ going from an initial time $t$ with an initial energy stock y.

#### Correct the previous version in order that the constraint with the true demand holds
To simplify the implementation, you can take $t=0$ and $y=0$.

#Expected result: 13.22638501 


```python
def predictive_online(D,gamma,beta): #with t0=0 and y=0

    global T,P_a,P_v,xmax

    x_saved= np.zeros((T+1));
    a_saved= np.zeros((T));
    v_saved= np.zeros((T));

    ## Then solve the optimization problem
    # xi<=xmax for i = 0.. T: concatenate A1=Identity matrix & A2 & A2
       
    for t in range(0,T): # from init t0=0 to T-1

        D_p= np.zeros(T-t) 
        D_p[0]= ...
        for s in range(1,T-t):#(T-t+1) # 0, 1, ..., T-2 for t=1
            D_p[s]= ...
        
        #print("t",t)
        A1=np.matrix(...)# should give T+1 for t=0
        A2=np.zeros((...)) #should give (T+1,T) for t=0
        A=np.concatenate((A1,A2,A2), axis=1)

        # -x, -a, -v <= 0,0,0
        A3=-np.eye(...)
        A=np.concatenate((A,A3), axis=0)

        #print(np.shape(A))
        # xi<=xmax for i = 0.. T
    
        B1=np.array(...)
        # -x, -a, -v <= 0,0,0
        B3=np.zeros((...))
    
        B=np.concatenate((B1.transpose(),B3), axis=0);
        #print(B)

        """ 
        ####### Equality constraints: #######
        """
        # Aeq1:
        M1=np.eye(...) #-x(s) and x(s+1) s=0, T-1
        M2=np.zeros((...)) #

        M=np.concatenate((-M1,M2), axis=1)+np.concatenate((M2,M1),axis=1)

        Aeq1=np.concatenate((M,-M1,M1), axis=1) # M & -a(s) & v(s) s=0, T-1
        Aeq2=np.concatenate((...)) # #x(0)=0, (with concatenate, don't use axis=1 for only one line, use double parentheses)
    
        Aeq=np.concatenate((Aeq1,Aeq2.transpose()),axis=0)
       
        Beq=np.concatenate((...))
        #print(Beq)
    
        """ 
        solving min c^T * X s.t. A X <= B and Aeq X= Beq
        no x in min: 0; 
        a P_a -v P_v
        """ 
        # min c^T [x,a,v]
        c=np.concatenate((...),axis=0) #cost function: sum_s P_a a(s) - P_v v(s)
        #print(c)  #columns of A must be equal to size of c
        X=optimize.linprog(c,A_ub=A,b_ub=B,A_eq=Aeq,b_eq=Beq)

        x_saved[t+1]= X.x[1];
        a_saved[t]= X.x[T+1-t];
        v_saved[t]= X.x[2*(T-t)+1];

    
    J= np.dot(P_a.transpose(),a_saved)-np.dot(P_v.transpose(),v_saved)
    #print("J",J)
    return x_saved,a_saved,v_saved,J



```


```python
def predictive_eval(gamma,beta1):

    global DS,NS,T0;

    GlobalJ= 0;
    
    for l in range(NS):
        _,_,_,J= ...
        GlobalJ= ...

    GlobalJ= ...
    return GlobalJ
```


```python
predictive_eval(gamma,beta1)
```




    array([13.22638501])





# Exercise 12;

Implement the control strategy induced by the dynamic programming principle with the auto-regressive model of order zero.

% Answer: 10.27



```python
def DP_solve_0(t,y,alpha,d_t):

    global x_max;
    global P_a;
    global P_v;

    return z,a,v,val
```


```python
def DP_backward_0(N_E):

    D = sample_training_set(N_E);

    global T;
    global J;
    global x_max;

    alpha= zeros(3,T+1);
    ...
    return alpha

```


```python
def DP_forward_0_online(alpha,d):

    global T;
    global P_a;
    global P_v;

    x= np.zeros((T+1,1))
    a= np.zeros((T,1))
    v= np.zeros((T,1))
    ...
    return x, a, v, val




def DP_forward_0_eval(N_E):

    global N_S;
    global D_S;
    global T_0;
    global T;

    alpha= DP_backward_0(N_E)
    ...
    cost= 0
    return cost

```


```python
J= 10;
N_E= 10;

alpha= ...

cost = ...

```


```python

```


```python

```


```python

```
