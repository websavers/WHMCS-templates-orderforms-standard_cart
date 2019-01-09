{include file="orderforms/{$carttpl}/common.tpl"}

<div id="order-standard_cart">

    <div class="row">

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

            <p>{$LANG.orderreceived}</p>

            <div class="row">
                <div class="col-sm-8 col-sm-offset-2">
                    <div class="alert alert-info order-confirmation">
                        {$LANG.ordernumberis} <span>{$ordernumber}</span>
                    </div>
                </div>
            </div>

            <p>{$LANG.orderfinalinstructions}</p>

            {if $invoiceid && !$ispaid}
                <div class="alert alert-warning text-center">
                    {$LANG.ordercompletebutnotpaid}
                    <br /><br />
                    <a href="viewinvoice.php?id={$invoiceid}" target="_blank" class="alert-link">
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
             {literal}
             <script>
             /* Hopefully the WHMCS module provides the data for Tag manager to do this for us now?
              gtag('event', 'conversion', {
                'send_to': 'AW-957418798/SswiCM3v6JIBEK6axMgD',
                'value': {/literal}{$amount}{literal},
                'currency': 'CAD',
                'transaction_id': '{/literal}{$ordernumber}{literal}',
              });
              */
              /* Google Analytics eCommerce Tracking. Not needed anymore as we're using a WHMCS module
               var ws_dot_ca = _gaq || []; //merged ga acct.
               ws_dot_ca.push(['_setAccount', 'UA-3271728-25']);
               ws_dot_ca.push(['_trackPageview']);
               ws_dot_ca.push(['_addTrans',
                 '{/literal}{$ordernumber}{literal}',           // transaction ID - required
                 'Websavers Inc',  // affiliation or store name
                 '{/literal}{$amount}{literal}',          // total - required
                 'Dartmouth',       // city
                 'Nova Scotia',     // state or province
                 'Canada'             // country
               ]);
               ws_dot_ca.push(['_trackTrans']); //submits transaction to the Analytics servers
               */
             </script>
             {/literal}
           {/if}

            <div class="text-center">
                <a href="clientarea.php" class="btn btn-default">
                    {$LANG.orderForm.continueToClientArea}
                    &nbsp;<i class="fas fa-arrow-circle-right"></i>
                </a>
            </div>

        </div>

        <div class="alert alert-info">Have a friend that might want to host with us? Send them coupon code IMAFRIEND for 15% off their order!</div>

    </div>
</div>
