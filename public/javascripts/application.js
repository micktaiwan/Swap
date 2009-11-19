jQuery.ajaxSetup({  
    'beforeSend': function (xhr) {xhr.setRequestHeader("Accept", "text/javascript")}  
});

$(document).ready(function (){  
  $('#new_friend').submit(function (){  
    $.post($(this).attr('action'), $(this).serialize(), null, "script");  
    $('#msg').html('sending...');
    $('#msg').show()
    return false;  
  });  
});

