andrewrothstein.powershell
=========
![Build Status](https://github.com/andrewrothstein/ansible-powershell/actions/workflows/build.yml/badge.svg)

Installs [MSFT PowerShell](https://docs.microsoft.com/en-us/powershell/)

Requirements
------------

See [meta/main.yml](meta/main.yml)

Role Variables
--------------

See [defaults/main.yml](defaults/main.yml)

Dependencies
------------

See [meta/main.yml](meta/main.yml)

Example Playbook
----------------

```yml
- hosts: servers
  roles:
    - andrewrothstein.powershell
```

License
-------

MIT

Author Information
------------------

Andrew Rothstein <andrew.rothstein@gmail.com>
