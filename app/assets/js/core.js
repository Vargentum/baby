(function() {
  'use strict';
  $.fn.tabs = function() {
    var nav, pane, switchTab;
    nav = $(this).find('.tab-nav').find('a');
    pane = $(this).find('.tab-pane');
    switchTab = function(b) {
      nav.removeClass('is-active');
      $(nav[b]).addClass('is-active');
      pane.removeClass('is-active');
      return $(pane[b]).addClass('is-active');
    };
    return nav.click(function(e) {
      var i;
      e.preventDefault();
      i = $(this).index();
      return switchTab(i);
    });
  };

  $(function() {
    return $('.product-full').tabs();
  });

  $(function() {
    return $('select').selectBox();
  });

  $('.link-disabled').click(function(e) {
    return e.preventDefault();
  });

  $(function() {
    var newsPreviewContent;
    newsPreviewContent = $('.article--preview').find('.__main');
    return newsPreviewContent.succinct({
      size: 90
    });
  });

  $(function() {
    var elem, trigger;
    elem = $('.js-dropdown');
    trigger = elem.find('li');
    return trigger.click(function() {
      trigger.removeClass('is-active');
      return $(this).addClass('is-active');
    });
  });

  $(function() {
    var elem;
    elem = $('.js-scroll');
    return elem.jScrollPane({
      contentWidth: '0px'
    });
  });

  $(function() {
    var elem;
    elem = $('#slider');
    return $(document).ready(function() {
      return elem.bjqs({
        height: 250,
        width: 700,
        showcontrols: false,
        responsive: false
      });
    });
  });

  $(function() {
    var elem, slides, thumbs;
    elem = $("#gallery");
    slides = elem.find('.__slides').find('li');
    thumbs = elem.find('.__thumbs').find('li');
    return thumbs.click(function() {
      var i;
      i = $(this).index();
      slides.removeClass('is-active');
      return $(slides[i]).addClass('is-active');
    });
  });

}).call(this);
