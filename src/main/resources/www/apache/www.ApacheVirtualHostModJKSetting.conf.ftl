<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
Listen ${deployed.port}

<VirtualHost ${deployed.host}:${deployed.port}>
	DocumentRoot <#if deployed.documentRoot != ""> ${deployed.documentRoot}<#else> ${deployed.container.defaultDocumentRoot}${deployed.container.host.os.fileSeparator}${deployed.name}</#if>
	ServerName ${deployed.host}


<#list deployed.mountedContexts as ctx >
	JkMount ${ctx} ${deployed.loadbalancerName}
</#list>
<#list deployed.unmountedContexts as ctx >
	JkUnMount ${ctx} ${deployed.loadbalancerName}
</#list>

	
</VirtualHost>

