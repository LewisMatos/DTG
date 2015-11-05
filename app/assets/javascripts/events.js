$(document).ready(function() {
        event.preventDefault();
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
});
