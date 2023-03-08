function url() {

  const encode = () => {
    $('.btn-encode').on('click', function() {
      var origin_url = $('#url_original_url').val();
      $.ajax({
        type: "POST",
        url: '/v1/encode',
        data: {url: origin_url},
        success: function(res){
          if (res.code == 200) {
            $('.shorted_url').text(res.data.short_url);
          } else {
            $('.shorted_url').text('');
            $('.encode_error').text(res.message);
          }
        },
        error: function(error){
        }
      });
    })
  };

  const decode = () => {
    $('.btn-decode').on('click', function() {
      var origin_url = $('#short_url').val();
      $.ajax({
        type: "POST",
        url: '/v1/decode',
        data: {url: origin_url},
        success: function(res){
          if (res.code == 200) {
            $('.original_url').text(res.data.original_url);
          } else {
            $('.original_url').text('');
            $('.decode_error').text(res.message);
          }
        },
        error: function(error){
        }
      });
    })
  };

  const init = () =>{
    encode();
    decode();
  }

  return {
    init
  };
}

$(function () {
  url().init();
})