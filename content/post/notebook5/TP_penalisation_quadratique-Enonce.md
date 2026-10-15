# Gradient descent and quadratic penalization

**Continuous optimization — ENT 305**


We study the projection of $(0,1)$ onto the line $x=y$:

$$\min_{(x,y)\in\mathbb R^2} f(x,y)=\frac12\bigl[x^2+(y-1)^2\bigr],\qquad h(x,y)=y-x=0.$$



```python
import numpy as np
import matplotlib.pyplot as plt

```

## 1. Build the quadratic penalty

For $c>0$, define

$$Q_c(x,y)=f(x,y)+\frac c2\,h(x,y)^2.$$


**Exercise 1.** Compute $\nabla f$, $\nabla h$, $\nabla Q_c$ and $\nabla^2 Q_c$ by hand. Complete the functions below.


```python
def f(x, y):
    return ...

def grad_f(x, y):
    return ...

def h(x, y):
    return ...

def grad_h(x, y):
    return ...

def Q(xy, c):
    ...
    return ...

def grad_Q(xy, c):
    x, y = ...
    return ...

def hessian_Q(c):
    return ...

```

## 2. Gradient descent with an Armijo line search

At each iteration, use the descent direction $d_k=-\nabla Q_c(x_k)$ and choose a step $\alpha_k>0$ satisfying

$$Q_c(x_k+\alpha_k d_k)\le Q_c(x_k)+\sigma\alpha_k\nabla Q_c(x_k)^\top d_k,\qquad 0<\sigma<1.$$

**Exercise 2.** Complete the code and compare the trajectories for $c=1$ and $c=20$.


```python
def armijo_step(x, direction, c, alpha0=1.0, shrink=0.5, sigma=1e-4):
    ...

def gradient_descent(x0, c, tol=1e-8, max_iter=30000):
    ...
    return np.asarray(trajectory)

for c in [1.0, 20.0]:
    trajectory = gradient_descent([1.5, -0.5], c)
    print(f'c={c:g}: iterations={len(trajectory)-1}, '
          f'point={trajectory[-1]}, |h|={abs(h(*trajectory[-1])):.3g}')
```

    c=1: iterations=29, converged=True, point=[0.33333333 0.66666667], |h|=0.333
    c=20: iterations=20, converged=True, point=[0.48780488 0.51219512], |h|=0.0244


## 3. Analytical solution of the penalized problem

**Exercise 3.** Show that the descent gradient algorithm converges to 


$$\boxed{(x_c,y_c)=\left(\frac{c}{1+2c},\frac{1+c}{1+2c}\right).}$$



```python
def exact_penalty_solution(c):
    return ...

for c in [0.5, 1, 5, 20, 100]:
    path = ...
    x_exact = ...
    print(f'c={c:5g} | GD={path[-1]} | exact={x_exact} | error={np.linalg.norm(path[-1]-x_exact):.2e}')
```

## 4. Effect of the penalty parameter

The solution of the original constrained problem is $\bar z=(1/2,1/2)$. Show that

$$|h(x_c,y_c)|=\frac1{1+2c},\qquad \| (x_c,y_c)-\bar z\|=\frac1{\sqrt2(1+2c)}.$$

**Exercise 4.** Plot these two errors as functions of $c$. What happens as $c\to\infty$? Does any finite $c$ enforce the constraint exactly?



```python
c_values = np.logspace(-1, 3, 100)
...
fig, ax = plt.subplots(figsize=(8, 4.5))
ax.loglog(c_values, feasibility, label=r'$|y_c-x_c|$')
ax.loglog(c_values, distance, label=r'$\|(x_c,y_c)-(1/2,1/2)\|$')
ax.set(xlabel='Penalty parameter c', ylabel='Error', title='Accuracy versus penalty parameter')
ax.grid(True, which='both', alpha=0.3)
ax.legend(); plt.show()
```

## 5. Visualize the iterates

**Exercise 5.** Superimpose the trajectories of gradient descent on level curves of $Q_c$, and draw the line $x=y$. 



```python

fig, axes = plt.subplots(1, 2, figsize=(11, 4.5))

xx, yy = np.meshgrid(
    np.linspace(-0.6, 1.7, 150),
    np.linspace(-0.8, 1.7, 150)
)

for ax, c in zip(axes, [1.0, 20.0]):

    values = ...
    ax.contour(xx, yy, values, levels=20)

    path= ...

    # Trajectory
    ax.plot(path[:, 0], path[:, 1], '-',
            linewidth=1, alpha=0.7)

    # All iterations
    ax.scatter(path[:, 0], path[:, 1],
               s=22, zorder=4, label='GD iterates')

    # Initial and final points
    ax.scatter(*path[0], s=90, marker='s',
               zorder=5, label='Initial point')
    ax.scatter(*path[-1], s=110, marker='*',
               zorder=6, label='Final iterate')

    # Constraint and constrained minimizer
    ax.plot([-0.8, 1.7], [-0.8, 1.7], '--',
            label='Constraint x=y')
    ax.scatter(0.5, 0.5, s=80, marker='x',
               linewidths=2, zorder=7,
               label='Constrained minimizer')

    ax.set(
        xlim=(-0.6, 1.7),
        ylim=(-0.8, 1.7),
        xlabel='x',
        ylabel='y',
        title=f'c={c:g}'
    )
    ax.set_aspect('equal', adjustable='box')
    ax.legend(fontsize=7)

plt.tight_layout()
plt.show()

```

## 6. Conditioning: the limitation of the method

The Hessian of $Q_c$ is

$$\nabla^2 Q_c=\begin{pmatrix}1+c&-c\\-c&1+c\end{pmatrix}.$$

**Exercise 6.** Show that its eigenvalues are $1$ and $1+2c$. Deduce that $Q_c$ is strongly convex, but that

$$\kappa_2(\nabla^2 Q_c)=1+2c\longrightarrow+\infty.$$

Measure the number of gradient-descent iterations needed as $c$ increases. Explain the compromise between constraint accuracy and numerical conditioning.



```python
test_c = np.array([0.5, 1, 2, 5, 10, 20, 50, 100], dtype=float)
rows = []
for c in test_c:
    path = ...
    rows.append((c, ..., len(path)-1, abs(h(*path[-1]))))
print('     c   condition number    GD iterations      |h|     ')
for c, cond, iters, violation in rows:
    print(f'{c:7.1f} {cond:17.1f} {iters:16d} {violation:12.5g}   ')
```

## 7. Quadratic-penalty algorithm

For a prescribed feasibility tolerance $\varepsilon_{\rm feas}$, increase $c$ progressively, using the previous solution as the initial point for the next unconstrained minimization.

**Exercise 7.** Inspect the effect of changing the growth factor and feasibility tolerance. Why is it usually preferable to increase $c$ gradually rather than choosing an extremely large value at the start?



```python
def penalty_method(x0, c0=0.5, growth=5.0, feasibility_tol=1e-3, max_outer=12):
    x = np.asarray(x0, dtype=float)
    c = c0
    history = []
    ...
    return x, history

x_result, history = penalty_method([1.5, -0.5])
for c, x, violation, iterations in history:
    print(f'c={c:8.2f} x={x} |h|={violation:.3e} GD iterations={iterations} ')
print('Final constrained-solution error:', np.linalg.norm(x_result-[0.5,0.5]))
```


```python

```
