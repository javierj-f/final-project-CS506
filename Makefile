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
	@echo "1. Checking directory structure..."
	@test -d data && echo "✅ data/ directory exists" || (echo "❌ data/ missing" && exit 1)
	@test -f final_code.ipynb && echo "✅ final_code.ipynb exists" || (echo "❌ Notebook missing" && exit 1)
	@test -f requirements.txt && echo "✅ requirements.txt exists" || (echo "❌ requirements.txt missing" && exit 1)
	
	@echo ""
	@echo "2. Checking data files..."
	@python -c "
import os, pandas as pd, sys
files = os.listdir('data')
print(f'Found {len(files)} files in data/')
print('Sample files:')
for f in files[:5]:
    print(f'  - {f}')

# Check naming pattern
required_cities = ['boston', 'seattle', 'florida', 'la']
years = ['2019', '2020', '2021', '2022', '2023']
for city in required_cities:
    pattern = f'tide_height_{city}_'
    matching = [f for f in files if pattern in f.lower()]
    print(f'{city}: {len(matching)} files')
    
# Test reading one file
if files:
    try:
        sample = files[0]
        df = pd.read_csv(f'data/{sample}', nrows=5)
        print(f'\\n✅ Can read {sample}')
        print(f'   Shape: {df.shape}')
        print(f'   Columns: {list(df.columns)}')
    except Exception as e:
        print(f'❌ Error reading {sample}: {e}')
        sys.exit(1)
"
	@echo ""
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