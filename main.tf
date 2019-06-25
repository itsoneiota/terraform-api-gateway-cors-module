resource "aws_api_gateway_method" "ResourceOptions" {
  count = "${var.enabled ? 1 : 0}"

  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "ResourceOptionsIntegration" {
  count = "${var.enabled ? 1 : 0}"

  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${join("", aws_api_gateway_method.ResourceOptions.*.http_method)}"
  type = "MOCK"
  request_templates = {
    "application/json" = <<PARAMS
{ "statusCode": 200 }
PARAMS
    "application/x-www-form-urlencoded" = <<PARAMS
{ "statusCode": 200 }
PARAMS
  }
}

resource "aws_api_gateway_integration_response" "ResourceOptionsIntegrationResponse" {
  count = "${var.enabled ? 1 : 0}"

  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${join("", aws_api_gateway_method.ResourceOptions.*.http_method)}"
  status_code = "${join("", aws_api_gateway_method_response.ResourceOptions200.*.status_code)}"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'${join(",", var.headers)}'",
    "method.response.header.Access-Control-Allow-Methods" = "'OPTIONS,${join(",", var.methods)}'",
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  },
  depends_on = [
    "aws_api_gateway_integration.ResourceOptionsIntegration"
  ]
}

resource "aws_api_gateway_method_response" "ResourceOptions200" {
  count = "${var.enabled ? 1 : 0}"

  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${join("", aws_api_gateway_method.ResourceOptions.*.http_method)}"
  status_code = "200"
  response_models = { "application/json" = "Empty" }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin" = true
  }

  depends_on = [
    "aws_api_gateway_integration.ResourceOptionsIntegration"
  ]
}