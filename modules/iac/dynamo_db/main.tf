resource "aws_dynamodb_table" "finance_progress" {
  name           = "finance_progress"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "FinanceProgressTable"
    Environment = "Production"
  }
}