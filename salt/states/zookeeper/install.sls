zookeeper_repo_install:
  cmd.run:
    - name: yum -y install http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm
    - unless: test -f /etc/yum.repos.d/mesosphere.repo

zookeeper_install:
  pkg.installed:
    - name: mesosphere-zookeeper
    - require:
      - cmd: zookeeper_repo_install

zookeeper_config:
  file.managed:
    - name: /etc/zookeeper/conf/zoo.cfg
    - source: salt://zookeeper/files/zoo.cfg
    - template: jinja
    - defaults:
      ZK_ID_1: {{ pillar['zookeeper']['ZK_ID_1'] }}
      ZK_ID_2: {{ pillar['zookeeper']['ZK_ID_2'] }}
      ZK_ID_3: {{ pillar['zookeeper']['ZK_ID_3'] }}
      ZK_NODE1: {{ pillar['zookeeper']['ZK_NODE1'] }}
      ZK_NODE2: {{ pillar['zookeeper']['ZK_NODE2'] }}
      ZK_NODE3: {{ pillar['zookeeper']['ZK_NODE3'] }}
    - require:
      - pkg: zookeeper_install

zookeeper_myid:
  file.managed:
    - name: /var/lib/zookeeper/myid
    - source: salt://zookeeper/files/myid
    - template: jinja
    - defaults:
      MY_ID: {{ pillar['zookeeper']['MY_ID'] }}
    - require:
      - file: zookeeper_config

zookeeper_running:
  service.running:
    - name: zookeeper
    - enable: True
    - unless: netstat -anpt | grep 2181
    - require:
      - file: zookeeper_myid
