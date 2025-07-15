OpenStack Volume Role
====================

This role creates and manages OpenStack block storage volumes (Cinder) using Ansible. It supports provisioning, attaching, and managing volumes for OpenStack instances.

Requirements
------------

- Ansible 2.9+
- Python 3.6+
- OpenStack cloud credentials
- openstack.cloud collection

Role Variables
-------------

- `cloud`: OpenStack cloud name
- `project_name`: OpenStack project name
- `volumes`: List of volume definitions

Example `volumes` variable:

```yaml
volumes:
  - name: data-volume-1
    size: 10
    description: Data volume for app
    state: present
```

Dependencies
------------

- alwynpan.openstack.openstack_common

Example Playbook
----------------

```yaml
- hosts: localhost
  vars:
    cloud: mycloud
    project_name: myproject
    volumes:
      - name: data-volume-1
        size: 10
        description: Data volume for app
        state: present
  roles:
    - alwynpan.openstack.openstack_volume
```

License
-------

MIT

Author Information
------------------

Alwyn Pan <geminean@msn.com>
