OpenStack Common Role
====================

This role sets up the local environment and common prerequisites for working with OpenStack using Ansible. It ensures required collections and dependencies are present for other OpenStack automation roles.

Requirements
------------

- Ansible 2.9+
- Python 3.6+
- Access to OpenStack cloud credentials

Role Variables
--------------

This role does not require any variables by default. You may override variables as needed in your playbooks or inventory.

Dependencies
------------

- community.general collection (installed by this role)

Example Playbook
----------------

```yaml
- hosts: localhost
  roles:
    - alwynpan.openstack.openstack_common
```

License
-------

MIT

Author Information
------------------

Alwyn Pan <geminean@msn.com>
