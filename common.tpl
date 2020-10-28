{if $smarty.request.debug eq true}
<link rel="stylesheet" type="text/css" href="templates/orderforms/{$carttpl}/css/all.css?v={$versionHash}" />
<script type="text/javascript" src="templates/orderforms/{$carttpl}/js/scripts.js?v={$versionHash}"></script>
<script type="text/javascript" src="templates/orderforms/{$carttpl}/js/custom.js?v={$versionHash}"></script>
{else}
<link rel="stylesheet" type="text/css" href="templates/orderforms/{$carttpl}/css/all.min.css?v={$versionHash}" />
<script type="text/javascript" src="templates/orderforms/{$carttpl}/js/scripts.min.js?v={$versionHash}"></script>
<script type="text/javascript" src="templates/orderforms/{$carttpl}/js/custom.min.js?v={$versionHash}"></script>
{/if}