tail -3 /var/log/syslog >>/mediastream/recolecta_info.log
df -h -x devtmpfs -x tmpfs |grep md0 >>/mediastream/recolecta_info.log
md5sum /var/log/auth.log >>/mediastream/recolecta_info.log
