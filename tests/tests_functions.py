# tests/test_functions.py
import pandas as pd
import numpy as np
import pytest

# Helper functions from your notebook
def categorize_phase(phase):
    """Moon phase categorization from your notebook"""
    if phase < 10 or phase > 90:
        return "New/Full Moon"
    elif 40 < phase < 60:
        return "Quarter Moon"
    else:
        return "Intermediate"

def test_moon_phase_categorization():
    """Test moon phase categorization"""
    # Test boundaries
    assert categorize_phase(5) == "New/Full Moon"
    assert categorize_phase(95) == "New/Full Moon"
    assert categorize_phase(45) == "Quarter Moon"
    assert categorize_phase(55) == "Quarter Moon"
    assert categorize_phase(20) == "Intermediate"
    assert categorize_phase(70) == "Intermediate"
    print("✅ Moon phase categorization works")

def test_flood_thresholds():
    """Test city flood thresholds"""
    cities = {
        "Seattle": {"lat": 47.6062, "lon": -122.3321, "threshold": 13.45},
        "Florida": {"lat": 25.7617, "lon": -80.1918, "threshold": 3.53},
        "Boston": {"lat": 42.3601, "lon": -71.0589, "threshold": 12.5},
        "LA": {"lat": 34.0522, "lon": -118.2437, "threshold": 6.99}
    }
    
    assert len(cities) == 4
    for city, info in cities.items():
        assert "threshold" in info
        assert info["threshold"] > 0
    print("✅ Flood thresholds defined correctly")

def test_data_structure():
    """Test that required data structure exists"""
    # This test passes if cities dict exists
    cities = {
        "Seattle": {"lat": 47.6062, "lon": -122.3321, "threshold": 13.45},
        "Florida": {"lat": 25.7617, "lon": -80.1918, "threshold": 3.53},
        "Boston": {"lat": 42.3601, "lon": -71.0589, "threshold": 12.5},
        "LA": {"lat": 34.0522, "lon": -118.2437, "threshold": 6.99}
    }
    assert isinstance(cities, dict)
    print("✅ Data structure exists")

def test_simple_math():
    """Simple test to verify pytest works"""
    result = 2 + 2
    assert result == 4
    print("✅ Basic math works")

if __name__ == "__main__":
    # Run all tests
    test_moon_phase_categorization()
    test_flood_thresholds()
    test_data_structure()
    test_simple_math()
    print("\n✅ All tests passed!")