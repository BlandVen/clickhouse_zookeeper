apt-transport-https_ca-certificates_dirmngr:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - dirmngr

apt_key:
  pkgrepo.managed:
    - name: deb https://packages.clickhouse.com/deb stable main
    - file: /etc/apt/sources.list.d/clickhouse.list
    - keyserver: hkp://keyserver.ubuntu.com:80
    - keyid: 8919F6BD2B48D754
    - refresh: True

clickhouse:
  pkg.installed:
    - pkgs:
      - clickhouse-server
      - clickhouse-client

zookeeper:
  pkg.installed

/etc/systemd/system/zookeeper.service:
  file.managed:
    - source: salt://{{ slspath }}/zookeeper.service
    - mode: 644

/etc/zookeeper/conf/zoo.cfg:
  file.managed:
    - source: salt://{{ slspath }}/zoo.cfg
    - mode: 644

/etc/zookeeper/conf/myid:
  file.managed:
    - source: salt://{{ slspath }}/myid
    - mode: 644

zookeeper.service:
  service:
    - running
    - enable: True


/etc/clickhouse-server/config.xml:
  file.managed:
    - source: salt://{{ slspath }}/config.xml
    - user: clickhouse
    - group: clickhouse
    - mode: 400

clickhouse-server:
  service:
    - running
    - enable: True
