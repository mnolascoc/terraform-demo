locals {
  region    = var.REGION
  n_zona_fc = element(regex("(^[a-z])", element(split("-", var.REGION), 0)), 0)
  n_zona_sc = element(regex("(^[a-z])", element(split("-", var.REGION), 1)), 0)
  n_zona_tc = element(split("-", "us-east-1"), 2)
  rg_name   = "${local.n_zona_fc}${local.n_zona_sc}${local.n_zona_tc}"
}

#######################################IAM POLICY########################################################
module "policy_004" {
  source = "./terraform-aws-aws_iam-master/submodules/iam-policy"
  name   = upper("${local.rg_name}${var.ACCN}${var.AMBT}SEGPOL${var.PJ}004")
  path   = "/"
  policy = file("./policy/sns_001.json")
  tags   = var.ALL_TAGS
}

#######################################IAM ROLE########################################################
module "rol_opensearch" {
  source                  = "./terraform-aws-aws_iam-master/submodules/iam-assumable-role"
  role_name               = upper("${local.rg_name}${var.ACCN}${var.AMBT}SEGROL${var.PJ}004")
  create_role             = true
  role_requires_mfa       = false
  custom_role_policy_arns = [module.policy_004.arn]
  trusted_role_services   = ["es.amazonaws.com"]
  trusted_role_actions    = ["sts:AssumeRole"]
  tags                    = var.ALL_TAGS
}

#######################################SNS TOPIC#########################################################
resource "aws_sns_topic" "sns_pse_001" {
  name = upper("${local.rg_name}${var.ACCN}${var.AMBT}APISNS${var.PJ}001")
  tags = var.ALL_TAGS
}

#######################################OPENSEARCH##################################################
/*resource "aws_security_group" "sg_pse_001" {
  name        = upper("${local.rg_name}${var.ACCN}${var.AMBT}COMSGP${var.PJ}001")
  description = "permite trafico HTTP/HTTPS"
  vpc_id      = "vpc-04defcc3ade74f05f"
  ingress = [
    {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    },
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [
    {
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}


resource "aws_opensearch_domain" "os_pse_002" {
  domain_name    = lower("${local.rg_name}${var.ACCN}${var.AMBT}ANLAES${var.PJ}002")
  engine_version = "OpenSearch_2.3"

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  }

  cluster_config {
    dedicated_master_enabled = false
    instance_type            = "t3.medium.search"
    instance_count           = 2
    warm_enabled             = false
    zone_awareness_enabled   = true
    zone_awareness_config {
      availability_zone_count = 2
    }
  }
  vpc_options {
    subnet_ids = [
      "subnet-01324da08a8a20c2c", "subnet-078ad3cb373591521"
    ]
    security_group_ids = [aws_security_group.sg_pse_001.id]
  }
  ebs_options {
    ebs_enabled = true
    volume_type = "gp3"
    volume_size = 10
  }
  encrypt_at_rest {
    enabled = false
  }

  access_policies = templatefile("./policy_opensearch/opensearch.json", {
    account_id  = var.ACCOUNT_ID
    domain_name = lower("${local.rg_name}${var.ACCN}${var.AMBT}ANLAES${var.PJ}001")
  })
  tags       = var.ALL_TAGS
  depends_on = [aws_iam_service_linked_role.opensearch_role]
}*/
