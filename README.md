# Azure DevOps Private Network Integration

## The problem

Self-hosted agent on Azure virtual machine should not have any public IP associated, meanwhile be able to pull
queued jobs from Azure DevOps cloud instance.

One of the solutions is to utilize Azure NAT gateway that allows to filter traffic based on CIDR blocks,
however this solution has its pros: agent installation requires to NAT to allow Akamai CDN CIDRs which
are not really consistent, so that better solution is to utilize the Azure Firewall, which allows
to filter traffic based on DNS records instead of CIDR blocks.

NAT approach requires manual adjustments time to time.

## Docs

- https://learn.microsoft.com/en-us/azure/nat-gateway/nat-overview
- https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway
- Public cloud CIDRs: https://www.microsoft.com/en-us/download/details.aspx?id=56519
- https://github.com/microsoft/azure-pipelines-agent/releases
