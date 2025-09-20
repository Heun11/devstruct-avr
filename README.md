## Project structure for AVR boards
         __      _______  
        /\ \    / /  __ \ 
       /  \ \  / /| |__) |
      / /\ \ \/ / |  _  / 
     / ____ \  /  | | \ \ 
    /_/    \_\/   |_|  \_\
                                         

### Install:
```bash
sudo apt-get install gcc-avr avr-libc avrdude make
```

### Strucutre:
```
my-avr-project/
├── Makefile                # Build instructions
├── README.md               # Project description
├── source/                    # Source code
│   └── main.c              # Main program
├── lib/                    # Optional: external libraries
│   └── some_library/
│       ├── lib.c
│       └── lib.h
└── build/                  # Compiled objects / ELF files
    └── main.hex            
```

### Usage:
1. Put your source code to ./source
2. ```make & make flash```
3. ```make clean```