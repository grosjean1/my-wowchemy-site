---
# Leave the homepage title empty to use the site title
title: 'Elise Grosjean'
date: 2022-10-24
type: landing

sections:
  - block: about.biography
    id: about
    content:
      title: 
      # Choose a user profile to display (a folder name within `content/authors/`)
      username: admin
  - block: collection
    id: publications
    content:
      title: Recent and upcoming publications
      filters:
        folders:
          - publication
        exclude_featured: true
    design:
      columns: '2'
      view: citation
  - block: experience
    id: Projects      
    content:
      title: Projects
      # Date format for experience
      #   Refer to https://docs.hugoblox.com/customization/#date-format
      date_format: Jan 2006
      # Experiences.
      #   Add/remove as many `experience` items below as you like.
      #   Required fields are `title`, `company`, and `date_start`.
      #   Leave `date_end` empty if it's your current employer.
      #   Begin multi-line descriptions with YAML's `|2-` multi-line prefix.
      items:
        - title: 3D Discontinuous Galerkin - Meniscus regeneration macroscopic model simulation
          company: GitHub folder
          company_url: 'https://github.com/grosjean1/PumpSimulation'
          company_logo: ''
          location: Felix-Klein-Institut für Mathematik
          date_start: '2023-10-10'
          date_end: ''
          description: |2-
              Simulation with FreeFem++

              * Paper : "https://onlinelibrary.wiley.com/doi/10.1002/pamm.202300261?af=R"
              * Implement PDEs in FreeFem++ representing a nonwoven scaffold in a novel 3D printed perfusion chamber which is integrated in a bioreactor that allows in-vitro investigations of scaffolds in interaction with chondrocytes and adipose tissue-derived stem cells
              * Stimulus via a pump system (fluid-solid interaction)
              * Sensitivity analysis of the parameters with model order reduction techniques (compared to real data)
        - title: Back and Forth Nudging - Wave equation
          company: Simulation with FreeFem++
          company_url: ''
          company_logo: ''
          location: INRIA-Saclay
          date_start: '2024-01-01'
          date_end: ''
          description: Initial conditions reconstruction with BFN on a bounded domain [0,1] with Dirichlet bnd conditions, FEM P1 and Newmark scheme for time. [Video in 1D](media/Wave1D.gif) with an observation of the measurements between [0,0.2] and [0.8,1].
        - title: 'Finite Elements Method implementation'
          company: GitHub folder
          company_url: 'https://github.com/grosjean1/navierStokes'
          company_logo: ''
          location: Sorbonne Universite
          date_start: '2018-10-10'
          date_end: '1018-10-10'
          description: |2-
              Simulation with C++
              * Implement the Finite Elements method in C++ to solve 2D Navier-Stokes equation in a channel [Video in 2D](media/LJLL.mp4)
        - title: Non intrusive reduced basis module.
          company: GitLab folder
          company_url: 'https://gitlab.com/mor_dicus/mordicus'
          company_logo: ''
          location: LJLL
          date_start: '2018-10-10'
          date_end: '2021-10-10'
          description: |2-
              Module Python

              * Contribute to an [online library](https://gitlab.com/mor_dicus/mordicus) with EDF and other partners on non intrusive reduced basis method in Python and C++.
              * Implement PDEs in FreeFem++ representing a nonwoven scaffold in a novel 3D printed perfusion chamber which is integrated in a bioreactor that allows in-vitro investigations of scaffolds in interaction with chondrocytes and adipose tissue-derived stem cells
              * Stimulus via a pump system (fluid-solid interaction)
              * Sensitivity analysis of the parameters with model order reduction techniques (compared to real data)

    design:
      columns: '2'
  - block: Experience
    id: Experience
    content:
      # Note: `&shy;` is used to add a 'soft' hyphen in a long heading.
      title: 'Experience'
      subtitle:
      # Date format: https://docs.hugoblox.com/customization/#date-format
      date_format: Jan 2006
      # Accomplishments.
      #   Add/remove as many `item` blocks below as you like.
      #   `title`, `organization`, and `date_start` are the required parameters.
      #   Leave other parameters empty if not required.
      #   Begin multi-line descriptions with YAML's `|2-` multi-line prefix.
      items:
        - certificate_url: 'https://uma.ensta-paris.fr/idefix/'
          date_start: '2024-06-01'
          date_end: ''
          description: ''
          icon: coursera
          organization: 'ENSTA'
          organization_url: https://uma.ensta-paris.fr/idefix/
          title: Assistant professor at ENSTA Paris (IDEFIX)
          url: 'https://uma.ensta-paris.fr/idefix/'
        - certificate_url: 
          date_start: '2023-10-01'
          date_end: '2024-05-31'
          description: |2-
              Postdoc at INRIA-Saclay on assimilation data problem on wave parameter/initial condition reconstruction with back and forth nudging algorithm 
          icon: 
          organization: INRIA
          organization_url: 
          title: POSTDOC INRIA-SACLAY
          url: https://www.edx.org/professional-certificate/uc-berkeleyx-blockchain-fundamentals
        - certificate_url: 
          date_start: '2022-03-01'
          date_end: '2023-10-01'
          description: |2-
              Postdoc at RPTU in Kaiserslautern
              * 3D meniscus tissue regeneration problem implemented with FreeFem++
              * Study of the parameters through sensitivity analysis
              * Model order reduction
          icon: 
          organization: RPTU
          organization_url: 
          title: 'POSTDOC at RPTU'
          url: ''
        - certificate_url: 
          date_start: '2018-10-01'
          date_end: '2022-03-01'
          description: |2-
              PhD on non-intrusive reduced basis methods and application to offshore wind farms.
          icon: 
          organization: LJLL Sorbonne Universite
          organization_url: 
          title: 'PhD at Sorbonne Universite'
          url: ''	  
    design:
      columns: '2'
  - block: collection
    id: talks
    content:
      title: Recent & Upcoming Talks
      filters:
        folders:
          - event
    design:
      columns: '2'
      view: compact
  - block: collection
    id: Teaching
    content:
      title: Teaching
      filters:
        folders:
          - teaching
    design:
      columns: '2'
      view: compact
  - block: slider
    content:
      slides:
        - title: "Slide 1"
          content: 1.png
        - title: "Slide 2"
          content: 1.png
    design:
      is_fullscreen: false
      loop: true
  - block: hero
    content:
      title: Your Hero Title
      image:
        # Reference an image in your `assets/media/` folder
        filename: hero-academic.png
      # Add your Call-To-Action (CTA) button and optional icon
      cta:
        label: Get Started
        url: https://wowchemy.com/templates/
        #icon_pack: fas
        #icon: download
      # Optionally, add an alternative CTA link
      cta_alt:
        label: Ask a question
        url: https://discord.gg/z8wNYzb
      # Optionally, add a note under the Call-To-Action button
      cta_note:
        label: >-
          <div style="text-shadow: none;"><a class="github-button" href="https://github.com/HugoBlox/hugo-blox-builder" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star">Star Hugo Blox Builder</a></div><div style="text-shadow: none;"><a class="github-button" href="https://github.com/wowchemy/starter-hugo-academic" data-icon="octicon-star" data-size="large" data-show-count="true" aria-label="Star">Star the Academic template</a></div>          
      # Add your Hero text here
      text: |-
        **Generated by Hugo Blox Builder - the FREE, Hugo-based open source website builder trusted by 500,000+ sites.**

        **Easily build anything with blocks - no-code required!**

        From landing pages, second brains, and courses to academic resumés, conferences, and tech blogs.

        <!--Custom spacing-->
        <div class="mb-3"></div>
        <!--GitHub Button JS-->
        <script async defer src="https://buttons.github.io/buttons.js"></script>        
    design:
      # Choose an optional background color, gradient, image, or video
      background:
        gradient_end: '#1976d2'
        gradient_start: '#004ba0'
        text_color_light: true
  - block: collection
    id: Miscellaneous
    content:
      title: Miscellaneous
      filters:
        folders:
          - miscellaneous
    design:
      columns: '2'
      view: compact
  - block: contact
    id: contact
    content:
      title: Contact
      subtitle:
      text: 
      # Contact (add or remove contact options as necessary)
      email: elise.grosjean@inria.fr
      phone: 
      appointment_url: 
      address:
        street: 
        city: 
        region: 
        postcode: 
        country: 
        country_code: 
      directions: 
      office_hours:
      # Choose a map provider in `params.yaml` to show a map from these coordinates
      coordinates:
        latitude: 
        longitude: 
      contact_links:
      # Automatically link email and phone or display as text?
      autolink: true
      # Email form provider
      form:
        provider: netlify
        formspree:
          id:
        netlify:
          # Enable CAPTCHA challenge to reduce spam?
          captcha: false
    design:
      columns: '2'
---
