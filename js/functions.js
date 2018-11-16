$(document).ready(function () {
  

  $('#attack2,.love,.topage,#crescent,#private,#events,.beer,#apprentice,#buildings,.reminiscences').attr('disabled', 'disabled');

  $('#attack2').prop('checked', false);

  $('#optionnote').fadeIn(0);

  $('.hiddenoptions').fadeOut(0);

  $('#tcbox,#tcethbox,#tcobox,#obox,#ethbox,#rvbox,#wrbox,#attack2text').fadeTo('slow',0.3);
  

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

      $('#tcbox,#tcethbox,#tcobox,#obox,#ethbox,#rvbox,#wrbox').fadeTo(0,0.3);

      $('#crescent,#private,#events,.beer,#apprentice,#buildings,.reminiscences,#drama,.love,.topage,#love6,#love8').attr('disabled', 'disabled');

      $('#love6,#love8').prop('selected', false);

      jQuery.each(categoryName, function(){

	 switch($.trim(this)) {
	    case '1':
	       $('#tcbox,#tcethbox,#tcobox').fadeTo('fast',1);
	       $('#crescent,#events,#love6,#private').removeAttr('disabled');
	       break;
	    case '2':
	       $('#ethbox,#tcethbox').fadeTo('fast',1);
	       $('#buildings,#private').removeAttr('disabled');
	       break;
	    case '3':
	       $('#rvbox').fadeTo('fast',1);
	       $('.reminiscences,#love6').removeAttr('disabled');
	       break;
	    case '4':
	       $('#tcobox,#obox,#ethbox').fadeTo('fast',1);
	       $('#love6,#events,.beer,#apprentice,#buildings').removeAttr('disabled');
	       break;
	    case '5':
	       $('#tcobox,#wrbox,#ethbox').fadeTo('fast',1);
	       $('#events,#drama,#love6,#love8,#buildings').removeAttr('disabled');
	       break;
	 }


	 $('.topage,.love').removeAttr('disabled');
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
