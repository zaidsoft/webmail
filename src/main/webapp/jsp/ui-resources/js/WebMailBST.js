/*
=====================================================
 WebMail-BSTemplate
 
    Author: luqman quadri
    License: Open source - MIT

=====================================================        

		WebMailBST.js    
	java script functionalities
		* toggle side menu
		* Showing mini side bar
		* managing width and height of page
		* contact list popover
 */


$.WebMailBST = {};   //object

$.WebMailBST.options = {
 
sidebarToggleSelector: "[data-toggle='offcanvas']",
sidebarPushMenu: true,
animationSpeed: 400,
controlSidebarOptions: {
    toggleBtnSelector: "[data-toggle='control-sidebar']",
    selector: ".control-sidebar",
    slide: true
  },
  
  screenSizes: {
    xs: 480,
    sm: 768,
    md: 992,
    lg: 1200
  }
};

/* ------------------
 * - Implementation -
 * ------------------ */
$(function () {
  "use strict";

/*  //Fix for IE page transitions
  $("body").removeClass("hold-transition");

  //Extend options if external options exist
  if (typeof WebMailBSTOptions !== "undefined") {
    $.extend(true,
            $.WebMailBST.options,
            WebMailBSTOptions);
  }*/

  
  var obj = $.WebMailBST.options;   // for accessing options

  //Set up the object
  manage_object();

  //Activate the layout maker
  $.WebMailBST.layout.activate();

    //Enable control sidebar
  if (obj.enableControlSidebar) {
    $.WebMailBST.controlSidebar.activate();
  }

  //Activate sidebar push menu
  if (obj.sidebarPushMenu) {
    $.WebMailBST.pushMenu.activate(obj.sidebarToggleSelector);
  }


  //Activate box widget
  if (obj.enableBoxWidget) {
    $.WebMailBST.boxWidget.activate();
  }

  /*
   * INITIALIZE BUTTON TOGGLE
   * ------------------------
   */
  $('.btn-group[data-toggle="btn-toggle"]').each(function () {
    var group = $(this);
    $(this).find(".btn").on('click', function (e) {
      group.find(".btn.active").removeClass("active");
      $(this).addClass("active");
      e.preventDefault();
    });

  });
});

/* ----------------------------------
 * - Initialize the WebMailBST Object -
 * ----------------------------------
 * All WebMailBST functions are implemented below.
 */
function manage_object() {
  'use strict';
 
  $.WebMailBST.layout = {
    activate: function () {
      var _this = this;
      _this.fix();
      _this.fixSidebar();
      $(window, ".wrapper").resize(function () {
        _this.fix();
        _this.fixSidebar();
      });
    },
    fix: function () {
      //Get window height and the wrapper height
      var neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight();
      var window_height = $(window).height();
      var sidebar_height = $(".sidebar").height();
      //Set the min-height of the content and sidebar based on the
      //the height of the document.
      if ($("body").hasClass("fixed")) {
        $(".content-wrapper, .right-side").css('min-height', window_height - $('.main-footer').outerHeight());
      } else {
        var postSetWidth;
        if (window_height >= sidebar_height) {
          $(".content-wrapper, .right-side").css('min-height', window_height - neg);
          postSetWidth = window_height - neg;
        } else {
          $(".content-wrapper, .right-side").css('min-height', sidebar_height);
          postSetWidth = sidebar_height;
        }

        //Fix for the control sidebar height
        var controlSidebar = $($.WebMailBST.options.controlSidebarOptions.selector);
        if (typeof controlSidebar !== "undefined") {
          if (controlSidebar.height() > postSetWidth)
            $(".content-wrapper, .right-side").css('min-height', controlSidebar.height());
        }

      }
    },
    fixSidebar: function () {
      //Make sure the body tag has the .fixed class
      if (!$("body").hasClass("fixed")) {
        if (typeof $.fn.slimScroll != 'undefined') {
          $(".sidebar").slimScroll({destroy: true}).height("auto");
        }
        return;
      } else if (typeof $.fn.slimScroll == 'undefined' && window.console) {
        window.console.error("Error: the fixed layout requires the slimscroll plugin!");
      }
      //Enable slimscroll for fixed layout
      if ($.WebMailBST.options.sidebarSlimScroll) {
        if (typeof $.fn.slimScroll != 'undefined') {
          //Destroy if it exists
          $(".sidebar").slimScroll({destroy: true}).height("auto");
          //Add slimscroll
          $(".sidebar").slimscroll({
            height: ($(window).height() - $(".main-header").height()) + "px",
            color: "rgba(0,0,0,0.2)",
            size: "3px"
          });
        }
      }
    }
  };

  /* PushMenu()
   * ==========
   this function is used to provide the sidebar toggle on click
   */
  $.WebMailBST.pushMenu = {
    activate: function (toggleBtn) {
      //Get the screen sizes
      var screenSizes = $.WebMailBST.options.screenSizes;

      //Enable sidebar toggle
      $(toggleBtn).on('click', function (e) {
        e.preventDefault();

        //Enable sidebar push menu
        if ($(window).width() > (screenSizes.sm - 1)) {
          if ($("body").hasClass('sidebar-collapse')) {
            $("body").removeClass('sidebar-collapse').trigger('expanded.pushMenu');
          } else {
            $("body").addClass('sidebar-collapse').trigger('collapsed.pushMenu');
          }
        }
        //Handle sidebar push menu for small screens
        else {
          if ($("body").hasClass('sidebar-open')) {
            $("body").removeClass('sidebar-open').removeClass('sidebar-collapse').trigger('collapsed.pushMenu');
          } else {
            $("body").addClass('sidebar-open').trigger('expanded.pushMenu');
          }
        }
      });

      $(".content-wrapper").click(function () {
        //Enable hide menu when clicking on the content-wrapper on small screens
        if ($(window).width() <= (screenSizes.sm - 1) && $("body").hasClass("sidebar-open")) {
          $("body").removeClass('sidebar-open');
        }
      });
    }}
  };
  
  /* Popover()
   * ==========
   this function is used to provide the popover as the user hovers over the contact name in contact list
   */
  
/*  $(".pop").on("mouseenter", function () {
	  setTimeout(function () {*/
  
 
	$(".pop").popover({ 
		trigger: "manual",
		html: true, 
		content: function() { return $('#popover-content').html(); },
		animation:false})
		
    .on("mouseenter", function () {
        var _this = this;
        $(this).popover("show");
        $(".popover").on("mouseleave", function () {
            $(_this).popover('hide');
            
        });
        
    }).on("mouseleave", function () {
    	$(_this).popover("hide");
        var _this = this;
        setTimeout(function () {
            if (!$(".popover:hover").length) {
                $(_this).popover("hide");
            }
        }, 60);
/*}); }, 60);*/
  });
	
/*  ============= 
 * following function is used to select all the listed mail when user clicks on select all button.
 *   */
	
	$('.select-all').change(function(){
	    if($(this).prop('checked')){
	        $('tbody tr td input[type="checkbox"]').each(function(){
	            $(this).prop('checked', true);
	        });
	    }else{
	        $('tbody tr td input[type="checkbox"]').each(function(){
	            $(this).prop('checked', false);
	        });
	    }
	});
	
	/*following function is used to show or hide the control buttons as the user selects the mail from the list*/
	$(document).ready(function(){
		$('.controll-btn-group').hide();
		$('.controll-btn-group-single-select').hide();
	$('tbody tr td input[type="checkbox"]').click(function(){
		$('.controll-btn-group').hide();
		$('.controll-btn-group-single-select').hide();
		if($("tbody tr td input:checkbox:checked").length ==1){
			$('.controll-btn-group-single-select').show();
			$('.controll-btn-group').show();
		}else
			if($("tbody tr td input:checkbox:checked").length >1){
				$('.controll-btn-group').show();
				$('.controll-btn-group-single-select').hide();
				
			}
		
		
		
		 /*if($(this).prop('checked') || $("tbody tr td input:checkbox:checked").length > 0 ){
			 $('.controll-btn-group').show();
		 }
		 else{
			 $('.controll-btn-group').hide();
		 }
		*/
	})
	});
	
	
/*	following function is used to show the message that all emails on the screen has been selected\
	as well as it also show the control buttons.*/
	$('.alert-on-select').hide();
	$('.select-all').change(function(){
		$('.controll-btn-group').hide();
		$('.alert-on-select').hide();
		if($(this).prop('checked')){
			$('.controll-btn-group').show();
			$('.alert-on-select').show();
			$('.controll-btn-group-single-select').hide();
		}
				
	});
	
	
	
	/*$('.controll-btn-group').hide();
	$('tbody tr td input[type="checkbox"]').change(function(){
	    if($(this).prop('checked')){
	        $('.controll-btn-group').each(function(){
	            $(this).show();
	        });
	    }else{
	        $('.controll-btn-group').each(function(){
	            $(this).hide();
	        });
	    }
	});
	*/
	
	
	
	/*
	$(document).ready(function(){
		$('.controll-btn-group').hide();
	if($('.chkbox').prop('checked'))
		{
		$('.controll-btn-group').show();
		}
	
	});
		*/
	
	
	/*following function is used to make the table row clickable. */
	
/*	$(function(){
	    $('tbody tr').each(function(){
	    	
	        $(this).css('cursor','pointer').hover(
	            function(){ 
	                $(this).addClass('active'); 
	            },  
	            function(){ 
	                $(this).removeClass('active'); 
	            }).click( function(){ 
	                document.location = $(this).attr('href'); 
	            }
	        );
	    });
	});*/
	
	$(function(){
		$('tbody tr').each(function(){
			$(this).css('cursor', 'pointer').hover(function(){
				$(this).addClass('active');
			},
			function(){
				$(this).removeClass('active');
			});
			$("tbody tr td:not(:first-child)").click(function(){
				document.location = $('tbody tr').attr('href'); 
			});
		});	
	});	
	
	