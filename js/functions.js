$(document).ready(function () {
  

  $('#attack2').attr('disabled', 'disabled');
  $('#attack2').prop('checked', false);

  $('#optionnote').fadeIn(0);

  $('.hiddenoptions').fadeOut(0);

  $('.love').attr('disabled', 'disabled');

  $('.topage').attr('disabled', 'disabled');

  
  $('#tcbox').fadeTo('slow',0.3);
  $('#crescent').attr('disabled', 'disabled');



  $('#tcethbox').fadeTo('slow',0.3);
  $('#private').attr('disabled', 'disabled');

  $('#tcobox').fadeTo('slow',0.3);
  $('#events').attr('disabled', 'disabled');

  $('#obox').fadeTo('slow',0.3);
  $('.beer').attr('disabled', 'disabled');
  $('#apprentice').attr('disabled', 'disabled');


  $('#ethbox').fadeTo('slow',0.3);
  $('#buildings').attr('disabled', 'disabled');

  $('#rvbox').fadeTo('slow',0.3);
  $('.reminiscences').attr('disabled', 'disabled');

  
  $('#attack2text').fadeTo('slow',0.3);


  var $category = $('#sets'),
      $article = null;
  

   $('#sets').change(function() {

      $('.hiddenoptions').fadeIn();
      $('#optionnote').fadeOut(0);


      var categoryName = $category.val();


      if(categoryName == '1,2,3' || categoryName == '1,3,4' || categoryName == '2,4' || categoryName == '1,2,3,4' || categoryName == '1,2,3,101' || categoryName == '1,3,4,101' || categoryName == '2,4,101' || categoryName == '1,2,3,4,101'){
            $('#attack2').removeAttr('disabled');
	    $('#attack2text').fadeTo('fast',1);
        } else{
            $('#attack2').attr('disabled', 'disabled');
            $('#attack2').prop('checked', false);
	    $('#attack2text').fadeTo('fast',0.3);
        }

      $('#banned').empty();
      $('<option disabled="disabled" value="0" id="pleaseselect">Please select a game set</option>').appendTo('#banned');

      $('#tcbox').fadeTo(0,0.3);
      $('#crescent').attr('disabled', 'disabled');

      $('#tcethbox').fadeTo(0,0.3);
      $('#private').attr('disabled', 'disabled');

      $('#tcobox').fadeTo(0,0.3);
      $('#events').attr('disabled', 'disabled');

      $('#obox').fadeTo(0,0.3);
      $('.beer').attr('disabled', 'disabled');
      $('#apprentice').attr('disabled', 'disabled');

      $('#ethbox').fadeTo(0,0.3);
      $('#buildings').attr('disabled', 'disabled');

      $('#rvbox').fadeTo(0,0.3);
      $('.reminiscences').attr('disabled', 'disabled');

      $('.love').attr('disabled', 'disabled');
      $('.topage').attr('disabled', 'disabled');

      $('#love6').attr('disabled', 'disabled');
      $('#love6').prop('selected', false);

      $('#love8').attr('disabled', 'disabled');
      $('#love8').prop('selected', false);
      

      jQuery.each(categoryName, function(){

	 switch($.trim(this)) {
	    case '1':
	       $('#tcbox,#tcethbox,#tcobox').fadeTo('fast',1);
	       $('#crescent').removeAttr('disabled');
	       $('#events').removeAttr('disabled');
	       $('#love6').removeAttr('disabled');
	       $('#private').removeAttr('disabled');
	       break;
	    case '2':
	       $('#ethbox,#tcethbox').fadeTo('fast',1);
	       $('#buildings').removeAttr('disabled');
	       $('#private').removeAttr('disabled');
	       break;
	    case '3':
	       $('#rvbox').fadeTo('fast',1);
	       $('.reminiscences').removeAttr('disabled');
	       $('#love6').removeAttr('disabled');
	       break;
	    case '4':
	       $('#tcobox,#obox').fadeTo('fast',1);
	       $('#love6').removeAttr('disabled');
	       $('#events').removeAttr('disabled');
	       $('.beer').removeAttr('disabled');
	       $('#apprentice').removeAttr('disabled');
	       break;
	    case '5':
	       $('#tcobox').fadeTo('fast',1);
	       $('#love6').removeAttr('disabled');
	       $('#love8').removeAttr('disabled');
	       $('#events').removeAttr('disabled');
	       break;
	 }


	 $('.topage').removeAttr('disabled');
	 $('.love').removeAttr('disabled');
	 $('#pleaseselect').remove();


	 // grab the object
	 var p = $('.banlist'+this);

	 // clone it
	 var c = p.clone();

	 // grab the inner html (wrap it so we can get the HTML)
	 var html = $('<div>').append(c).html();

	 $(html).appendTo('#banned');


      });

   });
  
});
