##===- examples/wpa/Makefile -------------------------------*- Makefile -*-===##
#
#                     The LLVM Compiler Infrastructure
#
# This file is distributed under the University of Illinois Open Source
# License. See LICENSE.TXT for details.
#
##===----------------------------------------------------------------------===##

CLANG_LEVEL := ../..

TOOLNAME = clang-wpa
NO_INSTALL = 1

# No plugins, optimize startup time.
TOOL_NO_EXPORTS = 1

LINK_COMPONENTS := asmparser bitreader mc core
USEDLIBS = clangStaticAnalyzerFrontend.a \
           clangStaticAnalyzerCheckers.a \
           clangStaticAnalyzerCore.a \
           clangIndex.a clangFrontend.a clangDriver.a \
	   clangParse.a clangSema.a clangAnalysis.a clangSerialization.a \
           clangAST.a  clangLex.a clangBasic.a

include $(CLANG_LEVEL)/Makefile
