---
# Documentation: https://wowchemy.com/docs/managing-content/

title: "Error estimate of the Non-Intrusive Reduced Basis (NIRB) two-grid method with parabolic equations (upcoming)"
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

abstract: Reduced Basis Methods (RBMs) are often proposed to approximate solutions of parametric problems. They are useful both to compute solutions for a large number of parameter values (e.g. for parameter fitting) and to approximate a solution for a new parameter value (e.g. real time approximation with a very high accuracy). They aim at reducing the computational costs of High Fidelity (HF) codes. They require well chosen solutions, called snapshots, preliminary computed (e.g. offline) with a HF classical method, involving, e.g. a fine mesh (finite element or finite volume) and generally require a profound modification of the HF code, in order for the online computation to be performed in short (or even real) time. In this paper, we will focus on the Non-Intrusive Reduced Basis (NIRB) two-grid method. Its main advantage is its efficient way of using the HF code exclusively as a “black-box”, unlike other so-called intrusive methods which require a modification of the code. This is very convenient when the HF code is a commercial one and has been purchased, as is often the case in the industry. The effectiveness of this method relies on its decomposition into two stages, one offline (classical in most RBMs as presented above) and one online. The offline part is time-consuming but it is executed only once. On the contrary, the specificity of the NIRB approach is to solve, during the online part, the parametric problem on a coarse mesh only, and then to improve its precision. It is thus much cheaper than a HF evaluation. This method has been initially developed in the context of elliptic equations with finite element and has been extended to finite volume. In this paper, we generalize the NIRB two-grid method to parabolic equations. To the best of our knowledge, the two-grid method has not already been studied in the context of time-dependent problems. With a model problem, which is the heat equation, we recover optimal estimates in $L^{\infty}(0, T; H^1(\Omega))$, and present numerical results.

# Summary. An optional shortened abstract.
summary: ""

tags: []
categories: []
featured: false


url_pdf: 'media/parabolic.pdf'
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
