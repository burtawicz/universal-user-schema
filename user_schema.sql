create schema user_s;

-- ensure uuid-ossp extension is created for 'uuid_generate_v4()' function
create extension if not exists "uuid-ossp";

-- create 'generate_edited_at_on_update()' function for the schema
create or replace function user_s.generate_edited_at_on_update()
    returns trigger as
$$
begin
    new.edited_at = now();
    return new;
end;
$$ language plpgsql;


-- create user_role table
-- represents a user's role within the system
create table user_s.user_role
(
    id          serial       not null primary key,
    name        varchar(255) not null
        constraint user_role_name_uidx unique,
    description text,
    created_at  timestamp    not null default now(),
    edited_at   timestamp    not null default now(),
    deleted_at  timestamp
);

-- create trigger on user_role table to execute the 'generate_edited_at_on_update()' function
create trigger user_role_set_timestamp_trig
    before update
    on user_s.user_role
    for each row
execute procedure user_s.generate_edited_at_on_update();

-- insert common user roles into the system
insert into user_s.user_role (name, description)
values ('Administrator', 'An internal-user with access to everything.'),
       ('Manager', 'An internal-user with access to everything that is non-destructive.'),
       ('Staff', 'An internal-user with access to basic services.');


-- create user_account_type table
-- represents a type of user account
create table user_s.user_account_type
(
    id          serial       not null primary key,
    name        varchar(255) not null
        constraint user_account_type_name_uidx unique,
    description text,
    created_at  timestamp    not null default now(),
    edited_at   timestamp    not null default now(),
    deleted_at  timestamp
);

-- create trigger on user_account_type table to execute the 'generate_edited_at_on_update()' function
create trigger user_account_type_set_timestamp_trig
    before update
    on user_s.user_account_type
    for each row
execute procedure user_s.generate_edited_at_on_update();

-- insert basic account types into store
insert into user_s.user_account_type (name, description)
values ('Employee', 'An employee of the organization.'),
       ('Customer', 'A customer of the organization.');


-- create user_account table
-- represents a single user
create table user_s.user_account
(
    id         serial    not null primary key,
    public_id  uuid      not null default uuid_generate_v4(),
    type_id    int       not null
        constraint user_account_type_id_fk references user_s.user_account_type (id),
    is_active  boolean   not null default false,
    created_at timestamp not null default now(),
    edited_at  timestamp not null default now(),
    deleted_at timestamp
);

-- create trigger on user_account table to execute the 'generate_edited_at_on_update()' function
create trigger user_account_set_timestamp_trig
    before update
    on user_s.user_account
    for each row
execute procedure user_s.generate_edited_at_on_update();


create table user_s.user_activation_token
(
    id           serial    not null primary key,
    token        text      not null
        constraint user_activation_token_uidx unique,
    activated_at timestamp,
    created_at   timestamp not null default now(),
    edited_at    timestamp not null default now(),
    deleted_at   timestamp
);

-- create user_profile table
-- represents all of the data associated with a user
create table user_s.user_profile
(
    id                 int       not null primary key
        constraint user_profile_user_account_id_fk references user_s.user_account (id),
    first_name         varchar(255) not null,
    last_name          varchar(255) not null,
    date_of_birth      date         not null,
    additional_details json,
    created_at         timestamp    not null default now(),
    edited_at          timestamp    not null default now(),
    deleted_at         timestamp
);

-- create trigger on user_profile table to execute the 'generate_edited_at_on_update()' function
create trigger user_profile_set_timestamp_trig
    before update
    on user_s.user_profile
    for each row
execute procedure user_s.generate_edited_at_on_update();


-- create user_credential_type
create type user_s.user_credential_type as enum ('EMAIL', 'PHONE', 'USERNAME', 'UUID');


-- create user_credential table
-- represents a set of credentials associated with a user account
create table user_s.user_credential
(
    id                serial                      not null primary key,
    user_id           int                         not null
        constraint user_credential_user_account_id_fk references user_s.user_account (id),
    type              user_s.user_credential_type not null default 'EMAIL',
    password_hash     text                        not null,
    password_salt     text,
    hashing_algorithm varchar(100)                not null default 'BCRYPT',
    created_at        timestamp                   not null default now(),
    edited_at         timestamp                   not null default now(),
    deleted_at        timestamp
);

-- create trigger on user_credential table to execute the 'generate_edited_at_on_update()' function
create trigger user_credential_set_timestamp_trig
    before update
    on user_s.user_credential
    for each row
execute procedure user_s.generate_edited_at_on_update();



-- create user_identity_provider table
-- represents a single user identity provider like Google, Apple, or Facebook
create table user_s.user_identity_provider
(
    id         serial       not null primary key,
    name       varchar(255) not null
        constraint user_identity_provider_name_uidx unique,
    details    json,
    created_at timestamp    not null default now(),
    edited_at  timestamp    not null default now(),
    deleted_at timestamp
);

-- create trigger on user_identity_provider table to execute the 'generate_edited_at_on_update()' function
create trigger user_identity_provider_set_timestamp_trig
    before update
    on user_s.user_identity_provider
    for each row
execute procedure user_s.generate_edited_at_on_update();


-- create user_identity table
-- represents a social identity associated with a user account
create table user_s.user_identity
(
    id          serial    not null primary key,
    user_id     int       not null
        constraint user_identity_user_account_id_fk references user_s.user_account (id),
    provider_id int       not null
        constraint user_identity_provider_id_fk references user_s.user_identity_provider (id),
    external_id text      not null,
    token       text      not null,
    created_at  timestamp not null default now(),
    edited_at   timestamp not null default now(),
    deleted_at  timestamp
);

-- create trigger on user_identity table to execute the 'generate_edited_at_on_update()' function
create trigger user_identity_set_timestamp_trig
    before update
    on user_s.user_identity
    for each row
execute procedure user_s.generate_edited_at_on_update();


