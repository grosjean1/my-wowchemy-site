---
# Documentation: https://docs.hugoblox.com/managing-content/

title: "Exo7"
subtitle: ""
summary: ""
authors: []
tags: []
categories: []
date: 2024-10-15T08:59:10+02:00
lastmod: 2024-10-15T08:59:10+02:00
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
data;

#incoming flow
param :trange: Q:=
1  386
2  346
3  416
4  713
5  1532
6  2000
7  1982
8  1431
9  780
10 476
11 450
12 420
;

# revenue
param B:=
1 3500
2 700
3 2250
4 500
;

param d : 1     2     3    4     5    6     7     8    9     10  11  12:=
1         3     3     3    2     4    5     5     4    5     0   0   0
2         0     0     0    1     3    3     0     0    0.2   0   0   0
3         0     0     0    4.5   7    8     8     7    0.5   0   0   0
4         0     0     0    0.5   2    3.5   3.5   2.5  0.5   0   0   0
;
model;
```
