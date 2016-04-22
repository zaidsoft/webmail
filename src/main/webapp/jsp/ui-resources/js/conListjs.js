/**
 * 
 */
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
	