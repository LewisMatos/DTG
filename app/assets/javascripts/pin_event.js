$(document).ready(function(){

  // click events to 
  $.post("/events/all", function(html){
    $("#event-page-style").html(html);
  });


  $("#my-events-all").click(function(event){
      event.preventDefault(); 
      $.post("/events/all", function(html){
        $("#event-page-style").html(html);
      });
  });

  $("#my-events-mine").click(function(event){
    event.preventDefault(); 
      $.post("/events/myevents", function(html){
          $("#event-page-style").html(html);
      });
  });

  $("#dos").click(function(event){
    $.post("/events/all", function(html){
      $("#event-page-style").html(html);
    });
  });   


  // function to check for people who have matched you.
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




