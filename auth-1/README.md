# Authorization demo

## Description

This project demonstrates how Hasura's authorization system can be used in situation
where the information related to user roles and permission allowed for each of
those roles are stored in the database itself.

## Running the project

1. Run `docker compose up -d`
2. Run -
  ```
  hasura metadata apply
  hasura migrate apply --all-databases
  hasura metadata reload
  ```
3. Go to the endpoint <http://localhost:8080/console>

## Setup

This project is setup as follows. This project contains the following tables -
1. `permission` - An enum table of all the permissions possible in the application.
  The following permissions are possible in this application:
    1. `read` - read rows from the resource table
    2. `write` - write or update a row to the resource table
    3. `delete` - delete a row from the resource table 
2. `role` - An enum table of all the roles possible in the application. The following
  roles are possible in this application:
    1. `reader` - has `read` permission
    2. `writer` - has `write` permission
    3. `admin` - has `read`, `write` and `delete` permission
3. `role_permission_mapping` - A table representing the permissions that each role
  can have. The permissions are mapped as explained in (2).
4. `user` - A table that contains all the users of the applications and their
  corresponding role.
5. `resource` - A table denoting a 'resource' access to which is to be controlled
  through permissions

## Testing

2 session variables are required in each request -
1. `x-hasura-role` - containing the Hasura role. Since roles are checked from the
  database, there is only one Hasura role which is `user`
2. `x-hasura-user-id` - id of the user making the request

Test the following queries -

1. `GetResource` operation. Only users with role that has `read` permission should
  be able to execute this. By default, only `reader` and `admin` role has that permission
  in this project which by default is only available for user id `1` and `3`. Therefore
  by default the request should succeed when `x-hasura-user-id` is either `1` or `3` and should fail
  otherwise.
  ```
  query GetResource {
    resource {
      id
      val
    }
  }
  ```

2. `InsertResource` operation. Only users with role that has `write` permission should
  be able to execute this. By default, only `writer` and `admin` role has that permission
  in this project which by default is only available for user id `2` and `3`. Therefore
  by default the request should succeed when `x-hasura-user-id` is either `2` or `3` and
  should fail otherwise.
  ```
  mutation InsertResource {
    insert_resource_one(object: {}) {
      id
      val
    }
  }
  ```

3. `DeleteResource` operation. Only users with role that has `delete` permission should
  be able to execute this. By default, only `admin` role has that permission which by
  default is only available for user id `3`. Therefore by default the request should
  succeed when `x-hasura-user-id` is `3` and must fail otherwise.
  ```
  mutation DeleteResource {
    delete_resource_by_pk(id: 6) {
      id
      val
    }
  }
  ```

Try adding new users different roles, adding new roles with different permission mapping etc.
and see that the logic still holds.

Note: Adding a new permission will require modifying the
authorization logic to accomodate that permission.
