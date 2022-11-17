# Project setup
## Cocoa Pods
* Install Cocoa Pods
* cd /(Podfile dir)
* run pod install
* open .xcworkspace

## Connect yours MongoDB Atlas
* Create a project in atlas
* Create an app service [More here](https://www.mongodb.com/docs/atlas/app-services/manage-apps/create/create-with-ui/)
* Enable device sync [More here](https://www.mongodb.com/docs/atlas/app-services/sync/)
* Enable email-password authentication provider [More here](https://www.mongodb.com/docs/atlas/app-services/authentication/email-password/#std-label-email-password-authentication)
* In ***RealmGateway.swift*** change ***private let appId*** to yours

## Another gateway
* Create a custom gateway protocols implementation classes
* In ***AppDelegate.swift*** change ***private let gateway*** to your implementation