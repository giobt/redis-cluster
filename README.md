Redis Replication with Chef and AWS Cloudformation
=======================================

Overview
-------------
This repository contains a **Chef** cookbook that installs **redis-server** and configures a master-slave replication in one AWS EC2 instance, from a **Cloudformation** script using **Opsworks**.
> **Documents:**
>
> - **cloudform.yml**: infrastructure as code script that initializes an Opsworks stack to use Chef 12 in AWS.
> - **redis**: Chef cookbook that installs redis and configures the master-slave replication.
> - **redis/recipes/default.rb**: Chef recipe that installs redis and configures the master node.
> - **redis/recipes/config_slaves.rb**: Chef recipe that configures the slave nodes.
> - **redis/attributes/default.rb**: Default attributes for redis installation.
> - **redis/templates/default/redis.conf.erb**: Redis configuration file template


----------

Usage
-------------

All you need to run this project is run the ``cloudform.yml`` script in AWS Cloudformation. This must be performed by an IAM user with the following permissions:
> **AWS Permissions needed:**
>
> "sqs:*",
> "cloudformation:*",
> "s3:*",
> "ec2:*",
> "opsworks:*",
> "iam:GetRolePolicy",
> "iam:ListRoles",
> "iam:ListInstanceProfiles",
> "iam:PassRole",
> "iam:ListUsers"
----------
The roles `ServiceRole` and `InstanceRole` are created automatically after using Opsworks for the first time.

Notes
--------
The OS of the EC2 instance is configured to be `Ubuntu 16.04 LTS`, and the instance type is set to `m1.small`.
The Opsworks security group must have the port range `[6379, 6382]` opened so the nodes can talk to each other.
