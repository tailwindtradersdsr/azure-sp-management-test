# Connect to Azure using a User account with Azure AD permissions to create Apps/SPs
# Store the Tenant Id for use later
$userContext = Connect-AzAccount
$tenantId = $userContext.Context.Tenant.TenantId

# SP for managing other SPs (including Key Rolling)
$spManagerApplication = New-AzADApplication -DisplayName 'SP Manager' -IdentifierUris 'https://doesnotmatter.spmanager.seequent.com'
$spManagerServicePrincipal = New-AzADServicePrincipal -ApplicationObject $spManagerApplication
$spManagerCredential = New-AzADServicePrincipalCredential -ServicePrincipalObject $spManagerServicePrincipal

# Create an SP to be managed
$spPipelineApplication = New-AzADApplication -DisplayName 'SP for Pipeline' -IdentifierUris 'https://doesnotmatter.pipeline.seequent.com'
$spPipelineServicePrincipal = New-AzADServicePrincipal -ApplicationObject $spPipelineApplication
$spPipelineCredential = New-AzADServicePrincipalCredential -ServicePrincipalObject $spPipelineServicePrincipal

# Disconnect the user context from the Azure
Disconnect-AzAccount

# Connect to Azure using the SP Manager
$tempCred = New-Object `
    -TypeName System.Management.Automation.PSCredential `
    -ArgumentList ($spManagerServicePrincipal.ApplicationId, $spManagerCredential.Secret)
$spManagerContext = Connect-AzAccount -Credential $tempCred -ServicePrincipal -TenantId $tenantId

# Now connected to Azure AD using Manager SP.

# Create an a new SP to be managed
$spNewPipelineApplication = New-AzADApplication -DisplayName 'New SP for Pipeline' -IdentifierUris 'https://doesnotmatter.newpipeline.seequent.com'
$spNewPipelineServicePrincipal = New-AzADServicePrincipal -ApplicationObject $spNewPipelineApplication
$spNewPipelineCredential = New-AzADServicePrincipalCredential -ServicePrincipalObject $spNewPipelineServicePrincipal


# Clean up
