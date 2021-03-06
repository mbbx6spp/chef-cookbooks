name "postgresql"
version "0.1.0"
maintainer "Susan Potter"
maintainer_email "me@susanpotter.net"
license "BSD3"
description "Recipes to install PostgreSQL"
recipe "postgresql::repo", "Installation of PostgreSQL 9.0 YUM repository"
recipe "postgresql::server", "Server installation of PostgreSQL"
recipe "postgresql::client", "Client installation of PostgreSQL"
recipe "postgresql::odbc", "ODBC support for PostgreSQL"
