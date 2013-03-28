# Interested in iOS development, CloudBees and Jenkins?

Then this is for you!


Running this ClickStart will setup (in CloudBees) an iOS starter-project, private source repo, a Jenkins build
and a CouchDB based backend service.

Intended to be used as a minimal "seed" for common database backed iOS apps, and show how iOS builds/tests can work with Jenkins.
You don't have to use all of it, just press the button, get your own version of it going, and go from there.

# Press the button to deploy now

<a href="https://grandcentral.cloudbees.com/?CB_clickstart=https://raw.github.com/michaelneale/ios-clickstart/master/clickstart.json"><img src="https://d3ko533tu1ozfq.cloudfront.net/clickstart/deployInstantly.png"/></a>

Once it is running - it will tell you what to do next to make it your own.

<img src="https://raw.github.com/michaelneale/ios-clickstart/master/server-app/public/images/screenshot.png">


# Running locally

Clone this repo - open in xcode.

Tip: to run unit tests locally, by hand, outside of the IDE:
<code>
xcodebuild -target ios-clickstartLogicTests -sdk iphonesimulator -configuration Debug TEST_AFTER_BUILD=YES clean build
</code>


