# -*- coding: utf-8 -*-
from setuptools import setup, find_packages

setup(
    name="one_fm",
    version="0.0.1",
    packages=find_packages(),
    install_requires=[
        # Remove direct dependencies that can't be installed via pip
        "pytest>=6.0.0",
        "pytest-cov>=2.0.0",
        "coverage>=5.0.0"
    ],
)
