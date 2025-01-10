# -*- coding: utf-8 -*-
from setuptools import setup, find_packages

setup(
    name="one_fm",
    version="0.0.1",
    packages=find_packages(),
    install_requires=[
        "frappe",
        "erpnext"
    ],
)
