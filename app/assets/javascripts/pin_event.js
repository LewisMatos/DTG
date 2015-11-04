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


$('[id*="pin-me-event"]').click(function(event){
  event.preventDefault();
  $.post("/events/pin-event", {"event_id" : Number(event.target.id.split('pin-me-event')[1]), 'pin_event' : true
  }, function() {
    alert('Event Pinned!');
  });
})



setInterval(function(){
    $.get('/events/have-match', function(data){
      if(data.matches) {
        $.each(data.matches, function(index, value){
          alert(value.name + ' is Down To Go to ' + value.event + '!');
        });
      };
    });
}, 5000);



});




