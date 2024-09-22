#Samba :
#/etc/samba/smb.conf

workgroup = WORKGROUP
wins support = yes

[PiShare]
 comment=Raspberry Pi Share
 path=/home/pi/share
 browseable=Yes
 writeable=Yes
 only guest=no
 create mask=0777
 directory mask=0777
 public=no

 ______________________________________________________________
