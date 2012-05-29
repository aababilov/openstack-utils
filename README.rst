Diablo installation guide
-------------------------

We assume that no openstack is installed.

Place sql scripts to a directory and populate the databases
(all will reside in mysql).

WARNING: existing  databases will be overwritten!

::
    openstack-pkg install diablo
    openstack-db populate <path-to-dir>


For each service (nova, glance, keystone), openstack-db will execute
(in althabetical order) scripts from the given directory that start
from service's name. You can name the scripts nova-0.sql,
nova-1.sql, etc. to control execution order.

Now proceed to Setting up openstack.


Migrate from diablo to essex
----------------------------

Stop openstack daemons, erase packages, and purge etc:

::
    openstack-daemons stop
    openstack-pkg erase
    openstack-etc purge

Install essex:

::
    openstack-pkg install essex

Check that you have /usr/bin/nova (it belongs to novaclient). If not, please look for it and
install it manually.

Migrate the databases. nova and glance will be updated, keystone moved
to keystoneold and rewritten. nova migration usually takes long time (minutes).

::
    openstack-db migrate

Now proceed to Setting up openstack.


Setting up openstack
--------------------

Update configuration files:

::
    openstack-etc setup

A new admin token or password will be generated and stored in
configuration files. Save it in keystone database:

::
    openstack-etc keystone_db

Now start openstack and other necessary daemons:

::
    openstack-daemons start all


Verify openstack installation
-----------------------------

Check daemon status:

::
    openstack-daemons status


Setup credential environment variables and list VMs and images:

::
    nova list
    nova image-list

Try to start an instance.

::
    nova boot --flavor 2 --image <image-id> test-instance
