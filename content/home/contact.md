---
# An instance of the Contact widget.
widget: contact

# This file represents a page section.
headless: true

# Order that this section appears on the page.
weight: 70

title: Contact
subtitle:

content:
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

  # Contact details (edit or remove options as required)
  email: elise.grosjean@inria.fr
  #phone: 888 888 88 88
  address:
    street: 1 Rue Honoré d'Estienne d'Orves
    city: Palaiseau
    #region: 
    postcode:  91120 
    country: France
    country_code: 
  coordinates:
    latitude: '48.713787'
    longitude: '2.205274'

design:
  columns: '2'
---
