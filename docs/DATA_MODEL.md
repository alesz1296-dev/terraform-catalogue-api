# Data Model

This document defines the DynamoDB data model for version 1 of the Terraform Catalogue API.

## Version 1 Table Design

```yaml
table_name: terraform-catalogue-modules
partition_key: module_id
billing_mode: PAY_PER_REQUEST
list_behavior: Scan for v1
indexes: none for v1
seed_data: manual first, script later
```

## Table Name

```text
terraform-catalogue-modules
```

The table stores Terraform module metadata for the catalogue API.

## Primary Key

Partition key:

```text
module_id
```

There is no sort key in version 1.

Reason:

- Each module has one unique ID.
- `GET /modules/{id}` maps directly to a DynamoDB `GetItem`.
- Version 1 does not need multiple records under the same partition key.

## Item Shape

Example item:

```json
{
  "module_id": "s3-static-site",
  "name": "S3 Static Site",
  "project": "terraform-static-website",
  "iac_tool": "Terraform",
  "category": "Storage",
  "difficulty": "Beginner",
  "aws_services": ["S3", "CloudFront", "IAM"],
  "service_features": [
    "Private S3 bucket",
    "CloudFront distribution",
    "Origin Access Control",
    "S3 bucket policy",
    "Server-side encryption",
    "Versioning"
  ],
  "use_cases": [
    "Static websites",
    "Documentation sites",
    "Portfolio sites",
    "Low-cost frontend hosting"
  ],
  "description": "Private S3 bucket with CloudFront delivery.",
  "status": "Published"
}
```

## Access Patterns

Version 1 supports two access patterns.

### List All Modules

Endpoint:

```text
GET /modules
```

DynamoDB operation:

```text
Scan
```

Reason:

- The catalogue is expected to contain a small number of items.
- Scan keeps the first version simple.
- Filtering and pagination are deferred.

Trade-off:

- Scan reads through the table.
- This is acceptable for a tiny catalogue.
- It is not ideal for large production tables.

### Get One Module By ID

Endpoint:

```text
GET /modules/{id}
```

DynamoDB operation:

```text
GetItem
```

Key:

```text
module_id = {id}
```

Reason:

- Direct lookup by partition key is efficient.
- This matches the API route design.

## Billing Mode

Billing mode:

```text
PAY_PER_REQUEST
```

Reason:

- Traffic is expected to be low and unpredictable.
- No capacity planning is needed for version 1.
- This keeps the project simple and cost-aware.

Trade-off:

- Provisioned capacity may be cheaper for predictable steady traffic.
- Pay-per-request is better for this learning workload.

## Indexes

Version 1 uses no secondary indexes.

Reason:

- The API does not yet support filtering by category, status, difficulty, or project.
- Indexes should be added only when a real access pattern requires them.

Possible future indexes:

```text
category-index
status-index
difficulty-index
project-index
```

## Seed Data

Version 1 will start with manual seed data or a simple seed script later.

Recommended progression:

1. Insert one item manually to understand the DynamoDB console and item shape.
2. Add a small Python seed script for repeatability.

Terraform should create the table, but application data should not be managed by Terraform in the first version.

## Deferred Design Choices

The following are intentionally deferred:

- Sort key
- Global secondary indexes
- Pagination
- Filtering by query parameters
- Full text search
- Versioned module records
- Timestamps
- Terraform-managed DynamoDB items
