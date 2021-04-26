# azure-sp-management-test

This repo demonstrates the use of an Azure service principal to manage
other service principals.

The `test-sp-management` workflow will:

1. Create a new SP
1. Add a new key for the SP
1. Delete the SP

## Requirements

To test this, the following must be done:

1. An SP in Azure must be created with:

  ```bash
  az ad sp create-for-rbac --name "GitHub SP Management" --sdk-auth
  ```

1. Use the Azure Portal to assign "GitHub SP Management" to the AD
   role `Application administrator`. Note: the assignment could be governed
   by PIM.
1. Create a new secret called `AZURE_CREDENTIAL` in the GitHub repo
   in an environment called `Azure Demo` containing the JSON returned
   in previous step.
