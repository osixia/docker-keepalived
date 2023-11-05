#!/usr/bin/env python3

from sys import exit
from subprocess import Popen
from json import load
from argparse import ArgumentParser

class MappingEmpty(Exception):
    pass

class A(object):
    pass

class C:
    def __init__(self):
        self.__configure_json__ = 'configure.json'
        self.__cli_desc__       = 'docker-keepalived-configurer'
        self.__cli_args__       = A()
        self.__cli_mapping__    = []
        self.__queue__          = ['./configure']

    def ingestConfigureJson(self):
        try:
            with open(self.__configure_json__, 'r') as f:
                j = load(f)
                if j:
                    self.loadStatic(j['static'])
                    self.loadMapping(j['mapping'])
                    return True
        except KeyError as e:
            print("Key error for %s" % e)
        except Exception as e:
            print(e)
        return False

    def loadStatic(self, s):
        if s: self.__queue__ = self.__queue__ + s
        return

    def loadMapping(self, m):
        if not m: raise MappingEmpty("JSON mapping object cannot be empty.")
        self.__cli_mapping__ = self.__cli_mapping__ + m
        return

    def _typeConvertion(self, t):
        match t:
            case _:     return int

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
                        self.__queue__.append(c['argument'])
                        if c['related_arguments']: self.__queue__ = self.__queue__ + (c['related_arguments'])
        return

    def run(self):
        if not self.ingestConfigureJson(): return False
        self._configure()
        try:
            p = Popen(self.__queue__)
            if p:
                p.wait()
                p.kill()
                return True
        except Exception as e:
            print(e)
        return False

c = C()
if not c.run(): exit(-1)
exit()
