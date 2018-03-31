$(document).on 'turbolinks:load', ->
  $('.chosen-select').each ->
    $chosenSelect = $(this)
    $selectDiv = $("##{$chosenSelect.attr('id')}_chosen")
    $selectDiv.remove()
    $chosenSelect.chosen(width: '100%', search_contains: true)