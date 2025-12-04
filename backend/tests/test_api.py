"""
Tests for VoBee API
"""
import pytest
from fastapi.testclient import TestClient
from app.main import app


client = TestClient(app)


def test_root():
    """Test root endpoint"""
    response = client.get("/")
    assert response.status_code == 200
    assert "message" in response.json()


def test_health_check():
    """Test health check endpoint"""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


def test_chat_endpoint():
    """Test chat endpoint"""
    response = client.post(
        "/api/chat",
        json={"message": "Jak investovat?"}
    )
    assert response.status_code == 200
    data = response.json()
    assert "response" in data
    assert len(data["response"]) > 0


def test_chat_with_keyword():
    """Test chat endpoint with specific keyword"""
    response = client.post(
        "/api/chat",
        json={"message": "Poraď mi s investicemi"}
    )
    assert response.status_code == 200
    data = response.json()
    assert "ETF" in data["response"] or "investice" in data["response"].lower()


def test_get_tips():
    """Test get all tips"""
    response = client.get("/api/tips")
    assert response.status_code == 200
    tips = response.json()
    assert len(tips) > 0


def test_get_tips_by_category():
    """Test get tips filtered by category"""
    response = client.get("/api/tips?category=investing")
    assert response.status_code == 200
    tips = response.json()
    for tip in tips:
        assert tip["category"] == "investing"


def test_get_tip_by_id():
    """Test get specific tip"""
    response = client.get("/api/tips/1")
    assert response.status_code == 200
    tip = response.json()
    assert tip["id"] == 1


def test_get_tip_not_found():
    """Test get non-existent tip"""
    response = client.get("/api/tips/999")
    assert response.status_code == 404
