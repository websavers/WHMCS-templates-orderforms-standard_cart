{include file="orderforms/{$carttpl}/common.tpl"}

<div id="order-standard_cart">

    <div class="row">

        <div class="pull-md-right col-md-9">
          
            <div class="header-lined">
                <h1 class="font-size-36">
                    {$LANG.transferdomain}
                </h1>
            </div>

        </div>

        <div class="col-md-3 pull-md-left sidebar hidden-xs hidden-sm">

            {include file="orderforms/{$carttpl}/sidebar-categories.tpl"}

        </div>

        <div class="col-md-9 pull-md-right">

            {include file="orderforms/{$carttpl}/sidebar-categories-collapsed.tpl"}
            
            <div class="alert alert-warning text-center">{lang key='orderForm.transferExtend'}* Haven't transferred a domain before? <a href="https://websavers.ca/transfer-domain-registration-websavers/" target="_blank">Click here to learn how to ensure a successful transfer.</a></div>
            
            <form method="post" action="cart.php" id="frmDomainTransfer">
                <input type="hidden" name="a" value="addDomainTransfer">

                <div class="row">
                    <div class="col-sm-8 col-sm-offset-2 offset-sm-2">
                        <div class="panel card panel-default">
                            <div class="panel-heading card-header pb-0">
                                <h3 class="panel-title card-title font-size-24 mb-2">{lang key='orderForm.singleTransfer'}</h3>
                            </div>
                            <div class="panel-body card-body">
                                <div class="form-group">
                                    <label for="inputTransferDomain">{lang key='domainname'}</label>
                                    <input type="text" class="form-control" name="domain" id="inputTransferDomain" value="{$lookupTerm}" placeholder="{lang key='yourdomainplaceholder'}.{lang key='yourtldplaceholder'}" data-toggle="tooltip" data-placement="left" data-trigger="manual" title="{lang key='orderForm.enterDomain'}" />
                                </div>
                                <div class="form-group">
                                    <label for="inputAuthCode" style="width:100%;">
                                        {lang key='orderForm.authCode'}
                                        <a data-toggle="tooltip" data-placement="left" title="{lang key='orderForm.authCodeTooltip'}" class="pull-right float-right"><i class="fas fa-question-circle"></i> {lang key='orderForm.help'}</a>
                                    </label>
                                    <input type="text" class="form-control" name="epp" id="inputAuthCode" placeholder="{lang key='orderForm.authCodePlaceholder'}" data-toggle="tooltip" data-placement="left" data-trigger="manual" title="{lang key='orderForm.required'}" />
                                </div>
                                <div id="transferUnavailable" class="alert alert-warning slim-alert text-center w-hidden"></div>
                                {if $captcha->isEnabled() && !$captcha->recaptcha->isEnabled()}
                                    <div class="captcha-container" id="captchaContainer">
                                        <div class="default-captcha">
                                            <p>{lang key="cartSimpleCaptcha"}</p>
                                            <div>
                                                <img id="inputCaptchaImage" src="{$systemurl}includes/verifyimage.php" />
                                                <input id="inputCaptcha" type="text" name="code" maxlength="6" class="form-control input-sm" data-toggle="tooltip" data-placement="right" data-trigger="manual" title="{lang key='orderForm.required'}" />
                                            </div>
                                        </div>
                                    </div>
                                {elseif $captcha->isEnabled() && $captcha->recaptcha->isEnabled() && !$captcha->recaptcha->isInvisible()}
                                    <div class="text-center">
                                        <div class="form-group recaptcha-container" id="captchaContainer"></div>
                                    </div>
                                {/if}
                            </div>

                            <div class="panel-footer card-footer text-right">
                                <button type="submit" id="btnTransferDomain" class="btn btn-primary btn-transfer{$captcha->getButtonClass($captchaForm)}">
                                    <span class="loader w-hidden" id="addTransferLoader">
                                        <i class="fas fa-fw fa-spinner fa-spin"></i>
                                    </span>
                                    <span id="addToCart">{lang key="orderForm.addToCart"}</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </form>
            
            <p class="text-center small">* {lang key='orderForm.extendExclusions'}</p>
        </div>
    </div>
</div>
