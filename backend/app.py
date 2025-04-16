"""
Main Flask application module.
This module initializes and configures the Flask application, including:
- Environment configuration
- Database connection
- Route registration
- Error handlers
"""

from flask import Flask, jsonify
from flask_cors import CORS
import os
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

def create_app():
    """
    Factory function to create and configure the Flask application.
    Returns:
        Flask: Configured Flask application instance
    """
    app = Flask(__name__)
    
    # Enable CORS
    CORS(app)
    
    # Configure app
    app.config['JSON_SORT_KEYS'] = False
    
    # Register routes
    from routes import register_routes
    register_routes(app)
    
    # Error handlers
    @app.errorhandler(404)
    def not_found_error(error):
        return jsonify({'error': 'Resource not found'}), 404
    
    @app.errorhandler(500)
    def internal_error(error):
        return jsonify({'error': 'Internal server error'}), 500
        
    return app

if __name__ == '__main__':
    app = create_app()
    port = int(os.getenv('PORT', 5000))
    app.run(host='0.0.0.0', port=port) 