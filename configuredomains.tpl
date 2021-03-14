{include file="orderforms/{$carttpl}/common.tpl"}

{assign var="transfers" value=0}
{assign var="registrations" value=0}
{foreach key=num item=domain from=$domains}
	{if $domain.configtoshow && $domain.eppenabled}{assign var="transfers" value=$transfers+1}
	{else}{assign var="registrations" value=$registrations+1}{/if}
{/foreach}

<div id="order-standard_cart">

    <div class="row">

    	{if $registrations > 0 && $atleastonenohosting}
				{include file="orderforms/$carttpl/includes/login.tpl"}
			{/if}

        <div class="pull-md-right col-md-9">

            <div class="header-lined">
                <h1>{$LANG.cartdomainsconfig}</h1>
            </div>

        </div>

        <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">

            {include file="orderforms/{$carttpl}/sidebar-categories.tpl"}

        </div>

        <div class="col-md-9 pull-md-right">

            {include file="orderforms/{$carttpl}/sidebar-categories-collapsed.tpl"}

            <form method="post" action="{$smarty.server.PHP_SELF}?a=confdomains" id="frmConfigureDomains">
                <input type="hidden" name="update" value="true" />

               <!-- <p>{$LANG.orderForm.reviewDomainAndAddons}</p> -->

                {if $errormessage}
                    <div class="alert alert-danger" role="alert">
                        <p>{$LANG.orderForm.correctErrors}:</p>
                        <ul>
                            {$errormessage}
                        </ul>
                    </div>
                {/if}

								{* Avoid confusion:
									- If any domain doesn't have hosting attached, show name server options (it's auto otherwise)
									- If registrations, show name servers options (ie: don't show them when transfers)
								*}
                {if $atleastonenohosting && $registrations > 0}

                    <div class="sub-heading">
                        <span>{$LANG.domainnameservers}</span>
                    </div>

                    <!-- <p>{$LANG.cartnameserversdesc}</p> -->

                    <div style="text-align: left; margin: 20px auto 15px;" class="col70 center">
                    	{if $loggedin}
                    	<input type="radio" class="radio inline nschoice" name="nschoice" id="ns-websavers" value="custom" checked="checked" /> <label class="full control-label" for="ns-websavers">{$LANG.nschoicewebsavers}</label>
                    	<div id="nameservers-servers" style="display:none">
                    		{if $nameservers_serverlist}
                    	    <select name="servers" style="width: 70%;margin: 5px 0 0 20px">
                    	    	<option id="0" value="null">Select a Hosting Plan / Server</option>
                    	    	{foreach $nameservers_serverlist as $server}
                    	    		{foreach $nameservers as $current_ns}{if $current_ns.value == $server.nameserver1}{assign 'nsmatch' true}{/if}{/foreach}
															<option id="{$server.id}" value="{$server.nameserver1},{$server.nameserver2},{$server.nameserver3},{$server.nameserver4}" {if $nsmatch == 1}selected="selected"{/if}>[{$server.servername}] {$server.planname}{if $nameservers_serverlist|@count > 1 || $server.servername == 'VPS'} - {if $server.domain}{$server.domain}{else}Reseller: {$server.username}{/if}{/if}</option>
                    	    	{/foreach}
                    	    </select>
                    	    {else}
                    	    	<p style="text-align:center">Sorry! No hosting plan was found in your account that has assigned name servers. You must enter them manually.</p>
                    	    {/if}
                    	</div>
                    	<br />
                    	{/if}
                    	<input type="radio" class="radio nschoice" name="nschoice" id="ns-custom" value="custom" /> <label class="full control-label" for="ns-custom" />{$LANG.nschoicecustom}</label>
                    	<br />
                    	<input type="radio" class="radio inline nschoice" name="nschoice" id="ns-default" value="default" {if !$loggedin} checked="checked"{/if} /> <label class="full control-label" for="ns-default" />{$LANG.nschoicedefault}</label>
                    </div>

                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="inputNs1">{$LANG.domainnameserver1}</label>
                                <input type="text" class="form-control" id="inputNs1" name="domainns1" value="{$domainns1}" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="inputNs2">{$LANG.domainnameserver2}</label>
                                <input type="text" class="form-control" id="inputNs2" name="domainns2" value="{$domainns2}" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="inputNs3">{$LANG.domainnameserver3}</label>
                                <input type="text" class="form-control" id="inputNs3" name="domainns3" value="{$domainns3}" />
                            </div>
                        </div>
                        {*
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="inputNs1">{$LANG.domainnameserver4}</label>
                                <input type="text" class="form-control" id="inputNs4" name="domainns4" value="{$domainns4}" />
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="inputNs5">{$LANG.domainnameserver5}</label>
                                <input type="text" class="form-control" id="inputNs5" name="domainns5" value="{$domainns5}" />
                            </div>
                        </div>
                        *}
                    </div>
										
                {/if}

								<script>
								function disable_epp(num){
									jQuery(document).ready(function($){
										$('#inputEppcode' + num).prop('readonly', function(i, v) { 
											if (!v) $(this).val('ENTERLATER');
											else $(this).val('');
											return !v; 
										});
									});
								} 
								</script>
								
                {foreach $domains as $num => $domain}
                <div class="domain-config">

                    <div class="sub-heading">
                        <span>{$domain.domain}<br /><small>{$domain.regperiod} {$LANG.orderyears}</small></span>
                    </div>

                    <div class="row">

                        {if $registrations == 1 || $transfers == 1}<p class="textcenter">{if $domain.hosting}<span style="color:#009900;">{$LANG.cartdomainshashosting}</span>{else}<a href="cart.php" style="color:#cc0000;">{$LANG.cartdomainsnohosting}</a>{/if}</p>{/if}

                        {if $domain.eppenabled}
                            <div class="col-sm-4 eppcode">
                                <div class="form-group prepend-icon">
                                    <input type="text" name="epp[{$num}]" id="inputEppcode{$num}" value="{$domain.eppvalue}" class="field" placeholder="{$LANG.domaineppcode}" />
                                    <label for="inputEppcode{$num}" class="field-icon">
                                        <i class="fas fa-qrcode"></i>
                                    </label>
                                    <span class="field-help-text">{$LANG.domaineppcodedesc}</span>
                                </div>
                            </div>
                        {/if}
                    </div>

                    {if $domain.dnsmanagement || $domain.emailforwarding || $domain.idprotection}
                        <div class="row addon-products">

						{if !$domain.hosting} {* Don't show these if ordering hosting *}
                            {if $domain.dnsmanagement}
                                <div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount} mb-3">
                                    <div class="panel panel-default panel-addon{if $domain.dnsmanagementselected} panel-addon-selected{/if}">
                                        <div class="panel-body">
                                            <label>
                                                <input type="checkbox" name="dnsmanagement[{$num}]"{if $domain.dnsmanagementselected} checked{/if} />
                                                {$LANG.domaindnsmanagement}
                                            </label><br />
                                            {$LANG.domainaddonsdnsmanagementinfo}
                                        </div>
                                        <div class="panel-price">
                                            {$domain.dnsmanagementprice} / {$domain.regperiod} {$LANG.orderyears}
                                        </div>
                                        <div class="panel-add">
                                            <i class="fas fa-plus"></i>
                                            {$LANG.orderForm.addToCart}
                                        </div>
                                    </div>
                                </div>
                            {/if}
						{/if}

                            {if $domain.idprotection}
                                <div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount} mb-3">
                                    <div class="panel panel-default panel-addon{if $domain.idprotectionselected} panel-addon-selected{/if}">
                                        <div class="panel-body">
                                            <label>
                                                <input type="checkbox" name="idprotection[{$num}]"{if $domain.idprotectionselected} checked{/if} />
                                                {$LANG.domainidprotection}
                                            </label><br />
                                            {$LANG.domainaddonsidprotectioninfo}
                                        </div>
                                        <div class="panel-price">
                                            {$domain.idprotectionprice} / {$domain.regperiod} {$LANG.orderyears}
                                        </div>
                                        <div class="panel-add">
                                            <i class="fas fa-plus"></i>
                                            {$LANG.orderForm.addToCart}
                                        </div>
                                    </div>
                                </div>
                            {/if}

						{if !$domain.hosting} {* Don't show these if ordering hosting *}
                            {if $domain.emailforwarding}
                                <div class="col-sm-{math equation="12 / numAddons" numAddons=$domain.addonsCount} mb-3">
                                    <div class="panel panel-default panel-addon{if $domain.emailforwardingselected} panel-addon-selected{/if}">
                                        <div class="panel-body">
                                            <label>
                                                <input type="checkbox" name="emailforwarding[{$num}]"{if $domain.emailforwardingselected} checked{/if} />
                                                {$LANG.domainemailforwarding}
                                            </label><br />
                                            {$LANG.domainaddonsemailforwardinginfo}
                                        </div>
                                        <div class="panel-price">
                                            {$domain.emailforwardingprice} / {$domain.regperiod} {$LANG.orderyears}
                                        </div>
                                        <div class="panel-add">
                                            <i class="fas fa-plus"></i>
                                            {$LANG.orderForm.addToCart}
                                        </div>
                                    </div>
                                </div>
                            {/if}
            {/if}

											</div><!-- .addon-products -->
                    {/if}
										
                    {if $domain.fields}<div class="extra-domain-fields col70 center">
                    {foreach from=$domain.fields key=domainfieldname item=domainfield}
                        <div class="row extra-field">
                            <div class="col-sm-4 text-sm-right">{$domainfieldname}:</div>
                            <div class="col-sm-8">{$domainfield}</div>
                        </div>
                    {/foreach}
                    </div>{/if}
				</div><!-- .package-info -->
                {/foreach}

                <div class="text-center">
                    <button type="submit" class="btn btn-primary btn-lg">
                        {$LANG.continue}
                        &nbsp;<i class="fas fa-arrow-circle-right"></i>
                    </button>
                </div>

            </form>
        </div>
    </div>
</div>
