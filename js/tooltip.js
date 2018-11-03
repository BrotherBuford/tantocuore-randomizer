      /*
	 TOOLTIP
      */

      $( document ).ready( function()
      {
	 var targets = $( '[class~=tooltip]' ),
	    target   = false,
	    tooltip = false,
	    title = false;

	 targets.bind( 'mouseenter', function()
	 {
	    target   = $( this );
	    tip	     = target.attr( 'title' );
	    tooltip  = $( '<div id="tooltip" style="text-align: left"></div>' );

	    if( !tip || tip == '' )
	       return false;

	    target.removeAttr( 'title' );
	    tooltip.css( 'opacity', 0 )
	          .html( tip )
	          .appendTo( 'body' );

	    var init_tooltip = function()
	    {
	       if( $( window ).width() < tooltip.outerWidth() * 1.3 )
		  tooltip.css( 'max-width', $( window ).width() / 1.1 );

	       var pos_left = target.offset().left + ( target.outerWidth() / 2 ) - ( tooltip.outerWidth() / 2 ),
		  pos_top   = target.offset().top - tooltip.outerHeight() - 7;

	       if( pos_left < 0 )
	       {
		  pos_left = target.offset().left + target.outerWidth() / 2 - 20;
		  tooltip.addClass( 'left' );
	       }
	       else
		  tooltip.removeClass( 'left' );

	       if( pos_left + tooltip.outerWidth() > $( window ).width() )
	       {
		  pos_left = target.offset().left - tooltip.outerWidth() + target.outerWidth() / 2 + 20;
		  tooltip.addClass( 'right' );

		  if( pos_left < 0 )
		  {
		     pos_left = target.offset().left + target.outerWidth() / 2 - 20;
		     tooltip.removeClass( 'right' );
		     tooltip.addClass( 'left' );
		  }

	       }
	       else
		  tooltip.removeClass( 'right' );

	       if( pos_top < 0 )
	       {
		  var pos_top  = target.offset().top + target.outerHeight() + 7;
		  tooltip.addClass( 'top' );
	       }
	       else
		  tooltip.removeClass( 'top' );

	       tooltip.css( { left: pos_left, top: pos_top } )
		     .animate( { opacity: 1 }, 100 );
	    };

	    init_tooltip();
	    $( window ).resize( init_tooltip );

	    var remove_tooltip = function()
	    {
	       tooltip.animate( { opacity: 0 }, 100, function()
	       {
		  $( this ).remove();
	       });

	       target.attr( 'title', tip );
	    };

	    target.bind( 'mouseleave', remove_tooltip );
	    tooltip.bind( 'click', remove_tooltip );
	 });
      });

      /*
	 ---
      */
