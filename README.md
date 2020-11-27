# Universal User Schema

A collection of evolving definitions of a universal user entity.

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
