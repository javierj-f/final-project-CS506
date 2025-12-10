# Makefile for Moon Phase and Tides Flood Analysis
.PHONY: install check run test clean help

help:
	@echo "Available commands:"
	@echo "  make install  - Install Python dependencies"
	@echo "  make check    - Verify data files and project structure"
	@echo "  make run      - Launch Jupyter notebook for analysis"
	@echo "  make test     - Run test suite"
	@echo "  make clean    - Clean temporary files"

install:
	@echo "Installing Python dependencies..."
	pip install -r requirements.txt
	@echo "✅ Dependencies installed."

check:
	@echo "=== PROJECT STRUCTURE CHECK ==="
	@echo "1. Checking for data/ directory..."
	@test -d data && echo "✅ data/ directory exists" || (echo "❌ ERROR: 'data/' directory not found" && exit 1)
	@echo "2. Checking for notebook..."
	@test -f final_code.ipynb && echo "✅ final_code.ipynb exists" || (echo "❌ ERROR: Notebook not found" && exit 1)
	@echo "3. Checking data files..."
	@python -c "
import os, sys
files = os.listdir('data')
print(f'Found {len(files)} data files')
if len(files) == 0:
    print('❌ ERROR: No data files found')
    sys.exit(1)
print('✅ Data files present')
"
	@echo "✅ Project check complete!"

run:
	@echo "Launching Jupyter notebook..."
	@echo ""
	@echo "INSTRUCTIONS:"
	@echo "1. Browser will open (or check terminal for URL)"
	@echo "2. Click on 'final_code.ipynb'"
	@echo "3. Run all cells: Cell → Run All"
	@echo "4. Close browser when done"
	@echo "5. Press Ctrl+C in terminal to stop Jupyter"
	@echo ""
	jupyter notebook

test:
	@echo "Running test suite..."
	python -m pytest tests/ -v
	@echo "✅ Tests complete!"

clean:
	@echo "Cleaning temporary files..."
	rm -rf __pycache__ .pytest_cache
	rm -f *.pyc
	@echo "✅ Cleanup complete!"

all: install check test
	@echo "✅ Everything set up! Run 'make run' to start analysis."