{include file="orderforms/standard_cart/common.tpl"}

<div id="order-standard_cart">

    <div class="header-lined">
        <h1>
            {$LANG.cartfraudcheck}
        </h1>
    </div>

    <div class="row">

        <div class="col-md-10 col-md-offset-1">

            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}

            <div class="alert alert-danger error-heading">
                <i class="fas fa-exclamation-triangle"></i>
                {$errortitle}
            </div>

            <div class="row">
                <div class="col-sm-8 col-sm-offset-2 text-center">

                    <p class="margin-bottom">{$error}</p>
                    
<p>We know, our fraud protection system is super protective, but it does help keep us from incurring excessive chargebacks, and we tend to like that! But not to worry, we'll help get you up and running yet! Our fraud protection looks at many different things, but one of the most common false positives is the differential in location between your approximate physical location and the address you entered during the order. This can most definitely happen in legitimate cases, such as when you are using a proxy or VPN, or if the address you entered doesn't match with your credit card issuer. If you'd still like to proceed with setting up your hosting account, we'd love to have you! We just require a few pieces of ID to validate your identity.</p>

<p><strong>If you are paying by credit card, please send us the following:</strong></p>
<ol>
  <li>A photo or scan of your government issued ID</li>
  <li>A photo or scan of the front and back of the credit card used to place the order</li>
</ol>
<p><strong>If you are paying by PayPal, please send us the following:</strong></p>
<ol>
  <li>A photo or scan of your government issued ID sent from your PayPal email address.</li>
  <li>An email from your PayPal email address to paypal@websavers.ca. Please use the subject "Email Verification" and remember, the email must come from your PayPal email address and no others. </li>
</ol>
<p>Feel free to blur or black out everything except your name, address, and the last four digits of your credit card. We use this information to link your address and name on your ID to your name on your credit card and then finally to the credit card number by checking the last 4 digits. The quickest way to do this is by taking photos with a smartphone or tablet, then attaching them to a new ticket. You can use an app to black out sensitive information (as indicated above). <a href="https://snapguide.com/guides/blur-faces-and-names-on-ios/" target="_blank">Click here for a handy guide</a> describing how to do so.</p>
<p>Once we've received and validated your identification and payment information, we'll get your account re-activated! There's no need to resubmit your order; you will be able to login and complete payment, which will bring your services online shortly thereafter.</p>

                    <p>
                        <a href="submitticket.php" class="btn btn-default">
                            {$LANG.orderForm.submitTicket}
                            &nbsp;<i class="fas fa-arrow-right"></i>
                        </a>
                    </p>

                </div>
            </div>

        </div>
    </div>
</div>
