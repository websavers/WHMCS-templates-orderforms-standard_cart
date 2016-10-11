<div id="loginfrm"{if $custtype eq "existing" && !$loggedin}{else} style="display:none;"{/if}>	
				
	<h2 class="textcenter">{$LANG.login}</h2>
	<div class="col50" style="margin: 0 auto;float:none">
	    <input type="email" name="username" id="username" value="{$username}" placeholder="{$LANG.loginemail}" />
		<input type="password" name="password" id="password" placeholder="{$LANG.loginpassword}" />
		<button name="submitlogin" id="submitlogin" class="btn btn-primary" style="width:100%; padding:0.5em" />Login</button>
	</div>
	<div class="clearfix"></div>

</div>