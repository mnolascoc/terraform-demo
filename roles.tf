resource "aws_iam_service_linked_role" "opensearch_role" {
  aws_service_name = "opensearchservice.amazonaws.com"
}

/*resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
  description      = "Allows Amazon ES to manage AWS resources for a domain on your behalf."
}*/
