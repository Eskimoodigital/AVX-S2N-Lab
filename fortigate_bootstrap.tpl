#config-version=FGTAWS-6.2.3-FW-build1066-200327:opmode=0:vdom=0:user=admin
#conf_file_ver=187393718135403
#buildno=8404
#global_vdom=1
config system global
    set hostname "${name}"
    set timezone 04
    set admintimeout 60
end

config system admin
    edit "admin"
        set accprofile "super_admin"
        set vdom "root"
        set password "${password}"
    next
end
