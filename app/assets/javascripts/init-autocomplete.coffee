$(document).on 'turbolinks:load', ->
  initAutoFocus()

window.lists = () ->
  $('[data-behaviour=autocomplete]').data('list')

window.initAutoFocus = () ->
  $('[data-behaviour=autocomplete]').autocomplete(source: lists(), minLength: 0).focus ->
    $(this).data("uiAutocomplete").search($(this).val())