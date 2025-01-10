import pytest
from one_fm import hooks


def test_app_name():
    """Test the app name is correctly set"""
    assert hooks.app_name == "one_fm"


def test_app_title():
    """Test the app title is correctly set"""
    assert hasattr(hooks, 'app_title')


def test_required_apps():
    """Test required apps are correctly configured"""
    required_apps = getattr(hooks, 'required_apps', [])
    assert "frappe" in required_apps
    assert "erpnext" in required_apps


def test_app_version():
    """Test app version exists"""
    assert hasattr(hooks, 'app_version')
