# x64 ELF Assembly

## General Purpose Registers
A register is basically used to hold a value. Each type has its own context, and due to [Calling Conventions](https://en.wikipedia.org/wiki/Calling_convention#Architectures), each value should be stored in the related register.

<br>

There are four fundamental general-purpose registers.
| Suffix  | 64bit | 32bit | 16bit | 8bit(high) | 8bit(low) | Description |
| :---:   |:-----:| :---: | :---: | :--------: | :-------: | :---------- |
|   A     |  RAX  |  EAX  |  AX   |     AH     |    AL     | Accumulator |
|   B     |  RBX  |  EBX  |  BX   |     BH     |    BL     | -           |
|   C     |  RCX  |  ECX  |  CX   |     CH     |    CL     | Counter     |
|   D     |  RDX  |  EDX  |  DX   |     DH     |    DL     | -           |

<br>

on x64 and AMD systems, we have 8 more general purpose registers too.
| Name  | 64bit | 32bit  |  16bit  | 8bit(high) | 8bit(low) |
| :---: |:-----:| :----: | :-----: | :--------: | :-------: |
|  R8   |  R8   |  R8D   |  R8W    |    R8B     |     -     |
|  R9   |  R9   |  R9D   |  R9W    |    R9B     |     -     |
|  R10  |  R10  |  R10D  |  R10W   |    R10B    |     -     |
|  R11  |  R11  |  R11D  |  R11W   |    R11B    |     -     |
|  R12  |  R12  |  R12D  |  R12W   |    R12B    |     -     |
|  R13  |  R13  |  R13D  |  R13W   |    R13B    |     -     |
|  R14  |  R14  |  R14D  |  R14W   |    R14B    |     -     |
|  R15  |  R15  |  R15D  |  R15W   |    R15B    |     -     |

<br>

| Name        | Suffix | Size(bits) | Description                                |
| :---------- | :----: | :--------: | :----------------------------------------- |
| Bit         |    -   | 1          | The smallest "unit" of data                |
| Nibble      |    -   | 4          | Collection of four bits                    |
| Byte        |    B   | 8          | The smallest addressable datum (data item) |
| Word        |    W   | 16         | Group of 16 bits (2 bytes)                 |
| Double Word |    D   | 32         | A pair of words                            |
| Quad Word   |    Q   | 64         | Pair of double words                       |

Did you notice that the length of the extended general-purpose registers is specified according to that table?\
Similarly, many registers (i will cover them later) can be modified with these suffixes.


### Specific Registers
While any register can be used for various purposes, it is not as logical due to the lack of optimization and adherence to calling conventions.

1. <u>Counter Register</u> `CX`<br>
An iterator for any loop.

2. <u>Source Instruction</u> `SI` & <u>Destination Instruction</u> `DI`<br>
Useful while filling, copying or comparing.

3. <u>Base Pointer (aka Frame Pointer)</u> `BP`<br>
Holds the starting address of a stack frame.\
With this register, offsetting and accessing any address within a memory region of a subroutine or a stack frame become easier.

4. <u>Stack Pointer</u> `SP`<br>
Holds the address of the last item pushed onto the processor's stack.
Registers can be pushed onto the stack if their values need to be preserved. When they are popped from the stack, their values are restored.

5. <u>Instruction Pointer</u> `IP`<br>
Contains address of the next instruction to be executed.\
CPU automatically adds the correct number to it as it executes instructions\
to keep it pointed at the correct next instruction.\
When a subroutine is called, the `IP` should be pushed onto the stack to preserve it's value. in [Prologue](https://en.wikipedia.org/wiki/Function_prologue_and_epilogue#Prologue)
phase.\
This may seem confusing at first, but it is necessary. I will explain the reason later, so try not to overthink it.

### Flags

## Tools
Several tools used in this project.
### 1. objdump
Objdump displays information about object files.\
Here are some useful options for debugging and examining the assembly code of compiled files:
1. `objdump -d executable`\
*Disassembles the executable and dumps it to stdout.*
2. `objdump --disassemble='cFunction'`\
*Disassembles only **cFunction** and outputs it to stdout.\
I use this option to observe the differences between C and assembly.\
Let's consider a C function which sums 2 number and returns it.\
C compiler (gcc, cc etc.) optimizes and puts safety things implicitly while compiling.\
That is what 'compiling' means, but I want to handle everything with assembly.\
After all, isn't that the purpose of assembly coding?*
3. `objdump -d -M intel executable`\
*Disasemble **executable** with Intel Syntax.\
By default, objdump uses AT&T syntax.\
But i prefer intel syntax.\
Period.*
4. `objdump -h executable`\
*Brief information about all sections of the **executable**.*

<table>
  <tr>
    <th>Idx</th>
    <td>Indicates the section's position in the file.</td>
  </tr>
  <tr>
    <th>Name</th>
    <td>Specifies the name of the section.</td>
    <td>General sections are: <i>.text, .data, .rodata, .bss</i>*</td>
  </tr>
  <tr>
    <th>Size</th>
    <td>Specifies the amount of space in bytes the section occupies in memory.</td>
  </tr>
  <tr>
    <th>VMA</th>
    <td>
      Represents the Virtual Memory Address of the section.<br>
      This address shows the location in memory where the section’s executable code or data segments are mapped.<br>
      VMA is translated to the actual memory address by the operating system when the program is executed.
    </td>
  </tr>
  <tr>
    <th>LMA</th>
    <td>
      Indicates the Load Memory Address of the section.<br>
      This shows the address at which the section is loaded from the file into memory.<br>
      Typically, LMA and VMA have the same value, but they can differ in some cases (e.g., in embedded systems).
    </td>
  </tr>
  <tr>
   <th>File off</th>
   <td>
      Shows the starting position of the section within the file.<br>
      This specifies the position of the first byte of the section in the file and is directly related to the file's content.
    </td>
  </tr>
  <tr>
    <th>Algn</th>
    <td>
      Displays the alignment value of the section.<br>
      This specifies how the section is aligned in memory, which usually affects memory efficiency and performance.<br>
      It is shown in the form of 2**n, indicating how much alignment is required for the section in memory.
    </td>
  </tr>
</table>

<b>*:</b>

<table>
  <tr>
    <th>.text</th>
    <td>includes code itself</td>
  </tr>
  <tr>
    <th>.data</th>
    <td>definitions of constants or magic numbers etc.</td>
  </tr>
  <tr>
    <th>.rodata</th>
    <td>readonly data</td>
  </tr>
  <tr>
    <th>.bss</th>
    <td>uninitialized data</td>
  </tr>
</table>

5. `objdump -t executable` *shows [Symbol Table](https://en.wikipedia.org/wiki/Symbol_table) of the **executable**.*

### 2. gdb
The GNU Debugger
1. `file executable`\
*runs the **executable** in gdb.*
2. `b linenumber`\
*inserts a breakpoint*
3. `n`\
*runs nextline after the breakpoint*

### 3. nasm
The Netwide Assembler\
NASM differs from other assemblers (like FASM) by allowing to define special expriessions like\
`%define expr`.\
For further information: [NASM Documentation](https://www.nasm.us/xdoc/2.10rc8/html/nasmdoc4.html)

### 4. ld
The GNU Linker\
A linker's main purpose is to combine several object and/or archive files,\
relocate their data and tie up symbol references.
1. <u>Static Linking</u>\
*Includes the code of the libraries and symbols used in the compilation and linking phase of the program directly into the executable file. This means the executable file contains all the necessary code independently and does not require any other external libraries. This allows the application to run independently, but it can also increase the size of the file.*\
`ld file.o -o executablename`\
*creates an executable from compiled file.*\
`ld -e entrypointname`\
*use entrypointname as the explicit symbol for beginning execution of the program,\
rather than the default entry point.*
2. <u>Dynamic Linking</u>\
*Dynamically loads and links necessary library routines and symbols while the program is running. This makes the executable smaller because the libraries are loaded from the system at runtime. Dynamic linking makes it easier to share the same library by multiple programs and to update the libraries because the library files can be updated independently of the program.*<br>\
`ld file.o -dynamic-linker -lc CLibraryLocation -o executablename`\
*links **file** with a dynamic C library.*

### 5. make
TODO: Make will soon be replaced with CMake.


### 6. ar
The `ar` tool is a traditional utility for archiving files into a library.
<table>
  <tr>
    <th>r</th>
    <td>
      Insert  the  files  member...  into archive (with replacement).<br>
      If the file is already in library, it updates that file.
    </td>
  </tr>
  <tr>
    <th>c</th>
    <td>Create the archive file. If requested file already exists, updates.</td>
  </tr>
  <tr>
    <th>s</th>
    <td>Creates symbol table.</td>
  </tr>
</table>

### 7. ranlib
1. Running `ranlib` is completely equivalent to executing `ar -s`.


# Credits
I would like to extend my heartfelt thanks to `Muslum Baba` and his friends for revealing the passion I have for assembly language. Rest In Peace; you will always be missed..<br><br>
![baba](baba.jpg?raw=true)
