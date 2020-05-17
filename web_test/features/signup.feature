Feature: Sign up On Amazon Website
 This scenario1 will only work if automationtest not detected by amazon automation system,
 therefore the test will be broke if amazon pop captcha in the middle of steps

Background: User on Amazon Main Page
 Given User at amazon.com page
 When User click sign up button
 Then User at sign up page

@scenario1
Scenario: User able to fill sign up fields on amazon
 When User fill all mandatory field
 And User click Create your amazon button
 Then User redirect to verify email address page


@scenario2
Scenario: User not able to sign up because password is not match
 When User fill all field but mismatch the password
 And User click Create your amazon button
 Then User see password not match alert
