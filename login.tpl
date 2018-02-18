{if !$loggedin}
<div class="alert alert-message alert-info">
	<p style="font-size:1.2em">
		<i class="fa fa-white fa-info-circle" style="margin-top:1px"></i> 
		<strong>{$LANG.orderForm.domains_alreadyregistered}</strong> 
		<a href="{$smarty.server.PHP_SELF}?a=login" onclick="ws_showloginform();return false;">{$LANG.clickheretologin}</a>
	</p>
</div>
{/if}

<div id="loginfrm" style="{if $custtype eq 'existing' && !$loggedin}{else}display:none;{/if} padding: 10px 0;">	
				
	<h2 class="textcenter" style="padding: 10px;">{$LANG.login}</h2>
	<div class="col40 center clear" style="margin: 0 auto;float:none">
			<div class="form-group prepend-icon">
					<label for="inputLoginEmail" class="field-icon">
							<i class="fa fa-envelope"></i>
					</label>
					<input type="email" name="loginemail" id="inputLoginEmail" class="field" placeholder="{$LANG.orderForm.emailAddress}">
			</div>
			<div class="form-group prepend-icon">
					<label for="inputLoginPassword" class="field-icon">
							<i class="fa fa-lock"></i>
					</label>
					<input type="password" name="loginpassword" id="inputLoginPassword" class="field" placeholder="{$LANG.clientareapassword}">
			</div>
			
		<button name="submitlogin" id="submitlogin" class="btn btn-primary" style="width:100%; padding:0.5em" />Login</button>
	</div>
	
	
</div>