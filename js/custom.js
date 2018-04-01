jQuery(document).ready(function(){

	/**
	 * Order form steps box 
	 */
	 
	if ( jQuery('#order-standard_cart').length > 0 ){
	
		jQuery( '#order-standard_cart > .row' ).before('<div id="stepsbox-container"><div class="stepsbox inactive"><a href="cart.php">Choose Service</a></div><div class="stepsbox inactive">Domain Options</div><div class="stepsbox inactive">Configure Service</div><div class="stepsbox inactive"><a href="cart.php?a=view">Cart</a></div><div class="stepsbox inactive"><a href="cart.php?a=checkout">Checkout</a></div></div>');
		
	}

	/**
	 * Dynamic Order Form login fields
	 */
	 
	 if ( jQuery('#submitlogin').length > 0 ){
	 
		 jQuery( "#submitlogin" ).click(function() {
		 
		 	//visual
		 	jQuery('input#inputLoginEmail').prop( "disabled", true );
		 	jQuery('input#inputLoginPassword').prop( "disabled", true );
		 	jQuery('button#submitlogin').prop( "disabled", true ).html('<i class="fa fa-circle-o-notch fa-spin"></i> Loading...');
		 	
		 	//functional
		 	jQuery.post( "https://clients.websavers.ca/whmcs/dologin.php", { 
		 		username: jQuery('input#inputLoginEmail').val(), 
		 	  	password: jQuery('input#inputLoginPassword').val(),
		 	}).done(function( data ) {
		 		location.reload();
		 	});
		 });
		 
	 }
	 
	 /** Hosting domain form **/
	 if ( jQuery('#registersld').length > 0 ){
	 	
	 	jQuery('#registersld').change( function(){
		 	sanitize_domain( jQuery('#registersld') );
		});
		
	 }
	 if ( jQuery('#transfersld').length > 0 ){
	 	
	 	jQuery('#transfersld').change( function(){
	 	 	sanitize_domain( jQuery('#transfersld') );
	 	});
	 	
	 }
	 if ( jQuery('#owndomainsld').length > 0 ){
	 	
	 	jQuery('#owndomainsld').change( function(){
	 	 	sanitize_domain( jQuery('#owndomainsld') );
	 	});
	 	
	 }
	 if ( jQuery('#owndomaintld').length > 0 ){
	 	
	 	jQuery('#owndomaintld').change( function(){
	 	 	sanitize_domain( jQuery('#owndomaintld') );
	 	});
	 	
	 }
	 
	 /** VPS Hostname **/
	 if ( jQuery('#inputHostname').length > 0 ){
	 	var $hostname_elem = jQuery('#inputHostname');
	 
	 	$hostname_elem.after('<small class="infotext"><i class="fa fa-info-circle"></i> This is the name for your server, often a subdomain of your website or organization. If you do not have a domain to use, you may use [a_name].myserver.ws and we will configure the DNS for you.</small>');
	 	
	 	$hostname_elem.keyup( function(){
	 	ws_delay(function(){
	 	
	 	 	var $hostname = sanitize_hostname( $hostname_elem );
      
      $hostname_elem.val($hostname); //update on page
	 	 	
	 	 	if ( $hostname.indexOf('.') !== -1 ){ //need a dot character
	 	 		validation_pass( $hostname_elem );
	 	 	}
	 	 	else{
		 	 	validation_fail( $hostname_elem, '<i class="fa fa-warning"></i> A hostname must be a domain or subdomain like xyz.com or sub.xyz.com' );
		 	}
	 	
	 	}, 1000 ); //1s delay
	 	});
	 	
	 }
	 
	 if ( jQuery('#inputNs1prefix').length > 0 ){ jQuery('#inputNs1prefix').val('none'); }
 	 if ( jQuery('#inputNs2prefix').length > 0 ){ jQuery('#inputNs2prefix').val('none'); }
	 
	 /** VPS Root Password **/
	 if ( jQuery('input[name=rootpw]').length > 0 ){
	 
	 	jQuery('input[name=rootpw]').val(randString(30))
	 			.attr('readonly','true')
	 			.after('<small class="infotext"><i class="fa fa-info-circle"></i> A secure password has been automatically generated for you. You will be able to view this password securely in the Client Centre after the server has been provisioned.</small>');
	 	
	 }
	 
	 /** VPS Linux System Package / OS Template **/
	 
	 /** VPS Hostname **/
	 if ( jQuery('select#inputConfigOption25').length > 0 ){
	 
	 	var $system_template_sel = jQuery('select#inputConfigOption25');
	 
	 	//On page load
	 	show_cp_license_info($system_template_sel);
	 
	 	//When dropdown selection is changed.
	 	$system_template_sel.change( function(){
			show_cp_license_info($system_template_sel);
	 	});
	 	
	 }
	 
 	function show_cp_license_info($system_template_sel){
 	
 		if ( $system_template_sel.find('option:selected').text().match("Plesk") ){
 			if ( $system_template_sel.siblings('.cp-license-info').text() === "" ){
 				$system_template_sel.after('<small class="infotext cp-license-info" style="display:block"><i class="fa fa-info-circle"></i> You will need a license to operate this control panel. Be sure to select one from the "Control Panel License" drop down, otherwise the panel will not be usable.</small>');
 			}
 		}
 		else{
 			$system_template_sel.siblings('.cp-license-info').remove();
 		}
 			
 	}

	/**
	 * .ca domain registration CIRA field validation that eNom SHOULD BE DOING FOR US DAMN IT.
	 */
	if ( jQuery('.domain-config .extra-domain-fields').length > 0 ){
		
		jQuery('.domain-config').each(function( index ){
			//Set Canadian Citizen as default
			if ( jQuery('select[name="domainfield[' + index + '][0]"] option[value="Corporation"]:selected') ){
				jQuery('select[name="domainfield[' + index + '][0]"]').val("Canadian Citizen");
			}
			jQuery('input[type="checkbox"][name="domainfield[' + index + '][1]"]').parent().iCheck('check'); // CIRA Agreement Checkbox
			jQuery('input[type="checkbox"][name="domainfield[' + index + '][2]"]').parent().iCheck('check'); // Hide WHOIS Checkbox
			//jQuery('input[type="checkbox"][name="domainfield[' + index + '][1]"]').prop('checked', true); // CIRA Agreement Checkbox
			//jQuery('input[type="checkbox"][name="domainfield[' + index + '][2]"]').prop('checked', true); // Hide WHOIS Checkbox
		});
		
	}
	
	/**
	 * Order form taxation auto-apply
	 * This is for the checkout page only, not cart
	 * Used for tax calcs update.
	 */

	if (jQuery('form[name=orderfrm]').length > 0){
		jQuery('select#stateselect').ready( function(){
		 	jQuery(this).change( function(){
				var $target = jQuery('form[name=orderfrm] .alert.alert-success.text-center.large-text strong');
				$target.html('<i class="fa fas fa-spinner fa-spin"></i>');
				jQuery.post("cart.php", {
					ajax: 1,
					calctotal: true,
					configure: true,
					a: 'setstateandcountry',
					state: jQuery('#stateselect').val(),
					country: jQuery('#inputCountry').val(),
				}).done(function(html) {
					var total_amnt = jQuery(html).find('#totalDueToday').html();
					$target.html(total_amnt);
				}); 
			});
		});
	}

}); /* Document Ready */

function validation_fail(formElement, errorText){
	formElement.addClass('error');
	jQuery('#btnCompleteProductConfig').attr('disabled', 'disabled');
	if ( !formElement.next().hasClass('errortext') ){ //if no error text, add it
		formElement.after('<small class="errortext" style="display:block">' + errorText + '</small>');
	}
}

function validation_pass(formElement){
	jQuery('#btnCompleteProductConfig').removeAttr('disabled');
	formElement.removeClass('error');
	formElement.siblings('.errortext').remove();
}
 

function ws_showloginform() {
    if (jQuery("#custtype").val()=="new") {
        jQuery("#custtype").val("existing");
        jQuery("#signupfrm").fadeToggle("slow",function(){
            jQuery("#loginfrm").fadeToggle();
        });
    } else {
        jQuery("#custtype").val("new");
        jQuery("#loginfrm").fadeToggle("slow",function(){
            jQuery("#signupfrm").fadeToggle();
        });
    }
}

function sanitize_domain(element, allowdots = false, updatedirect = true ){
	
	var $str = element.val();
	if ($str == "") return $str;
	
	$str = $str.replace(/^(https?:\/\/)?(www\.)?/g, '');
	$str = $str.replace(/[^a-zA-Z1-9\-\.]/g, '');
	$str = $str.toLowerCase();
	
	if (element.attr('id').indexOf('tld') !== -1 || allowdots == true){
    if (updatedirect) element.val($str);
    else return $str; //Allow dots in TLD (ex: .com.au)
	}
	else{ //don't allow dots
		
		//Split first part of domain from its TLD into an array: [websavers][ca]
		var domain_parts = $str.split(/\.(.*)/);

		if ( domain_parts[0] != ""){
      if (updatedirect) element.val(domain_parts[0]); //set domain without TLD
      else return domain_parts[0];
			
			if (typeof domain_parts[1] === "undefined"){
				return; //we're done.
			} 	
		}
		
	}
	
}
function sanitize_hostname(element){
	return sanitize_domain(element, true, false);
}

var ws_delay = (function(){
  var timer = 0;
  return function(callback, ms){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  };
})();

/**
 * Password Creation
 */
if(typeof randString != 'function'){
   window.randString = function($length){
	   //var $possible = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789![]{}()%&*$#^<>~@|';
	   var $possible = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
	   var $text = '';
	   for(var i=0; i < $length; i++) {
	     $text += $possible.charAt(Math.floor(Math.random() * $possible.length));
	   }
	   return $text;
   };
}

function card_type_get_visual($cardtype){
  switch($cardtype) {
  case "visa":
      return "Visa";
  case "mastercard":
      return "Mastercard";
  case "amex":
      return "American Express";
  case "discover":
      return "Discover";
  case "jcb":
      return "JCB";
  case "diners-club":
      return "Diners Club";
  default:
      return "Credit Card"
  }
}
function card_type_get_fontawesome($cardtype){
  switch($cardtype) {
  case "visa":
      return "fa-cc-visa";
  case "mastercard":
      return "fa-cc-mastercard";
  case "amex":
      return "fa-cc-amex";
  case "discover":
      return "fa-cc-discover";
  case "jcb":
      return "fa-cc-jcb";
  case "diners-club":
      return "fa-cc-diners-club";
  default:
      return "fa-credit-card"
  }
}

/** Addon Pricing Fixes **/
function ws_update_addon_cycle_pricing(){
  
  var $billingcycle = jQuery('#inputBillingcycle').find(":selected").val();
  
  jQuery(".addon-products .panel-addon").each( function(){

    var $addon_title = jQuery(this).find('label').text();
    var $addon_inputname = jQuery(this).find('label input').attr('name');
    var $addon_price = jQuery(this).find('.panel-price');
    
    if ($addon_price.text().indexOf('One Time') === -1){ //not one-time cycle

      var cycle_matched_price = jQuery.post("cart.php", {
        ajax: 1,
        a: 'confproduct',
        calctotal: true,
        configure: true,
        i: 0,
        billingcycle: $billingcycle,
        [$addon_inputname]: 'on',
        
      }).done(function(html) {
        jQuery(html).find('.pull-left').each(function(){
          if ( jQuery(this).text().indexOf($addon_title.trim()) > -1 ){
            $addon_price.text(jQuery(this).siblings('.pull-right').text());
            //recalctotals(); //refresh cart
          }
        });   	
      });
      
    }
    
  });
  
}
//triggers

jQuery(document).ready(function(){

/* Disabled due to reports of issues with adding plans at 1yr to cart
  ws_update_addon_cycle_pricing();
  
  jQuery('#inputBillingcycle').change(function(){
    ws_update_addon_cycle_pricing();
  });
*/
  
});