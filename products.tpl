{include file="orderforms/{$carttpl}/common.tpl"}

<div id="order-standard_cart">

    <div class="row">

        <div class="pull-md-right col-md-9">

            <div class="header-lined">
                <h1>
                    {if $productGroup.headline}
                        {$productGroup.headline}
                    {else}
                        {$productGroup.name}
                    {/if}
                </h1>
                {if $productGroup.tagline}
                    <p>{$productGroup.tagline}</p>
                {/if}
            </div>
            {if $errormessage}
                <div class="alert alert-danger">
                    {$errormessage}
                </div>
            {elseif !$productGroup}
                <div class="alert alert-info">
                    {lang key='orderForm.selectCategory'}
                </div>
            {/if}
        </div>

        <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">
            {include file="orderforms/standard_cart/sidebar-categories.tpl"}
        </div>

        <div class="col-md-9 pull-md-right">

            {include file="orderforms/standard_cart/sidebar-categories-collapsed.tpl"}

            <div class="products" id="products">
                <div class="row row-eq-height">
                    {foreach $products as $key => $product}
                        <div class="col-md-6">
                            <div class="product clearfix" id="product{$product@iteration}">
                                <header>
                                    <span id="product{$product@iteration}-name">{$product.name}</span>
                                    {if $product.stockControlEnabled}
                                        <span class="qty">
                                            {$product.qty} {$LANG.orderavailable}
                                        </span>
                                    {/if}
                                </header>
                                <div class="product-desc">
                                    {if $product.featuresdesc}
                                        <p id="product{$product@iteration}-description">
                                            {$product.featuresdesc}
                                        </p>
                                    {/if}
                                    <ul>
                                        {foreach $product.features as $feature => $value}
                                            <li id="product{$product@iteration}-feature{$value@iteration}">
                                                <span class="feature-value">{$value}</span>
                                                {$feature}
                                            </li>
                                        {/foreach}
                                    </ul>
                                </div>
                                <footer>
                                    <div class="product-pricing" id="product{$product@iteration}-price">
                                        {if $product.bid}
                                            {$LANG.bundledeal}<br />
                                            {if $product.displayprice}
                                                <span class="price">{$product.displayprice}</span>
                                            {/if}
                                        {else}
                                            {if $product.pricing.hasconfigoptions}
                                                {$LANG.startingfrom}
                                                <br />
                                            {/if}
                                            <span class="price">{$product.pricing.minprice.price}</span>
                                            <br />
                                            {if $product.pricing.minprice.cycle eq "monthly"}
                                                {$LANG.orderpaymenttermmonthly}
                                            {elseif $product.pricing.minprice.cycle eq "quarterly"}
                                                {$LANG.orderpaymenttermquarterly}
                                            {elseif $product.pricing.minprice.cycle eq "semiannually"}
                                                {$LANG.orderpaymenttermsemiannually}
                                            {elseif $product.pricing.minprice.cycle eq "annually"}
                                                {$LANG.orderpaymenttermannually}
                                            {elseif $product.pricing.minprice.cycle eq "biennially"}
                                                {$LANG.orderpaymenttermbiennially}
                                            {elseif $product.pricing.minprice.cycle eq "triennially"}
                                                {$LANG.orderpaymenttermtriennially}
                                            {/if}
                                            <br>
                                            {if $product.pricing.minprice.setupFee}
                                                <small>{$product.pricing.minprice.setupFee->toPrefixed()} {$LANG.ordersetupfee}</small>
                                            {/if}
                                        {/if}
                                    </div>
                                    <a href="{$WEB_ROOT}/cart.php?a=add&{if $product.bid}bid={$product.bid}{else}pid={$product.pid}{/if}" class="btn btn-success btn-sm" id="product{$product@iteration}-order-button">
                                        <i class="fas fa-shopping-cart"></i>
                                        {$LANG.ordernowbutton}
                                    </a>
                                </footer>
                            </div>
                        </div>
                        {if $product@iteration % 2 == 0}
                            </div>
                            <div class="row row-eq-height">
                        {/if}
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
{/if}
    
{if $gid eq 8}
<div class="alert alert-info">
	Did you know we now offer FREE SSL Certificates included with all of our hosting plans? Although not recommended for eCommerce transactions, our free SSL certificates provided by Let's Encrypt are perfect for securing your website login. They're easy to install and completely free of charge! See <a href="http://www.websavers.ca/set-free-ssl-certificate-letsencrypt-plesk-extension/" target="_blank">our guides page for more details</a>.
</div>
{/if}

<form method="get" action="{$smarty.server.PHP_SELF}">
<div style="text-align:center;margin: 30px 0;font-size: 125%">
	{$LANG.ordercategories}: <select name="gid" onchange="submit()" style="width:auto;display:inline">
	{foreach key=num item=productgroup from=$productgroups}
		<option value="{$productgroup.gid}"{if $gid eq $productgroup.gid} selected="selected"{/if}>{$productgroup.name}</option>
	{/foreach}
	{if $loggedin}
		<option value="addons">{$LANG.cartproductaddons}</option>
		{if $renewalsenabled}
			<option value="renewals">{$LANG.domainrenewals}</option>
		{/if}
	{/if}
	</select>
</div>
</form>

{if $gid eq 8}
<p class="col80 center" style="margin-bottom: 2em;font-size: 1.2em;font-style:italic">
	After you've ordered your certificate there are a few steps you must follow in order to receive and install the certificate <a href="http://www.websavers.ca/install-ssl-certificate-plesk-11/">Click here to read</a> about this process.
</p>
{/if}

{foreach key=num item=product from=$products}

	<div class="productlist package-info">
		<form method="post" action="{$smarty.server.PHP_SELF}?a=add&pid={$product.pid}">
		
		<h2><small>{$num+1}.</small> {$product.name} {if $product.qty!=""}<em>({$product.qty} {$LANG.orderavailable})</em>{/if}</h2>
		<p class="product-description">{$product.description}</p>
		{if $product.freedomain}<em>{$LANG.orderfreedomainregistration} {$LANG.orderfreedomaindescription}</em><br />{/if}
		{if $product.paytype eq "free"}
		{$LANG.orderfree}<br />
		<input type="hidden" name="billingcycle" value="free" />
		{elseif $product.paytype eq "onetime"}
		<div class="onetimeprice">{$product.pricing.onetime} {$LANG.orderpaymenttermonetime}</div>
		<input type="hidden" name="billingcycle" value="onetime" />
		{elseif $product.paytype eq "recurring"}
		<select name="billingcycle">
		
		{if $product.pricing.monthly}<option value="monthly">{$product.pricing.monthly}</option>{/if}
		
		{if $product.pricing.quarterly}<option value="quarterly">{$product.pricing.quarterly}{/if}
		
		{if $product.pricing.semiannually}<option value="semiannually">{$product.pricing.semiannually}</option></option>{/if}
		
		{if $product.pricing.annually}
			<option value="annually" selected="selected">{$product.pricing.annually}
			
			{if $product.pricing.quarterly} | <span class="save">Save {math equation="round(((y - x / 4)/y)*100)" x=$product.pricing.rawpricing.annually y=$product.pricing.rawpricing.quarterly}%</span>{/if}
			
			</option>
		{/if}
		
		{if $product.pricing.biennially}
			<option value="biennially">{$product.pricing.biennially}
			
			{if $product.pricing.quarterly} | <span class="save">Save {math equation="round(((y - x / 8)/y)*100)" x=$product.pricing.rawpricing.biennially y=$product.pricing.rawpricing.quarterly}%</span>
			
			{elseif $product.pricing.annually} | <span class="save">Save {math equation="round(((y - x / 2)/y)*100)" x=$product.pricing.rawpricing.biennially y=$product.pricing.rawpricing.annually}%</span>
			{/if}
			
		 	</option>
		 {/if}
		
		{if $product.pricing.triennially}<option value="triennially">{$product.pricing.triennially}
		
		 	{if $product.pricing.quarterly} | <span class="save">Save {math equation="round(((y - x / 12)/y)*100)" x=$product.pricing.rawpricing.triennially y=$product.pricing.rawpricing.quarterly}%</span>
		 	{elseif $product.pricing.annually} | <span class="save">Save {math equation="round(((y - x / 3)/y)*100)" x=$product.pricing.rawpricing.triennially y=$product.pricing.rawpricing.annually}%</span>
		 	{/if}			</option>
		{/if}
		
		</select>
		{/if}
		
		<input type="submit" value="{$LANG.ordernowbutton}"{if $product.qty eq "0"} disabled{/if} class="btn btn-primary btn-large" />
		<div class="clearfix"></div>
		</form>
	</div>
{/foreach}
<div style="clear:both;height:10px;"></div>

</div>
<aside id="order-secure" class="bluefoot"><i class="fa fa-lock"></i> {$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}</aside>
</div>