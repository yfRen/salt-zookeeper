zookeeper:
  {% if grains['fqdn'] == 'master' %}
  MY_ID: 1
  {% elif grains['fqdn'] == 'slave1' %}
  MY_ID: 2
  {% elif grains['fqdn'] == 'slave2' %}
  MY_ID: 3
  {% endif %}
  ZK_ID_1: 1
  ZK_ID_2: 2
  ZK_ID_3: 3
  ZK_NODE1: 192.168.200.6:2888:3888
  ZK_NODE2: 192.168.200.7:2888:3888
  ZK_NODE3: 192.168.200.8:2888:3888
