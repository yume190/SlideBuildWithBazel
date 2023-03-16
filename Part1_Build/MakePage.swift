//
//  MakePage.swift
//  CodeView
//
//  Created by Yume on 2023/3/3.
//

import CodeView
import Foundation
import SwiftUI

var makes: [any View] { 
    [
        VStack {
            Text("Make").title
        },
        MakePage0(),
        VStack {
            Text("已存在的 target(檔案)，不會再執行。").title
        },
        MakePhonyPage(),
        MakePage1(),
        VStack {
            Text("當相依檔案有更動時才會，才能再次執行指令。").title
        },
        MakePage2(),
        MakePage3(),
    ]
}

private struct MakePage0: View {
    let code: SourceFile = .init(.makefile, """
    main.o:
    \tclang -c main.c -o main.o
    
    # make target
    # target:
    #\t指令(通常目的是產出 target)
    
    """, "Makefile")
    
    let term = TerminalView(.default)
    var body: some View {
        VStack {
            Text("第一個 make 指令").title
            HStack {
                CodeView(code, .default, true)
                VStack {
                    Button.cmd(term, "make main.o")
                    Button.cmd(term, "make main.o again!!", "make main.o")
                }
            }
            term
                .initialize(.cMain, .cAdd, .cAdd2, .hAdd, code)
        }
    }
}

private struct MakePhonyPage: View {
    let code: SourceFile = .init(.makefile, """
    main.o: main.c
    \tclang -c main.c -o xxx
    \tclang -c main.c -o yyy
    
    xxx:
    \techo xxx123
    
    .PHONY: yyy
    yyy:
    \techo yyy123
    
    """, "Makefile")
    
    let term = TerminalView(.default)
    var body: some View {
        VStack {
            Text("假目標").title
            HStack {
                CodeView(code, .default, true)
                VStack {
                    Button.cmd(term, "tree")
                    Button.cmd(term, "make xxx")
                    Button.cmd(term, "make yyy")
                    Button.cmd(term, "make main.o")
                }
            }
            term
                .initialize(.cMain, .hAdd, code)
        }
    }
}

private struct MakePage1: View {
    let code: SourceFile = .init(.makefile, """
    main.o: main.c
    \tclang -c main.c -o main.o
    
    """, "Makefile")
    
    let term = TerminalView(.default)
    var body: some View {
        VStack {
            Text("相依檔案").title
            HStack {
                CodeView(code, .default, true)
                CodeView(.cMain, .default, true)
                VStack {
                    Button.cmd(term, "make main.o")
                    Button.cmd("save") {
                        NotificationCenter.default.post(name: .save, object: nil)
                    }
                }
            }
            term
                .initialize(.cMain, .cAdd, .cAdd2, .hAdd, code)
        }
    }
}

private struct MakePage2: View {
    let code: SourceFile = .init(.makefile, """
    main.o: main.c
    \tclang -c main.c -o main.o

    add.o: add.c
    \tclang -c add.c -o add.o
    
    add2.o: add2.c
    \tclang -c add2.c -o add2.o

    main: main.o add.o
    \tclang main.o add.o -o main
    
    main2: main.o add2.o
    \tclang main.o add2.o -o main2
    """, "Makefile")
    
    let term = TerminalView(.default)

    var body: some View {
        VStack {
            Text("相依檔案 Chain").title
            HStack {
                CodeView(code, .default, true)
                VStack {
                    Button.cmd(term, "make main")
                    Button.cmd(term, "make main2")
                    Button.cmd(term, "執行 main", "./main")
                    Button.cmd(term, "執行 main2", "./main2")
                }
            }
            term
                .initialize(.cMain, .cAdd, .cAdd2, .hAdd, code)
        }
    }
}

private struct MakePage3: View {
    let code: SourceFile = .init(.makefile, """
    # make main.oo
    # clang -c main.c -o main.oo
    # 自訂規則
    %.oo : %.c
    \tclang -c $< -o $@

    main: main.oo add.oo
    \tclang main.oo add.oo -o $@
    
    # 隱規則
    main1: main.o add.o
    \tclang main.o add.o -o $@
    
    """, "Makefile")
    
    let term = TerminalView(.default)

    var body: some View {
        VStack {
            Text("Rules").title
            HStack {
                CodeView(code, .default, true)
                VStack {
                    Button.cmd(term, "make main")
                    Button.cmd(term, "執行 main", "./main")
                    Divider()
                    Button.cmd(term, "make main1")
                    Button.cmd(term, "執行 main1", "./main1")
                }
            }
            term
                .initialize(.cMain, .cAdd, .cAdd2, .hAdd, code)
        }
    }
}
