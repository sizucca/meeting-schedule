;(function(){

  // TODO: JSで、開始を選択すると、終了がそれより1時間後になる

  $('[data-method="delete"]').on('ajax:success', function(e, data, status, xhr){
    if(data.booking){

      // 該当する予約を非表示に
      $('#js-flash-messages').fadeOut(500);
      $('#js-booking-' + data.booking.id).fadeOut(500);

      // 予約件数を変更
      $('.js-booking-count').each(function(){
        var $count   = $(this);
        var preCount = $count.text();
        if(preCount > 0){
          preCount--;
        }
        $count.fadeOut(500, function(){
          $count.text(preCount);
          $count.show();
        });
      });

      // alert(data.notice);
    }
    else{
      alert(data.alert);
    }
  }).on('ajax:error', function(e, xhr, status, error){
    alert('エラー！');
  });

}());
