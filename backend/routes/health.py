"""
Health check endpoints module.
Provides basic health check functionality to verify API status.
"""

from flask import Blueprint, jsonify

# Create blueprint
health_bp = Blueprint('health', __name__)

@health_bp.route('/health', methods=['GET'])
def health_check():
    """
    Basic health check endpoint.
    Returns:
        JSON response indicating API is operational
    """
    return jsonify({
        'status': 'healthy',
        'message': 'API is operational'
    }), 200 