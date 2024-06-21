---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Error estimate of the non-intrusive reduced basis two-grid method applied to sensitivity analysis (M2AN)"
authors:
- admin
- Bernd Simeon

date: "2024-01-01T00:00:00Z"
doi: ""

# Schedule page publish date (NOT publication's date).
#publishDate: 2023-01-03T12:46:12+01:00

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["2"]

# Publication name and optional abbreviated publication name.
# publication: *Error estimate of the Non-Intrusive Reduced Basis (NIRB) two-grid method with parabolic equations*
# publication_short: *NIRB with Parabolic equations*

abstract: This paper deals with the derivation of Non-Intrusive Reduced Basis (NIRB) techniques for sensitivity analysis, more specifically the direct and adjoint state methods. For highly complex parametric problems, these two approaches may become too costly. To reduce computational times, Proper Orthogonal Decomposition (POD) and Reduced Basis Methods (RBMs) have already been investigated. The majority of these algorithms are however intrusive in the sense that the High-Fidelity (HF) code must be modified. To address this issue, non-intrusive strategies are employed. The NIRB two-grid method uses the HF code solely as a ``black-box'', requiring no code modification. Like other RBMs, it is based on an offline-online decomposition. The offline stage is time-consuming, but it is only executed once, whereas the online stage is significantly less expensive than an HF evaluation. In this paper, we propose new NIRB two-grid algorithms for both the direct and adjoint state methods. On a classical model problem, the heat equation, we prove that HF evaluations of sensitivities reach an optimal convergence rate in L∞(0,T;H1(Ω)), and then establish that these rates are recovered by the proposed NIRB approximations. These results are supported by numerical simulations. We then numerically demonstrate that a further deterministic post-treatment can be applied to the direct method. This further reduces computational costs of the online step while only computing a coarse solution of the initial problem. All numerical results are run with the model problem as well as a more complex problem, namely the Brusselator system. 

# Summary. An optional shortened abstract.
summary: ""

tags: []
categories: []
featured: false


url_pdf: 'https://arxiv.org/abs/2301.00761'
#url_code:
#url_dataset:
#url_project:
#url_slides:
#url_source:
#url_video:

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
# Focal points: Smart, Center, TopLeft, Top, TopRight, Left, Right, BottomLeft, Bottom, BottomRight.
image:
  caption: ""
  focal_point: ""
  preview_only: false



---
