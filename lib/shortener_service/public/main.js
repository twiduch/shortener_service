$(function() {
  prepareSendingEvents ()

  function prepareSendingEvents () {
    $('#sendButton').click(sendAndHandleData);

    $('input[name=url]').keyup(function(e){
      if(e.keyCode == 13) { sendAndHandleData() }
    });
  }

  function sendAndHandleData() {
    var data = JSON.stringify({url: $('input[name=url]').val()});
    $.post('/', data, function( result ) {
      $('table').
        append(''.concat(
          '<tr><td>', result.url,
          '</td><td>', result.short_url,
          '</td></tr>'
        ));
    }, 'json');
  }
});