#!/usr/bin/env python3

import subprocess

class A:
    pass

class C:
    __DEF_QUEUE__= [
        "--disable-systemd",
        "--disable-dynamic-linking",
        "--prefix=/usr",
        "--exec-prefix=/usr",
        "--bindir=/usr/bin",
        "--sbindir=/usr/sbin",
        "--sysconfdir=/etc",
        "--datadir=/usr/share",
        "--localstatedir=/var",
        "--mandir=/usr/share/man",
    ]

    __QUEUE__ = [
        "./configure",
    ] + __DEF_QUEUE__

    __ENABLE_DBUS__              = 0
    __DISABLE_IPSET__            = 0
    __DISABLE_IPTABLES__         = 0
    __DISABLE_NFTABLES__         = 0
    __ENABLE_SNMP_VRRP__         = 0
    __ENABLE_REGEX__             = 0
    __ENABLE_REGEX_TIMERS__      = 0
    __ENABLE_JSON__              = 0
    __DISABLE_LVS__              = 0
    __DISABLE_VRRP__             = 0
    __DISABLE_VRRP_AUTH__        = 0
    __ENABLE_BFD__               = 0
    __DISABLE_VMAC__             = 0
    __ENABLE_LTO__               = 0
    __DISABLE_CHECKSUM_COMPACT__ = 0
    __DISABLE_ROUTES__           = 0
    __DISABLE_LINKBEAT__         = 0
    __ENABLE_SOCK_STORAGE__      = 0
    __DISABLE_FWMARK__           = 0
    __DISABLE_TRACK_PROCESS__    = 0
    __ENABLE_MEM_CHECK__         = 0
    __ENABLE_DEBUG__             = 0
    __ENABLE_SNMP_ALERT_DEBUG__  = 0
    __ENABLE_EPOLL_DEBUG__       = 0
    __ENABLE_VRRP_FD_DEBUG__     = 0
    __ENABLE_RECVMSG_DEBUG__     = 0
    __ENABLE_EINTR_DEBUG__       = 0
    __ENABLE_PARSER_DEBUG__      = 0
    __ENABLE_CHECKSUM_DEBUG__    = 0
    __ENABLE_CHECKER_DEBUG__     = 0
    __ENABLE_MEM_ERR_DEBUG__     = 0
    __ENABLE_SCRIPT_DEBUG__      = 0

    __cli_desc__ = "docker-keepalived-configurer"
    __cli_args__= A()
    __cli_mapping__ = [
        # we only do a mapping with some relations, we don't want to substitute `configure.ac`.
        # argument                     dest                        type     default                       help                          related arguments
        ('--enable-dbus',              'enable_dbus',              int,     __ENABLE_DBUS__,              'Compile with dbus support.', []),
        ('--disable-libipset',         'disable_libipset',         int,     __DISABLE_IPSET__,            'Compile without libipset.', []),
        ('--disable-iptables',         'disable_iptables',         int,     __DISABLE_IPTABLES__,         'Compile without iptables support.', []),
        ('--disable-nftables',         'disable_nftables',         int,     __DISABLE_NFTABLES__,         'Build without nftables support.', []),
        ('--enable-snmp-vrrp',         'enable_snmp_vrrp',         int,     __ENABLE_SNMP_VRRP__,         'Compile with SNMP vrrp support.', ['--enable-snmp-rfc']),
        ('--enable-regex',             'enable_regex',             int,     __ENABLE_REGEX__,             'Build with HTTP_GET regex checking.', []),
        ('--enable-regex-timers',      'enable_regex_timers',      int,     __ENABLE_REGEX_TIMERS__,      'Build with HTTP_GET regex timers.', []),
        ('--enable-json',              'enable_json',              int,     __ENABLE_JSON__,              'Compile with signal to dump configuration and stats as json.', []),
        ('--disable-lvs',              'disable_lvs',              int,     __DISABLE_LVS__,              'Do not use the LVS framework.', []),
        ('--disable-vrrp',             'disable_vrrp',             int,     __DISABLE_VRRP__,             'Do not use the VRRP framework.', []),
        ('--disable-vrrp-auth',        'disable_vrrp_auth',        int,     __DISABLE_VRRP_AUTH__,        'Compile without VRRP authentication.', []),
        ('--enable-bfd',               'enable_bfd',               int,     __ENABLE_BFD__,               'Use the BFD framework.', []),
        ('--disable-vmac',             'disable_vmac',             int,     __DISABLE_VMAC__,             'Compile without VMAC support.', []),
        ('--enable-lto',               'enable_lto',               int,     __ENABLE_LTO__,               'Use Link Time Optimisation.', []),
        ('--disable-checksum-compact', 'disable_checksum_compact', int,     __DISABLE_CHECKSUM_COMPACT__, 'Compile without v1.3.6 and earlier VRRPv3 unicast checksum compatibility', []),
        ('--disable-routes',           'disable_routes',           int,     __DISABLE_ROUTES__,           'Compile without ip rules/routes.', []),
        ('--disable-linkbeat',         'disable_linkbeat',         int,     __DISABLE_LINKBEAT__,         'Compile without linkbeat support.', []),
        ('--enable-sock-storage',      'enable_sock_storage',      int,     __ENABLE_SOCK_STORAGE__,      'Compile using sockaddr_storage rather than smaller sockaddr for IPv4/6 only', []),
        ('--disable-fwmark',           'disable_fwmark',           int,     __DISABLE_FWMARK__,           'Compile without SO_MARK support.', []),
        ('--disable-track-process',    'disable_track_process',    int,     __DISABLE_TRACK_PROCESS__,    'Build without track-process functionality.', []),
        ('--enable-mem-check',         'enable_mem_check',         int,     __ENABLE_MEM_CHECK__,         'Compile with memory alloc checking - e.g. no writes before or after buffer, everything allocated is freed', ['--enable-mem-check-log']),
        ('--enable-debug',             'enable_debug',             int,     __ENABLE_DEBUG__,             'Compile with most debugging options.', []),
        ('--enable-snmp-alert-debug',  'enable_snmp_alert_debug',  int,     __ENABLE_SNMP_ALERT_DEBUG__,  'Compile with smtp-alert debugging.', []),
        ('--enable-epoll-debug',       'enable_epoll_debug',       int,     __ENABLE_EPOLL_DEBUG__,       'Compile with epoll_wait() debugging support.', []),
        ('--enable-vrrp-fd-debug',     'enable_vrrp_fd_debug',     int,     __ENABLE_VRRP_FD_DEBUG__,     'Compile with vrrp fd debugging support.', []),
        ('--enable-recvmsg-debug',     'enable_recvmsg_debug',     int,     __ENABLE_RECVMSG_DEBUG__,     'Compile with recvmsg() debugging support.', []),
        ('--enable-eintr-debug',       'enable_eintr_debug',       int,     __ENABLE_EINTR_DEBUG__,       'Compile with EINTR debugging support, set to check/not check for EINTR.', []),
        ('--enable-parser-debug',      'enable_parser_debug',      int,     __ENABLE_PARSER_DEBUG__,      'Compile with parser debugging support.', []),
        ('--enable-checksum-debug',    'enable_checksum_debug',    int,     __ENABLE_CHECKSUM_DEBUG__,    'Compile with checksum debugging support.', []),
        ('--enable-checker-debug',     'enable_checker_debug',     int,     __ENABLE_CHECKER_DEBUG__,     'Compile with checker debugging support.', []),
        ('--enable-mem-err-debug',     'enable_mem_err_debug',     int,     __ENABLE_MEM_ERR_DEBUG__,     'Compile with MALLOC/FREE error debugging support.', ['--enable-mem-check', '--enable-mem-check-log']),
        ('--enable-script-debug',      'enable_script_debug',      int,     __ENABLE_SCRIPT_DEBUG__,      'Compile with script termination debugging support.', []),
    ]

    def _cli(self):
        from argparse import ArgumentParser
        p = ArgumentParser(description=self.__cli_desc__)
        for c in self.__cli_mapping__:
            p.add_argument(c[0], dest=c[1], type=c[2], default=c[3], help=c[4])
        p.parse_args(namespace=self.__cli_args__)
        return

    def _configure(self):
        self._cli()
        for k, v in self.__cli_args__.__dict__.items():
            if v == 1:
                for c in self.__cli_mapping__:
                    if k == c[1]:
                        self.__QUEUE__.append(c[0])
                        if c[5]: self.__QUEUE__ = self.__QUEUE__ + (c[5])
        return

    def run(self):
        self._configure()
        try:
            p = subprocess.Popen(self.__QUEUE__)
            if p:
                p.wait()
                p.kill()
                return True
            return False
        except Exception as e:
            print(e)
            return False

c = C()
if not c.run(): exit(1)
exit(0)
