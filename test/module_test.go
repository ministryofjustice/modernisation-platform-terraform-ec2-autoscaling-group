package test

import (
	"regexp"
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

func TestModule(t *testing.T) {
	t.Parallel()

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "./unit-test",
	})


	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	secGroupId := terraform.Output(t, terraformOptions, "securtiy-group-id")
	keyPair := terraform.Output(t, terraformOptions, "key-pair")
	iamPolicy := terraform.Output(t, terraformOptions, "iam-policy")
	amiName := terraform.Output(t, terraformOptions, "ami-name")
	kmsKey := terraform.Output(t, terraformOptions, "kms-key")


	assert.NotEmpty(t, secGroupId)
    assert.Regexp(t, regexp.MustCompile(`^arn:aws:ec2:eu-west-2:836052629367:key-pair/ec2-user:*`), keyPair)
    assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam:*`), iamPolicy)
    assert.Regexp(t, regexp.MustCompile(`^RHEL-7.9_HVM-*`), amiName)
    assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam::836052629367:policy/ec2-common-policy*`), kmsKey)


}