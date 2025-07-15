OpenStack Network Role
=====================

This role creates and manages OpenStack networks, subnets, and optionally ports and routers. It is designed to automate network provisioning for OpenStack-based clouds.

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
- `networks`: List of network definitions, each with subnets and optional ports

Example `networks` variable:

```yaml
networks:
  - network_name: my-net
    subnets:
      - name: my-subnet
        cidr: 192.168.10.0/24
        gateway_ip: 192.168.10.1
    ports:
      - name: my-port
        network: my-net
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
    networks:
      - network_name: my-net
        subnets:
          - name: my-subnet
            cidr: 192.168.10.0/24
            gateway_ip: 192.168.10.1
  roles:
    - alwynpan.openstack.openstack_network
```

License
-------

MIT

Author Information
------------------

Alwyn Pan <geminean@msn.com>
