	$(document).ready(function(){
  $('.event-link').click(function(event){
    $.post("/events/tinder_logic", {"event_id" : Number(event.target.id.split('modal')[1])
  }, function(html) {
    $('#modal-tindering' + event.target.id.split('modal')[1]).html(html);
  });
}); 

$('[id*="pin-event"]').click(function(event){
    event.preventDefault();
    $.post("/events/tinder_logic", {"event_id" : Number(event.target.id.split('pin-event')[1]), 'pin_event' : true
  }, function(html) {
    $('#modal-tindering' + event.target.id.split('pin-event')[1]).html(html);
  });
}); 
});




