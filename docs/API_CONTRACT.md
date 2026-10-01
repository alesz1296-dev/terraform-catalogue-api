# API Contract

This document defines the first version of the Terraform Catalogue API.

The API starts as public and read-only for this version. Write endpoints, authentication, and admin workflows are intentionally deferred.

## Version 1 Endpoints

```text
GET /modules
GET /modules/{id}
```

## Response Style

List responses use an object wrapper instead of returning a raw array.

Chosen shape:

```json
{
  "count": 1,
  "modules": []
}
```

Reason:

- Allows metadata such as `count`.
- Keeps room for future fields like pagination.
- Avoids breaking the response shape later.

## Module Data Model

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

## Field Definitions

`module_id`

Unique identifier for the module. Used as the DynamoDB partition key and in `GET /modules/{id}`.

`name`

Human-readable module name.

`project`

Portfolio project where the module or pattern is used.

`iac_tool`

Infrastructure as Code tool used by the module, such as Terraform.

`category`

High-level grouping, such as `Storage`, `Serverless`, `Networking`, or `Security`.

`difficulty`

Beginner-oriented difficulty level, such as `Beginner`, `Intermediate`, or `Advanced`.

`aws_services`

AWS services involved in the module.

`service_features`

Infrastructure capabilities implemented by the module.

`use_cases`

Scenarios where this module or pattern is useful.

`description`

Short summary of what the module does.

`status`

Current state of the module, such as `Planned`, `In Progress`, or `Published`.

## GET /modules

Returns all module records.

Example response:

```json
{
  "count": 1,
  "modules": [
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
  ]
}
```

Success status:

```text
200 OK
```

## GET /modules/{id}

Returns one module by `module_id`.

Example request:

```text
GET /modules/s3-static-site
```

Example response:

```json
{
  "module": {
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
}
```

Success status:

```text
200 OK
```

## Error Response

If a module is not found:

```json
{
  "error": {
    "code": "MODULE_NOT_FOUND",
    "message": "Module not found."
  }
}
```

Status:

```text
404 Not Found
```

## Deferred Fields

These fields are intentionally deferred until the core API works:

- `github_url`
- `docs_url`
- `diagram_url`
- `estimated_monthly_cost`
- `tags`
- `version`
- `dependencies`
- `created_at`
- `updated_at`
