#!/usr/bin/env python3

import subprocess
from json import load
from argparse import ArgumentParser

class A(object):
    pass

class C:
    __configure_json__='configure.json'
    __cli_desc__ = 'docker-keepalived-configurer'
    __cli_args__= A()
    __cli_mapping__ = []
    __QUEUE__ = [
        './configure.sh',
    ]

    def jsonConfig(self):
        try:
            with open(self.__configure_json__, 'r') as f:
                j = load(f)
                if j:
                    try:
                        self.loadDefQueue(j['def_queue'])
                        self.loadMapping(j['mapping'])
                    except KeyError as e:
                        print("Key error for %s" % e)
                        return False
            return True
        except FileNotFoundError:
            print('%s does not exists.' % c)
        return False

    def loadDefQueue(self, dq):
        if dq: self.__QUEUE__ = self.__QUEUE__ + dq
        return

    def loadMapping(self, m):
        if m: self.__cli_mapping__ = self.__cli_mapping__ + m
        return

    def _typeConvertion(self, t):
        match t:
            case 1:
                return str
            case _:
                return int

    def _cli(self):
        p = ArgumentParser(description=self.__cli_desc__)
        for c in self.__cli_mapping__:
            p.add_argument(c['argument'], dest=c['dest'], type=self._typeConvertion(c['type']), default=c['default'], help=c['help'])
        p.parse_args(namespace=self.__cli_args__)
        return

    def _configure(self):
        self._cli()
        for k, v in self.__cli_args__.__dict__.items():
            if v == 1:
                for c in self.__cli_mapping__:
                    if k == c['dest']:
                        self.__QUEUE__.append(c['argument'])
                        if c['related_arguments']:
                            self.__QUEUE__ = self.__QUEUE__ + (c['related_arguments'])
        return

    def run(self):
        if not self.jsonConfig():
            return False
        self._configure()
        try:
            p = subprocess.Popen(self.__QUEUE__)
            if p:
                p.wait()
                p.kill()
                return True
        except Exception as e:
            print(e)
        return False

c = C()
if not c.run(): exit(1)
exit(0)
