variable "resource_id" {
  type = "string"
  description = "API Gateway resource ID"
}

variable "rest_api_id" {
  type = "string"
  description = "API Gateway REST API ID"
}

variable methods {
  type = "list"
  description = "Methods to include in the Access-Control-Allow-Methods header in addition to the OPTIONS header. Leave empty to include all types"
  default = [
    "GET",
    "POST",
    "PUT",
    "PATCH",
    "DELETE",
  ]
}

variable "headers" {
  type = "list"
  description = "Headers to include in the Access-Control-Allow-Headers header"
  default = [
    "Content-Type",
    "X-Amz-Date",
    "Authorization",
    "X-Api-Key",
    "X-Amz-Security-Token",
  ]
}