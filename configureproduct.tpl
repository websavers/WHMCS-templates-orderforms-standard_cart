{include file="orderforms/{$carttpl}/common.tpl"}

<script>
var _localLang = {
    'addToCart': '{$LANG.orderForm.addToCart|escape}',
    'addedToCartRemove': '{$LANG.orderForm.addedToCartRemove|escape}'
}
</script>

<div id="order-standard_cart">

    <div class="row">

        <div class="pull-md-right col-md-9">

            <div class="header-lined">
                <h1>{$LANG.orderconfigure}</h1>
            </div>

        </div>

        <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">

            {include file="orderforms/{$carttpl}/sidebar-categories.tpl"}

        </div>
        <div class="cart-body">

            <div class="header-lined">
                <h1 class="font-size-36">{$LANG.orderconfigure}</h1>
            </div>

            {include file="orderforms/{$carttpl}/sidebar-categories-collapsed.tpl"}

            <form id="frmConfigureProduct">
                <input type="hidden" name="configure" value="true" />
                <input type="hidden" name="i" value="{$i}" />

                <div class="row">
                    <div class="secondary-cart-body">

                        <p>{$LANG.orderForm.configureDesiredOptions}</p>

                        <div class="product-info">
                            <p class="product-title">{$productinfo.name}</p>
                            <p>{$productinfo.description}</p>
                        </div>

                        <div class="alert alert-danger w-hidden" role="alert" id="containerProductValidationErrors">
                            <p>{$LANG.orderForm.correctErrors}:</p>
                            <ul id="containerProductValidationErrorsList"></ul>
                        </div>

                        {if $pricing.type eq "recurring"}
                            <div class="field-container row" id="productBillingCycle">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="inputBillingcycle">{$LANG.cartchoosecycle}</label>
                                        <br>
                                        {foreach from=$pricing.cycles key=k item=v} {* k = monhtly, quarterly, etc. v = the actual pricing output text *}
                                            {if $v}
                                                {if $k eq 'monthly'}{assign var="num_months" value=1}
                                                {elseif $k eq 'quarterly'}{assign var="num_months" value=3}
                                                {elseif $k eq 'semiannually'}{assign var="num_months" value=6}
                                                {elseif $k eq 'annually'}{assign var="num_months" value=12}
                                                {elseif $k eq 'biennially'}{assign var="num_months" value=24}
                                                {elseif $k eq 'triennially'}{assign var="num_months" value=36}
                                                {/if}
                                                {math equation="price / months" price={$pricing.rawpricing.$k} months=$num_months format="%.2f" assign="monthly_breakdown"}
                                                <label for="billingcycle-{$k}">
                                                    <input type="radio" name="billingcycle" id="billingcycle-{$k}" value="{$k}" onchange="if (this.checked){ updateConfigurableOptions({$i}, this.value); }" {if $billingcycle eq "{$k}"} checked{/if}> {$v|replace:"$0.00CAD For":""|replace:"$0.00USD For":""} {if $monthly_breakdown != "0.00"}<span class="monthly_breakdown">(${$monthly_breakdown} Monthly)</span>{/if}
                                                </label>
                                                <br>
                                            {/if}
                                        {/foreach}
                                        
                                        {*
                                        <select name="billingcycle" id="inputBillingcycle" class="form-control select-inline custom-select" onchange="updateConfigurableOptions({$i}, this.value); return false">
                                            {if $pricing.monthly}
                                                <option value="monthly"{if $billingcycle eq "monthly"} selected{/if}>
                                                    {$pricing.monthly|replace:"$0.00CAD ":""}
                                                </option>
                                            {/if}
                                            {if $pricing.quarterly}
                                                <option value="quarterly"{if $billingcycle eq "quarterly"} selected{/if}>
                                                    {$pricing.quarterly|replace:"$0.00CAD ":""}
                                                </option>
                                            {/if}
                                            {if $pricing.semiannually}
                                                <option value="semiannually"{if $billingcycle eq "semiannually"} selected{/if}>
                                                    {$pricing.semiannually|replace:"$0.00CAD ":""}
                                                </option>
                                            {/if}
                                            {if $pricing.annually}
                                                <option value="annually"{if $billingcycle eq "annually"} selected{/if}>
                                                    {$pricing.annually|replace:"$0.00CAD ":""}
                                                </option>
                                            {/if}
                                            {if $pricing.biennially}
                                                <option value="biennially"{if $billingcycle eq "biennially"} selected{/if}>
                                                    {$pricing.biennially|replace:"$0.00CAD ":""}
                                                </option>
                                            {/if}
                                            {if $pricing.triennially}
                                                <option value="triennially"{if $billingcycle eq "triennially"} selected{/if}>
                                                    {$pricing.triennially|replace:"$0.00CAD ":""}
                                                </option>
                                            {/if}
                                        </select>
                                        *}
                                    </div>
                                </div>
                            </div>
                        {/if}

                        {if count($metrics) > 0}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.metrics.title}</span>
                            </div>

                            <p>{$LANG.metrics.explanation}</p>

                            <ul>
                                {foreach $metrics as $metric}
                                    <li>
                                        {$metric.displayName}
                                        -
                                        {if count($metric.pricing) > 1}
                                            {$LANG.metrics.startingFrom} {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                            <button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#modalMetricPricing-{$metric.systemName}">
                                                {$LANG.metrics.viewPricing}
                                            </button>
                                        {elseif count($metric.pricing) == 1}
                                            {$metric.lowestPrice} / {if $metric.unitName}{$metric.unitName}{else}{$LANG.metrics.unit}{/if}
                                            {if $metric.includedQuantity > 0} ({$metric.includedQuantity} {$LANG.metrics.includedNotCounted}){/if}
                                        {/if}
                                        {include file="$template/usagebillingpricing.tpl"}
                                    </li>
                                {/foreach}
                            </ul>

                            <br>
                        {/if}

                        {if $productinfo.type eq "server"}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.cartconfigserver}</span>
                            </div>

                            <div class="field-container">

                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputHostname">{$LANG.serverhostname} <!--i class="fa fa-info-circle" data-toggle="tooltip"></i--></label>
                                            <input type="text" name="hostname" class="form-control" id="inputHostname" value="{$server.hostname}" placeholder="servername.yourdomain.com" autocorrect="off" autocapitalize="off">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputRootpw">{$LANG.serverrootpw}</label>
                                            <input type="password" name="rootpw" class="form-control" id="inputRootpw" value="{$server.rootpw}">
                                        </div>
                                    </div>
                                </div>

                                <div class="row" style="display:none">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs1prefix">{$LANG.serverns1prefix}</label>
                                            <input type="text" name="ns1prefix" class="form-control" id="inputNs1prefix" value="{$server.ns1prefix}" placeholder="ns1">
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="inputNs2prefix">{$LANG.serverns2prefix}</label>
                                            <input type="text" name="ns2prefix" class="form-control" id="inputNs2prefix" value="{$server.ns2prefix}" placeholder="ns2">
                                        </div>
                                    </div>
                                </div>

                            </div>
                        {/if}

                        {if $configurableoptions}
                            <div class="sub-heading">
                                <span class="primary-bg-color">{$LANG.orderconfigpackage}</span>
                            </div>
                            <div class="product-configurable-options" id="productConfigurableOptions">
                                <div class="row">
                                    {foreach $configurableoptions as $num => $configoption}
                                        {if $configoption.optiontype eq 1}
                                            <div class="col-sm-6" {if $configoption.optionname|strstr:"IP"}style="display:none"{/if}>
                                                <div class="form-group">
                                                    <label for="inputConfigOption{$configoption.id}">{if $configoption.optionname eq "Operating System"}Linux System Package{else}{$configoption.optionname}{/if}</label>
                                                    {if $configoption.optionname|stristr:"CPU" || $configoption.optionname|stristr:"Memory" || $configoption.optionname|stristr:"Disk" || $configoption.optionname|stristr:"Storage"}
                                                        {if !$rangesliderincluded}
                                                            <script type="text/javascript" src="{$BASE_PATH_JS}/ion.rangeSlider.min.js"></script>
                                                            <link href="{$BASE_PATH_CSS}/ion.rangeSlider.css" rel="stylesheet">
                                                            <link href="{$BASE_PATH_CSS}/ion.rangeSlider.skinModern.css" rel="stylesheet">
                                                            {assign var='rangesliderincluded' value=true}
                                                        {/if}
                                                        <input type="hidden" name="configoption[{$configoption.id}]" value="{$configoption.selectedvalue}" id="inputConfigOption{$configoption.id}" class="form-control" autocapitalize="none" />
                                                        <input type="text" name="configoption_visual[{$configoption.id}]" value="{foreach $configoption.options as $option}{if $configoption.selectedvalue eq $option.id}{$option.nameonly}{/if}{/foreach}" id="inputConfigOption_visual{$configoption.id}" />
                                                        <script>
                                                            var sliderTimeoutId = null;
                                                            
                                                            input_values_{$configoption.id} = [{foreach $configoption.options as $o}{$o.id},{/foreach}];

                                                            jQuery("#inputConfigOption_visual{$configoption.id}").ionRangeSlider({
                                                                /* values are actually Labels since we override values during onChange */
                                                                values: [{foreach $configoption.options as $o}"{$o.nameonly}",{/foreach}],
                                                                grid: true,
                                                                grid_snap: true,
                                                                onStart: function(data) {
                                                                    //console.log("Visual: {foreach $configoption.options as $o}{if $configoption.selectedvalue eq $o.id}{$o.nameonly}{/if}{/foreach} Actual: " + input_values_{$configoption.id}[data.from]);
                                                                },
                                                                onChange: function(data) {
                                                                  
                                                                    jQuery("#inputConfigOption{$configoption.id}").val(input_values_{$configoption.id}[data.from]);
                                                                    
                                                                    if (sliderTimeoutId) {
                                                                        clearTimeout(sliderTimeoutId);
                                                                    }

                                                                    sliderTimeoutId = setTimeout(function() {
                                                                        sliderTimeoutId = null;
                                                                        recalctotals();
                                                                    }, 250);
                                                                }
                                                            });
                                                        </script>
                                                    {else}
                                                      <select name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" class="form-control">
                                                          {foreach key=num2 item=options from=$configoption.options}
                                                              <option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>
                                                                  {$options.name}
                                                              </option>
                                                          {/foreach}
                                                      </select>
                                                    {/if}
                                                </div>
                                            </div>
                                        {elseif $configoption.optiontype eq 2}
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                    {foreach key=num2 item=options from=$configoption.options}
                                                        <br />
                                                        <label for="option-{$options.id}">
                                                            <input type="radio" name="configoption[{$configoption.id}]" id="option-{$option.id}" value="{$options.id}"{if $configoption.selectedvalue eq $options.id} checked="checked"{/if} />
                                                            {if $options.name}
                                                                {$options.name}
                                                            {else}
                                                                {$LANG.enable}
                                                            {/if}
                                                        </label>
                                                    {/foreach}
                                                </div>
                                            </div>
                                        {elseif $configoption.optiontype eq 3}
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                    <br />
                                                    <label>
                                                        <input type="checkbox" name="configoption[{$configoption.id}]" id="inputConfigOption{$configoption.id}" value="1"{if $configoption.selectedqty} checked{/if} />
                                                        {if $configoption.options.0.name}
                                                            {$configoption.options.0.name}
                                                        {else}
                                                            {$LANG.enable}
                                                        {/if}
                                                    </label>
                                                </div>
                                            </div>
                                        {elseif $configoption.optiontype eq 4}
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <label for="inputConfigOption{$configoption.id}">{$configoption.optionname}</label>
                                                    {if $configoption.qtymaximum}
                                                        {if !$rangesliderincluded}
                                                            <script type="text/javascript" src="{$BASE_PATH_JS}/ion.rangeSlider.min.js"></script>
                                                            <link href="{$BASE_PATH_CSS}/ion.rangeSlider.css" rel="stylesheet">
                                                            <link href="{$BASE_PATH_CSS}/ion.rangeSlider.skinModern.css" rel="stylesheet">
                                                            {assign var='rangesliderincluded' value=true}
                                                        {/if}
                                                        <input type="text" name="configoption[{$configoption.id}]" value="{if $configoption.selectedqty}{$configoption.selectedqty}{else}{$configoption.qtyminimum}{/if}" id="inputConfigOption{$configoption.id}" class="form-control" autocapitalize="none" />
                                                        <script>
                                                            var sliderTimeoutId = null;
                                                            var sliderRangeDifference = {$configoption.qtymaximum} - {$configoption.qtyminimum};
                                                            // The largest size that looks nice on most screens.
                                                            var sliderStepThreshold = 25;
                                                            // Check if there are too many to display individually.
                                                            var setLargerMarkers = sliderRangeDifference > sliderStepThreshold;

                                                            jQuery("#inputConfigOption{$configoption.id}").ionRangeSlider({
                                                                min: {$configoption.qtyminimum},
                                                                max: {$configoption.qtymaximum},
                                                                grid: true,
                                                                grid_snap: setLargerMarkers ? false : true,
                                                                onChange: function() {
                                                                    if (sliderTimeoutId) {
                                                                        clearTimeout(sliderTimeoutId);
                                                                    }

                                                                    sliderTimeoutId = setTimeout(function() {
                                                                        sliderTimeoutId = null;
                                                                        recalctotals();
                                                                    }, 250);
                                                                }
                                                            });
                                                        </script>
                                                    {else}
                                                        {$LANG.enable}
                                                    {/if}
                                                </label>
                                            </div>
                                        </div>
                                    {/if}
                                    {if $num % 2 != 0}
                                </div>
                                <div class="row">
                                    {/if}
                                    {/foreach}
                                </div>
                            </div>

                        {/if}

                        {if $customfields}

                            <div class="sub-heading pb-1">
                                <span class="primary-bg-color">{$LANG.orderadditionalrequiredinfo}<br><i><small>{lang key='orderForm.requiredField'}</small></i></span>
                            </div>

                            <div class="field-container">
                                {foreach $customfields as $customfield}
                                    <div class="form-group">
                                        <label for="customfield{$customfield.id}">{$customfield.name} {$customfield.required}</label>
                                        {$customfield.input}
                                        {if $customfield.description}
                                            <span class="field-help-text">
                                                {$customfield.description}
                                            </span>
                                        {/if}
                                    </div>
                                {/foreach}
                            </div>

                        {/if}

                        {if $addons || count($addonsPromoOutput) > 0}

                            <div id="productAddonsContainer">
                                <div class="sub-heading">
                                    <span class="primary-bg-color">{$LANG.cartavailableaddons}</span>
                                </div>

                                {foreach $addonsPromoOutput as $output}
                                    <div>
                                        {$output}
                                    </div>
                                {/foreach}

                                <div class="row addon-products">
                                    {foreach $addons as $addon}
                                        <div class="col-sm-{if count($addons) > 1}6{else}12{/if}">
                                            <div class="panel card panel-default panel-addon{if $addon.status} panel-addon-selected{/if}">
                                                <div class="panel-body card-body">
                                                    <label>
                                                        <input type="checkbox" name="addons[{$addon.id}]"{if $addon.status} checked{/if} />
                                                        {$addon.name}
                                                    </label><br />
                                                    {$addon.description}
                                                </div>
                                                <div class="panel-price">
                                                    {*
                                                    {if $billingcycle}
                                                    {foreach from=$addon.billingCycles key=cyclename item=cycledata}
                                                        {if $cyclename eq $billingcycle}{assign var="properprice" value="{$cycledata.price} {$cyclename|capitalize}"}{else}{assign var="properprice" value="{$addon.pricing}"}{/if}
                                                    {/foreach}
                                                    {/if}
                                                    {$properprice}
                                                    *}
                                                    {$addon.pricing}
                                                </div>
                                                <div class="panel-add">
                                                    <i class="fas fa-plus"></i>
                                                    {$LANG.addtocart}
                                                </div>
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            </div>
                        {/if}

                    </div>
                    <div class="secondary-cart-sidebar" id="scrollingPanelContainer">

                        <div id="orderSummary">
                            <div class="order-summary">
                                <div class="loader" id="orderSummaryLoader">
                                    <i class="fas fa-fw fa-sync fa-spin"></i>
                                </div>
                                <h2 class="font-size-30">{$LANG.ordersummary}</h2>
                                <div class="summary-container" id="producttotal"></div>
                            </div>
                            <div class="text-center">
                                <button type="submit" id="btnCompleteProductConfig" class="btn btn-primary btn-lg">
                                    {$LANG.continue}
                                    <i class="fas fa-arrow-circle-right"></i>
                                </button>
                            </div>
                        </div>

                    </div>

                </div>

            </form>
        </div>
    </div>
    <div class="bluefoot">
        <i class="fas fa-question-circle"></i>
        {$LANG.orderForm.haveQuestionsContact} <a href="contact.php" target="_blank" class="alert-link">{$LANG.orderForm.haveQuestionsClickHere}</a>
    </div>
</div>

<script>recalctotals();</script>

{include file="orderforms/standard_cart/recommendations-modal.tpl"}
