{include file="orderforms/{$carttpl}/common.tpl"}

<div id="order-standard_cart">

    <div class="row text-center">

        <div class="pull-md-right col-md-9">

            <div class="header-lined">
                <h1>{$LANG.orderconfirmation}</h1>
            </div>

        </div>

        <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">

            {include file="orderforms/{$carttpl}/sidebar-categories.tpl"}

        </div>

        <div class="col-md-9 pull-md-right">

            {include file="orderforms/{$carttpl}/sidebar-categories-collapsed.tpl"}
            
            <p>{$LANG.orderreceived} {$LANG.orderfinalinstructions}</p>

            <div class="row" style="margin-top: 30px;">
                <div class="col-sm-8 col-sm-offset-2 offset-sm-2">
                    <div class="order-confirmation" style="font-size:1.2em;letter-spacing: 1px;text-transform:uppercase;">
                        {$LANG.ordernumberis} <br/><span class="ordernumber">{$ordernumber}</span>
                    </div>
                </div>
            </div>

            {if $expressCheckoutInfo}
                <div class="alert alert-info text-center">
                    {$expressCheckoutInfo}
                </div>
            {elseif $expressCheckoutError}
                <div class="alert alert-danger text-center">
                    {$expressCheckoutError}
                </div>
            {elseif $invoiceid && !$ispaid}
                <div class="alert alert-warning text-center">
                    {$LANG.ordercompletebutnotpaid}
                    <br /><br />
                    <a href="{$WEB_ROOT}/viewinvoice.php?id={$invoiceid}" target="_blank" class="alert-link">
                        {$LANG.invoicenumber}{$invoiceid}
                    </a>
                </div>
            {/if}

            {foreach $addons_html as $addon_html}
                <div class="order-confirmation-addon-output">
                    {$addon_html}
                </div>
            {/foreach}

           {if $ispaid}
             <!-- Enter any HTML code which needs to be displayed once a user has completed the checkout of their order here - for example conversion tracking and affiliate tracking scripts -->
           {/if}

            <div class="text-center">
                <a href="{$WEB_ROOT}/clientarea.php" class="btn btn-default">
                    {$LANG.orderForm.continueToClientArea}
                    &nbsp;<i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>
            
            <div class="row" style="margin-top: 25px">
                <div class="col-sm-8 col-sm-offset-2 offset-sm-2">
                  <div class="alert alert-info">Have a friend that might want to host with us? Send them coupon code IMAFRIEND for 15% off their order!</div>
                </div>
            </div>
            

            {if $hasRecommendations}
                {include file="orderforms/{$carttpl}/includes/product-recommendations.tpl"}
            {/if}
        </div>

    </div>
</div>
