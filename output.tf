output "rol_opensearch" {
  value = module.rol_opensearch.iam_role_arn
}

output "sns" {
  value = join("", aws_sns_topic.sns_pse_001.*.arn)
}

/*output "opensearch_endpoint" {
  value = aws_opensearch_domain.os_pse_002.kibana_endpoint
}
*/
