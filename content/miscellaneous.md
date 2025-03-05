---
title: My page
type: landing

sections:
  - block: slider
    content:
      slides:
        - background:
            image:
              # Specify an image from `assets/media/`
              # or delete the image section to remove it
              filename: test.jpg
        - title: test
          content: 
          align: left
          background:
            image:
              # Specify an image from `assets/media/`
              # or delete the image section to remove it
              filename: 1.png
              filters:
                brightness: 0.7
        - title: World-Class Semiconductor Lab
          content: 'Just opened last month!'
          align: right
          background:
            image:
              # Specify an image from `assets/media/`
              # or delete the image section to remove it
              filename: 1.png
              filters:
                brightness: 0.5
            position: center
          link:
            icon: graduation-cap
            icon_pack: fas
            text: Join Us
            url: ../contact/
    design:
      # Slide height is automatic unless you force a specific height (e.g. '400px')
      slide_height: ''
      # Make the slides full screen within the browser window?
      is_fullscreen: true
      # Automatically transition through slides?
      loop: false
      # Duration of transition between slides (in ms)
      interval: 2000
---