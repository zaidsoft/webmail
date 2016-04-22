/*
 * Copyright 2016 Syed Luqman Quadri. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
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
	