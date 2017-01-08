{if !$loggedin}<div class="alert alert-message alert-warning"><p style="font-size:1.2em"><i class="fa fa-exclamation-triangle" style="margin-top:1px"></i> <strong>{$LANG.orderForm.domains_alreadyregistered}</strong> <a href="{$smarty.server.PHP_SELF}?a=login" onclick="showloginform();return false;">{$LANG.clickheretologin}</a></p></div>{/if}

<div id="loginfrm" style="{if $custtype eq 'existing' && !$loggedin}{else}display:none;{/if} padding: 10px 0;">	
				
	<h2 class="textcenter" style="padding: 10px;">{$LANG.login}</h2>
	<div class="col30 center clear" style="margin: 0 auto;float:none">
	    <input type="email" name="username" id="username" value="{$username}" placeholder="{$LANG.loginemail}" />
		<input type="password" name="password" id="password" placeholder="{$LANG.loginpassword}" />
		<button name="submitlogin" id="submitlogin" class="btn btn-primary" style="width:100%; padding:0.5em" />Login</button>
	</div>
	
</div>