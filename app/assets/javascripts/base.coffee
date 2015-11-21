load_modal = (business)->
  # populate the modal fields from the given business
  $('#business-modal .modal-title').text(business.name)
  $('#business-modal .logo').attr("src", business.logo)
  $('#business-modal .description').text(business.description)
  $('#business-modal .address1').text(business.address1)
  $('#business-modal .address2').text(business.address2)
  $('#business-modal .phone').text(business.phone)
  $("#business-modal").modal("show")

display_details = (id) ->
  # fetch the data for the business with the given id
  $.ajax
    url: "/base/detail?id="+id
    dataType: "JSON"
    success: (data, textStatus, jqXHR) ->
      load_modal(data)
    error: (jqXHR, textStatus, errorThrown) ->
      # fail somewhat silently but log it for developers.
      # the user will get a modal with the default error title.
      console.log "AJAX Error loading business data: #{textStatus}"

@build_map = (dataset) ->
  handler = Gmaps.build 'Google'
  handler.buildMap {
    provider: {}
    internal: 
      id: 'map'
  }, ->
    markers = handler.addMarkers(dataset)
    handler.bounds.extendWith markers
    handler.fitMapToBounds()

    # bind the click event to the map object and present the modal
    _.each dataset, (point, index) ->
      google.maps.event.addListener markers[index].getServiceObject(), 'click', ->
        display_details(point.marker_title)

$(document).ready ->
  # bind any business link to the modal rendering logic
  $('.business-link').on 'click', (e) ->
    display_details(e.currentTarget.dataset.id)