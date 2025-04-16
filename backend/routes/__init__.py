"""
Routes initialization module.
This module registers all route blueprints with the Flask application.
"""

from flask import Blueprint
from .health import health_bp

def register_routes(app):
    """
    Register all route blueprints with the Flask application.
    Args:
        app: Flask application instance
    """
    # Register blueprints
    app.register_blueprint(health_bp, url_prefix='/api') 