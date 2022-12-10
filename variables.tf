
variable "REGION" {
  default = "us-east-1"
}

variable "ACCN" {
  default = "SEN"
}

variable "AMBT" {
  default = "DESA"
}

variable "PJ" {
  default = "POC"
}

variable "ACCOUNT_ID" {
  default = "046863948967"
}

variable "ALL_TAGS" {
  type        = map(any)
  description = "Tags comunes para todos los recursos"
  default = {
    OPEX        = "743"
    ENTORNO     = "NOPROD"
    AMBIENTE    = "DESA",
    CMDB        = "SI",
    PROYECTO    = "SENSORIZACION"
    RESPONSABLE = "HILMER ALIAGA"
  }
}
