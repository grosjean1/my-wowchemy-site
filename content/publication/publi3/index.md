---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Error estimate of the Non-Intrusive Reduced Basis (NIRB) two-grid method with parabolic equations (preprint)"
authors:
- admin
- Yvon Maday

date: "2022-08-01T00:00:00Z"
doi: ""

# Schedule page publish date (NOT publication's date).
#publishDate: 2022-02-01T12:46:12+01:00

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["3"]

# Publication name and optional abbreviated publication name.
# publication: *Error estimate of the Non-Intrusive Reduced Basis (NIRB) two-grid method with parabolic equations*
# publication_short: *NIRB with Parabolic equations*

abstract: Reduced Basis Methods (RBMs) are frequently proposed to approximate parametric problem solutions. They can be used to calculate solutions for a large number of parameter values (e.g. for parameter fitting) as well as to approximate a solution for a new parameter value (e.g. real time approximation with a very high accuracy). They intend to reduce the computational costs of High Fidelity (HF) codes. We will focus on the Non-Intrusive Reduced Basis (NIRB) two-grid method. Its main advantage is that it uses the HF code exclusively as a "black-box," as opposed to other so-called intrusive methods that require code modification. This is very convenient when the HF code is a commercial one that has been purchased, as is frequently the case in the industry. The effectiveness of this method relies on its decomposition into two stages, one offline (classical in most RBMs as presented above) and one online. The offline part is time-consuming but it is only performed once. On the contrary, the specificity of this NIRB approach is that, during the online part, it solves the parametric problem on a coarse mesh only and then improves its precision. As a result, it is significantly less expensive than a HF evaluation. This method has been originally developed for elliptic equations with finite elements and has since been extended to finite volume. In this paper, we extend the NIRB two-grid method to parabolic equations. We recover optimal estimates in L∞(0,T;H1(Ω)) using as a model problem, the heat equation. Then, we present numerical results on the heat equation and on the Brusselator problem.

# Summary. An optional shortened abstract.
summary: ""

tags: []
categories: []
featured: false


url_pdf: 'https://arxiv.org/abs/2211.08897'
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
