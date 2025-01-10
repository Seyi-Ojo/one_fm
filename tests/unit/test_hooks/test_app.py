import pytest


def test_app_name():
    """Test the app name is correctly set"""
    from one_fm import app_name
    assert app_name == "one_fm"


def test_app_title():
    """Test the app title is correctly set"""
    from one_fm import app_title
    assert app_title == "One Facilities Management"


def test_app_version():
    """Test app version exists"""
    from one_fm import __version__
    assert isinstance(__version__, str)


@pytest.mark.skip(reason="ERPNext not installed in test environment")
def test_required_apps():
    """Test required apps are correctly configured"""
    from one_fm import required_apps
    assert "frappe" in required_apps
    assert "erpnext" in required_apps
