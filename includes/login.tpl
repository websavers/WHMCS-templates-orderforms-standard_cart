{if !$loggedin}
	
	{if $smarty.get.a != 'checkout'}
	<div class="alert alert-message alert-info">
		<i class="fa fa-white fa-info-circle" style="margin-top:1px"></i> 
		<strong>{$LANG.orderForm.domains_alreadyregistered}</strong> 
		<a href="{$smarty.server.PHP_SELF}?a=login" onclick="ws_showloginform();return false;">{$LANG.clickheretologin}</a>
	</div>
	{/if}

	<div id="loginfrm" {if $smarty.get.a != 'checkout'}style="display:none"{/if} class="logincontainer{if $linkableProviders} with-social{/if}">

    <div class="providerLinkingFeedback"></div>

    <div class="row" id="login-box">
        <div class="col-sm-{if $linkableProviders}7{else}12{/if}">

            <form method="post" action="{$systemurl}dologin.php" class="login-form" role="form">
								
								<input type="hidden" name="goto" value="{$smarty.server.REQUEST_URI}">
							
                <div class="form-group">
                    <label for="inputEmail">{$LANG.clientareaemail}</label>
                    <input type="email" name="username" class="form-control" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus>
                </div>

                <div class="form-group">
                    <label for="inputPassword">{$LANG.clientareapassword}</label>
                    <input type="password" name="password" class="form-control" id="inputPassword" placeholder="{$LANG.clientareapassword}" autocomplete="off" >
                </div>
  
                <div align="center">
                    <input id="login" type="submit" class="btn btn-primary" value="{$LANG.loginbutton}" />
                </div>
            </form>

        </div>
        <div class="col-sm-5{if !$linkableProviders} hidden{/if}">
            {include file="$template/includes/linkedaccounts.tpl" linkContext="login" customFeedback=true}
        </div>
    </div>
	</div>

{/if}
