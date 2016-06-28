<#--

    THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS
    FOR A PARTICULAR PURPOSE. THIS CODE AND INFORMATION ARE NOT SUPPORTED BY XEBIALABS.

-->
<#if deployed.modulePath?has_content >
### Load jk module
LoadModule ${deployed.moduleName} ${deployed.modulePath}
</#if>

JkWorkersFile       ${deployed.container.configurationFragmentDirectory}/workers.properties
JkLogFile           ${deployed.container.logDirectory}/${deployed.logFile}
JkLogLevel          ${deployed.logLevel}
JkLogStampFormat    "${deployed.logStampFormat}"
JkOptions           ${deployed.options}
JkRequestLogFormat  "${deployed.requestLogFormat}"
JkShmFile           ${deployed.container.logDirectory}/jk-runtime-status

JkMount             /jkmanager/* jkstatus
JkMountCopy 	    all

<#list deployed.mountedContexts as ctx >
JkMount             ${ctx} ${deployed.loadbalancerName}
</#list>

<#list deployed.unmountedContexts as ctx >
JkUnMount           ${ctx} ${deployed.loadbalancerName}
</#list>



