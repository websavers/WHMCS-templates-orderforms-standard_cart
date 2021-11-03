{if $smarty.request.debug eq true}

<link rel="stylesheet" type="text/css" href="{assetPath file='all.css'}?v={$versionHash}" />
<script type="text/javascript" src="{assetPath file='scripts.js'}?v={$versionHash}"></script>

{assetExists file="custom.css"}
<link rel="stylesheet" type="text/css" href="{$__assetPath__}?v={$versionHash}" />
{/assetExists}
{assetExists file="custom.js"}
<script type="text/javascript" src="{$__assetPath__}?v={$versionHash}"></script>
{/assetExists}

{else}

<link rel="stylesheet" type="text/css" href="{assetPath file='all.min.css'}?v={$versionHash}" />
<script type="text/javascript" src="{assetPath file='scripts.min.js'}?v={$versionHash}"></script>

{assetExists file="custom.min.css"}
<link rel="stylesheet" type="text/css" href="{$__assetPath__}?v={$versionHash}" />
{/assetExists}
{assetExists file="custom.min.js"}
<script type="text/javascript" src="{$__assetPath__}?v={$versionHash}"></script>
{/assetExists}

{/if}
