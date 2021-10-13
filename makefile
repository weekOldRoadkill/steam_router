all: .hererocks


.hererocks:
	python -m hererocks -j@v2.1 -r@ --compat=all .hererocks || pip install hererocks && python -m hererocks -j@v2.1 -r@ --compat=all .hererocks
	.hererocks/bin/luarocks install luasocket
	.hererocks/bin/luarocks install argparse


clean:
	rm -fr .hererocks
