package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"regexp"
	"testing"
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
	autoscaling_group_name := terraform.Output(t, terraformOptions, "autoscaling_group_name")

	assert.NotEmpty(t, secGroupId)
	assert.Regexp(t, regexp.MustCompile(`^arn:aws:ec2:eu-west-2:836052629367:key-pair/*`), keyPair)
	assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam:*`), iamPolicy)
	assert.Regexp(t, regexp.MustCompile(`^RHEL-7.9_HVM-*`), amiName)
	assert.Regexp(t, regexp.MustCompile(`^arn:aws:iam::836052629367:policy/*`), kmsKey)
	assert.Regexp(t, regexp.MustCompile(`^dev-redhat-rhel610`), autoscaling_group_name)

}
