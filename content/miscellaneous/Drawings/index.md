---
title: My drawings/paintings (Slides)
type: landing
links:

url_pdf: "uploads/Drawings.pdf"
sections:
  - block: slider
    content:
      slides:
        - background:
            image:
              # Specify an image from `assets/media/`
              # or delete the image section to remove it
              filename: "1.png"
              filters:
                brightness: 0.9

          link:
            icon: 
            icon_pack: fas
            text: PDF
            url: ../../uploads/Drawings.pdf
        - title: 
          content: 
          align: left
          background:
            image:
              # Specify an image from `assets/media/`
              # or delete the image section to remove it
              filename: Drawings/2.png
              filters:
                brightness: 0.9
    design:
      # Slide height is automatic unless you force a specific height (e.g. '400px')
      slide_height: '1000px'
      # Make the slides full screen within the browser window?
      is_fullscreen: true
      # Automatically transition through slides?
      loop: false
      # Duration of transition between slides (in ms)
      interval: 2000
      object-fit: contain
---