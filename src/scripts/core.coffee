'use strict'

$.fn.tabs = ->
  nav = $(@).find('.tab-nav').find('a')
  pane = $(@).find '.tab-pane'

  switchTab = (b) ->
    nav.removeClass 'is-active'
    $(nav[b]).addClass 'is-active'

    pane.removeClass 'is-active'
    $(pane[b]).addClass 'is-active'


  nav.click (e) ->
    e.preventDefault()
    i = $(@).index()
    switchTab(i)


# tabs init
$ ->
  $('.product-full').tabs()

# custom select init
$ ->
  $('select').selectBox()

#disabled link
$('.link-disabled').click (e) ->
  e.preventDefault()

# ellipsis controller
$ ->
  newsPreviewContent = $('.article--preview').find('.__main')

  newsPreviewContent.succinct(
    size: 90
  )


# dropdown init
$ ->
  elem = $('.js-dropdown')
  trigger = elem.find('li')
  trigger.click ->
    trigger.removeClass('is-active')
    $(@).addClass('is-active')


# custom scroll init
$ ->
  elem = $('.js-scroll')
  elem.jScrollPane(
#   disable horisontal scroller
    contentWidth: '0px'
  )

# slider
$ ->
  elem = $('#slider')
  $(document).ready ->
    elem.bjqs(
      height: 250
      width: 700
      showcontrols: false
      responsive: false
    )

# gallery
$ ->
  elem = $("#gallery")
  slides = elem.find('.__slides').find('li')
  thumbs = elem.find('.__thumbs').find('li')

  thumbs.click ->
    i = $(@).index()
    slides.removeClass('is-active')
    $(slides[i]).addClass('is-active')
