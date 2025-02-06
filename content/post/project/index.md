---
# Documentation: https://docs.hugoblox.com/managing-content/

title: "My Post"
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
<center><h1> Project </h1><h2>Logistic regression</h2></center>


```python
#Install package
import sys
!{sys.executable} -m pip install numpy
!{sys.executable} -m pip install matplotlib
!{sys.executable} -m pip install scikit-learn
```


```python
import numpy as np
import matplotlib.pyplot as plt
from time import time
import random
import sklearn
```

#### 1) Device Type:
Choose a device type (Lights, Camera, Smart Speaker, Thermostat,...) and plot the data


```python
#import kagglehub #if from kagglehub
#path = kagglehub.dataset_download("rabieelkharoua/predict-smart-home-device-efficiency-dataset")

from csv import *
filename = f"smart_home_device_usage_data.csv"

#open file
with open(filename, mode='r') as file:
    reader = reader(file)
    data = list(reader)  # Convert in list to make all lines accessible 
n=len(data)-1 #number of lines

DeviceType='...'
count = sum(1 for row in data if len(row) > 1 and row[1] == DeviceType)
print(f"Nombre d'occurrences de l'objet choisi dans la colonne 2 : {count}")

xi_list=np.zeros((count,3)) # three parameters 
yi_list=np.zeros(count) #labels

i=0
for row in data[1:]:
    
    if row[1]==DeviceType:
        yi_list[i]=row[7] # label: 0 - Inefficient, 1 - Efficient
        xi_list[i,0]=row[2] #usagehoursperday
        xi_list[i,1]=row[3] #energyconsumption
        xi_list[i,2]=row[6] #DeviceAgeMonths
        i+=1

assert(i==count)
n=i #data number=count

# normalize data (features between [0,1]):
min_values = np.array([0, 0, 0])  # Features minimum
max_values = np.array([25,10, 60])  # Features maximum
x_normalized = (xi_list - min_values) / (max_values - min_values)
xi_list=x_normalized
#print(np.shape(x_normalized))
```

    Nombre d'occurrences de l'objet choisi dans la colonne 2 : 1039


We are given a family of $n$ points $x_i=(x^0_i,x^1_i,x^2_i)$ in $\mathbb{R}^3$, along with associated $\textit{labels}$ $(y_i)_{1 \leq i \leq n}$ in $\{0,1\}$.

In previous work, we aimed to establish a relationship between $x$ and $y$ in the form: 
- if $\sigma(\langle w, x\rangle) \geq 0.5$, then $y=1$,
- else $y=0$,
  
where $w = (w^0, w^1)\in \mathbb{R}^2$ was the unknown of the problem and $\sigma$ was the sigmoid function $z \mapsto \tfrac{1}{1+e^{-z}}$.
Then, for a new unlabeled data $x$, we were computing $\sigma(\langle w,x\rangle) \in [0,1]$, allowing us to classify it as either $y=0$ or $y=1$ while incorporating a measure of uncertainty in the prediction.

To simplify the model, we assumed that the data were centered at $0$ and set the bias term $b=0$: we only had to minimize the log-loss function with respect to the weights. 

In general, a bias term $b$ is required, meaning that we introduce an additional parameter $b \in \mathbb{R}$ and seek a relationship of the form:
- if $\sigma(\langle w, x\rangle + b) \geq 0.5$, then $y=1$,
- else $y=0$,
  
since there is no reason to assume that the separating hyperplane should pass through the origin.

However, we can eliminate the bias term by increasing the dimensionality from $d$ to $d + 1$.
In our case, this means increasing the dimensions of both $x$ and $w$ from $3$ to $4$: we redefine 
$$x=(x^0,x^1,x^2,1) \textrm{ and } w=(w^0,w^1,w^2,b).$$
This transformation allows us to maintain the same matrix notation as before in the optimization step.

The log-loss function with a penalization term in $L^2$ is thus given by:
\begin{equation*}
f(w)=-\frac1n \sum_{i=1}^n (y_i log (\sigma(\langle w,x_i \rangle))+ (1-y_i)log (1-\sigma(\langle w,x_i \rangle)) + \lambda \frac12 \lVert w\rVert^2,
\end{equation*}
where $\lambda$ is a regularization parameter.



#### Data plot 


```python
# data plot
from mpl_toolkits.mplot3d import Axes3D
xi_list_bias=np.zeros((n,4)) #increasing dimension from 3 to 4

for i in range(n): #redefining data x in x=(x0,x1,x2,1)
    xi_list_bias[i, 0:3]= ...
    xi_list_bias[i, 3]= ...

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

for i in range(n//2): 
    if yi_list[i] == 1: # if x_i is of class 1 the point is red : 1 - Efficient
        ax.scatter(xi_list[i, 0],  xi_list[i, 1],  xi_list[i, 2],  color="red", marker=".") 
       
    else: # else green #0 - Inefficient
        ax.scatter(xi_list[i, 0], xi_list[i, 1],  xi_list[i, 2],  color="green", marker=".")   

elevation_angle = 60
azimuthal_angle = 15
ax.view_init(elevation_angle, azimuthal_angle)


ax.set_xlabel("X axis, usage hours/day")
ax.set_ylabel("Y axis, device age")
ax.set_zlabel("Z axis,  energy consumption")


plt.title(u"Data representation.\n" + r"$x_i$ is a green point if $y_i = 0$, red point if $y_i = 1$."+u"\n"+ r"0 - Inefficient, 1 - Efficient")
#plt.axis("tight")
plt.show()
```

#### 2. Log-loss function
Define a log-loss function with penalty term L2 or with a barrier function.



```python
...
```

#### 3.  Gradient-descent algorithm:
Write a gradient-descent algorithm with the Armijo or the Wolfe-Armijo rule.


```python
# gradient

...

```


```python
w=np.random.rand(4) 
epsilon = 1e-8
print("This quantity must be of order 1e-8 : ", np.linalg.norm(gradf(w) - np.array([(f(w + epsilon*np.eye(4)[0]) - f(w))/(epsilon), (f(w + epsilon*np.eye(4)[1]) - f(w))/(epsilon),(f(w + epsilon*np.eye(4)[2]) - f(w))/(epsilon),(f(w + epsilon*np.eye(4)[3]) - f(w))/(epsilon)])))
```

    This quantity must be of order 1e-8 :  3.603214732619758e-08



```python
# Gradient descent

... 
    
```

#### Best weights/bias


```python
%%time
x0 = np.array([1.,1.,1.,1.])
...
xlist_approx = ...
print(len(xlist_approx))
print(xlist_approx[-1])
```

#### Visualization: separation line


```python
## P(y=1|x)
def opt_f(wstar,z):
    return ...

```


```python
## Display separation hyperplan from wstar, bstar (optimal weights/bias)
dom_points =[0,1,0,1,0,1]
grid_size = 50

# 3D Grid
x = np.linspace(dom_points[0], dom_points[1], grid_size)
y = np.linspace(dom_points[2], dom_points[3], grid_size)
z = np.linspace(dom_points[4], dom_points[5], grid_size)
X, Y, Z = np.meshgrid(x, y, z)

## plot the separation hyperplan 
X2, Y2 = np.meshgrid(x, y)
if xlist_approx[-1][2] != 0:
    Z2 = (-xlist_approx[-1][0] * X2 - xlist_approx[-1][1] * Y2 - xlist_approx[-1][3]) / xlist_approx[-1][2]
    mask = (Z2 >= 0) & (Z2 <= 1)
    Z2[~mask] = np.nan  

# Compute P(y=1|x)
P = np.zeros((grid_size, grid_size, grid_size))
for i in range(grid_size):
    for j in range(grid_size):
        for k in range(grid_size):
            P[i, j, k] = ...
            
fig = plt.figure(figsize=(10, 10))
ax = fig.add_subplot(111, projection='3d')

ax.plot_surface(X2, Y2, Z2, color='cyan') #separation hyperplan

scatter = ax.scatter(X.flatten(), Y.flatten(), Z.flatten(), c=P.flatten(), cmap='viridis', s=0.2,alpha=0.3) #change opacity with alpha
cbar = plt.colorbar(scatter, ax=ax, shrink=0.5)
cbar.set_label("Valeur de W")

for i in range(n):
    if yi_list[i] == 1:
        ax.scatter(xi_list[i, 0], xi_list[i, 1], xi_list[i, 2], color="red", label="y=1" if i == 0 else "")
    else:
        ax.scatter(xi_list[i, 0], xi_list[i, 1], xi_list[i, 2], color="green", label="y=0" if i == 0 else "")

elevation_angle = 70 #90
azimuthal_angle = 0#35
ax.view_init(elevation_angle, azimuthal_angle)

ax.set_xlabel("X axis, usage hours/day")
ax.set_ylabel("Y axis, device Age Months")
ax.set_zlabel("Z axis,  energy consumption")

ax.set_title(r"Data separation, green points y=0, red points y=1")
ax.set_aspect("equal", adjustable = "box") # pour que les axes aient la même échelle
plt.show()
```

#### 4. Multi-layer perceptron
Compare the results you obtained with a multi-layer perceptron (no hidden layer, one hidden layer and five hidden layers resp.).


```python
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import log_loss
```


```python
############
## No hidden layer
mlp_no_hidden = ... #for comparison, use activation="logistic"
...
log_loss_no_hidden = ...
print(f"Log-loss (no hidden layer) : {log_loss_no_hidden:.4f}")

weights_no_hidden = ...
bias_no_hidden = ...
print(weights_no_hidden.transpose()," ", bias_no_hidden)

## Compare to our model:
print(f"Log-loss (our model) : {...:.3f}")
print(xlist_approx[-1])

############
## One hidden layer, 3 neurons, activation=logistic 

mlp_one_hidden = ...
...
log_loss_one_hidden = ...
print(f"Log-loss (one layer) : {log_loss_one_hidden:.4f}")
weights_one_hidden = ...
bias_one_hidden = ...

############
## Five hidden layers, 9 neurons, activation=relu

mlp_five_hidden = ...
...
log_loss_five_hidden = ...
print(f"Log-loss (5 hidden layers) : {log_loss_five_hidden:.4f}")
```

#### 6. Visualization

With one layer and three neurons, compute P (y = 1|x) in a function opt_f and visualize the results. You should recover the results from mlp_one_hidden.predict_proba.





```python
## P(y=1|x)
def opt_f(wstar,bstar,z):
    W1 = wstar[:9].reshape(3, 3).transpose()  # Hidden layer weights (3 neurons, 3 inputs)
    W2 = wstar[9:].reshape(1, 3)  # Outputs weights (1 neuron, 3 hidden inputs)
    B1 = np.array([bstar[0],bstar[1],bstar[2]]).reshape(3,1)
    B2 = bstar[3]
    z = np.array(z).reshape(3, 1)  

    H = ... #hidden layer
    P = ... 
    
    return P #carreful: must return a float 
    

```


```python
## Visualization with opt_f

dom_points =[0,1,0,1,0,1]
#dom_points = [0,np.max(xi_list[:, 0]), 0,np.max(xi_list[:, 1]),0,np.max(xi_list[:, 2])]#[-11, 11, -11, 11,]
grid_size = 50

# Génération de la grille 3D
x = np.linspace(dom_points[0], dom_points[1], grid_size)
y = np.linspace(dom_points[2], dom_points[3], grid_size)
z = np.linspace(dom_points[4], dom_points[5], grid_size)
X, Y, Z = np.meshgrid(x, y, z)


P = np.zeros((grid_size, grid_size,grid_size))
w_opt=np.concatenate((weights_one_hidden[0].flatten(),weights_one_hidden[1].flatten()))
print(w_opt)
b_opt=np.concatenate((bias_one_hidden[0].flatten(),bias_one_hidden[1].flatten()))
print(b_opt)
for i in range(grid_size):
    for j in range(grid_size):
        for k in range(grid_size):
            P[i, j, k] =opt_f(...)
            
fig = plt.figure(figsize=(10, 10))
ax = fig.add_subplot(111, projection='3d')

scatter = ax.scatter(X.flatten(), Y.flatten(), Z.flatten(), c=P.flatten(), cmap='viridis', s=0.2,alpha=1)

# Barre de couleurs
cbar = plt.colorbar(scatter, ax=ax, shrink=0.5)
cbar.set_label("Valeur de W")
for i in range(n):
    if yi_list[i] == 1:
        ax.scatter(xi_list[i, 0], xi_list[i, 1], xi_list[i, 2], color="red", label="y=1" if i == 0 else "")
    else:
        ax.scatter(xi_list[i, 0], xi_list[i, 1], xi_list[i, 2], color="green", label="y=0" if i == 0 else "")

# Légendes et étiquettes

ax.set_xlabel("X axis, usage hours/day")
ax.set_ylabel("Y axis, device Age Months")
ax.set_zlabel("Z axis,  energy consumption")


ax.set_title(r"Data separation, green points y=0, red points y=1")
ax.set_aspect("equal", adjustable = "box") # pour que les axes aient la même échelle
plt.show()


## Data

```


```python
## Visualization with mlp_one_hidden

dom_points =[0,1,0,1,0,1]
grid_size = 50

x = np.linspace(dom_points[0], dom_points[1], grid_size)
y = np.linspace(dom_points[2], dom_points[3], grid_size)
z = np.linspace(dom_points[4], dom_points[5], grid_size)
X, Y, Z = np.meshgrid(x, y, z)

P = np.zeros((grid_size, grid_size,grid_size))

for i in range(grid_size):
    for j in range(grid_size):
        for k in range(grid_size):
            P[i, j, k] = ... # with mlp_one_hidden
            
fig = plt.figure(figsize=(10, 10))
ax = fig.add_subplot(111, projection='3d')

scatter = ax.scatter(X.flatten(), Y.flatten(), Z.flatten(), c=P.flatten(), cmap='viridis', s=0.2,alpha=1)
cbar = plt.colorbar(scatter, ax=ax, shrink=0.5)
cbar.set_label("P(y=1|x)")
for i in range(n):
    if yi_list[i] == 1:
        ax.scatter(xi_list[i, 0], xi_list[i, 1], xi_list[i, 2], color="red", label="y=1" if i == 0 else "")
    else:
        ax.scatter(xi_list[i, 0], xi_list[i, 1], xi_list[i, 2], color="green", label="y=0" if i == 0 else "")

ax.set_xlabel("X axis, usage hours/day")
ax.set_ylabel("Y axis, device Age Months")
ax.set_zlabel("Z axis,  energy consumption")


ax.set_title(r"Data separation, green points y=0, red points y=1")
ax.set_aspect("equal", adjustable = "box") 
plt.show()
```

#### Conclusion: In PDF or with comments

How do the parameters seem to influence classification? 

Bonus: What would you recommend to avoid overfitting? How to be more confidence in our model?


```python

```
