This is a work in progress - a clickstart for a full stack iOS app with layers of testing and deployment on CloudBees.


# XCode/iOS build phase:
For the final stage of build an xcode slave is needed, this is enabled by running something like: 

java -jar ~/jenkins_slave/jenkins-cli.jar -s https://michaelnealeclickstart2.ci.cloudbees.com customer-managed-slave -fsroot ~/jenkins_slave/FSROOT -labels xcode -labels android -name mobile-build-slave-xcloudexit



Press the big button to continue:

<a href="https://grandcentral.cloudbees.com/?CB_clickstart=https://raw.github.com/michaelneale/ios-clickstart/master/clickstart.json"><img src="https://d3ko533tu1ozfq.cloudfront.net/clickstart/deployInstantly.png"/></a>

