data "aws_vpc" "shared" {
  tags = {
    "Name" = "${var.networking[0].business-unit}-${local.environment}"
  }
}

data "aws_kms_key" "default_ebs" {
  key_id = "alias/aws/ebs"
}

# combine ec2-common policy documents
data "aws_iam_policy_document" "ec2_test_common_combined" {
  source_policy_documents = [
    data.aws_iam_policy_document.ec2_test_policy.json,
  ]
}

# custom policy for SSM as managed policy AmazonSSMManagedInstanceCore is too permissive
data "aws_iam_policy_document" "ec2_test_policy" {
  statement {
    #checkov:skip=CKV_AWS_109:
    #checkov:skip=CKV_AWS_111:
    #checkov:skip=CKV_AWS_107:
    #checkov:skip=CKV_AWS_356: Skipping, as the policy is used within the unit-test only.

    sid    = "CustomEc2Policy"
    effect = "Allow"
    actions = [
      "ec2:*"
    ]
    resources = ["*"] #tfsec:ignore:aws-iam-no-policy-wildcards
  }
}
