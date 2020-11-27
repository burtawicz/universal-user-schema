# Universal User Schema


## What is this?
A collection of evolving definitions that describe a generic and reusable user schema for systems that require authentication and authorization.


## Why does this exist?
Over the course of my career I've built and worked on a significant number of systems spread across a variety of industries that require user authentication. While each system may be unique in architecture and in purpose, the user authentication and authorization aspects have only minor variations.

In short, I'm tired of repeatedly building the same thing. So to save myself (and hopefully others) time, I've generified it for easy reuse.


## Index
1. [Models](#models)
    * [User Account Type](#user-account-type)
    * [User Role](#user-role)
    * [User Account](#user-account)
    * [User Profile](#user-profile)
    * [User Activation Token](#user-activation-token)
    * [User Identity Provider](#user-indentity-provider)
    * [User Identity](#user-identity)
    * [User Credential](#user-credential)
    * [User Login](#user-login)
1. [Contributing](#contributing)
1. [License](#license)

## Models

### User Role
Represents the user's role in the system.
This is optional for systems that do not support role-based classification.

### User Account Type
Represents the type of account the user has, typically 'Employee' or 'Customer'.

### User Account
Represents a single user who accesses the system.

### User Profile
Represents a collection of details associated to the user.

### User Activation Token
Represents a token, typically distributed through an email, that when activated verifies the user intended to create the account.

### User Identity Provider
Represents a social identity provider (Google, Apple, Facebook, etc) that is registered within the system to authenticate a user's identity.
This is optional for systems that do not use identity-based authentication.

### User Identity
Represents a social identity that the user will authenticate themselves with.
This is optional for systems that do not use identity-based authentication.

### User Credential
Represents a set of credentials that the user will authenticate themselves with.

### User Login
Represents a login attempt by a user.


## Contributing
If you're interested in contributing to this project, please read through the contribution guide found [here](https://github.com/burtawicz/universal-user-schema/blob/master/CONTRIBUTING.md).

## License
This project is licensed under the [MIT license](https://github.com/burtawicz/universal-user-schema/blob/master/LICENSE.txt). 

