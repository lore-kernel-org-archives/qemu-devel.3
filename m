Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946C2C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 17:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whsKH-0006XR-PD; Thu, 09 Jul 2026 13:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whsKC-0006XD-Bb
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 13:14:13 -0400
Received: from smtp186.sjtu.edu.cn ([202.120.2.186])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <functioner@sjtu.edu.cn>)
 id 1whsK7-0000u6-4v
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 13:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sjtu.edu.cn;
 s=default; t=1783617235;
 bh=PzI9I9XXYChs9JZizEQm5y9mbt8aW6Gwbezms5g12mM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=zQ7cKQYMnKPsQ4Xqz+pLLMhDkq60j3/pOHm9op16iHZ6WWIFTLXhr3XJPH3EdPAQU
 iKtb8Kgai9mJHjR3Vci8w7ntnSndsGsxa22Fp27zOyQhswH0widqeXhx79Ha+yOq1s
 syBiJ6aepoQDJSFCcz5opzgY6Y8rzU5nJwf0uE5QgkMxh1c+cyHutx0TNvd7Hc02kQ
 tMFNQDQ5c6FRBldgUjehbGIkteVUm9MQHGFi8JDhTM7vEky6cNTNsY4LSKPaUTOeXH
 zH+ShmLwuFMJKtq4HAsrVxhLdV30/3iBbr6KPlD8oBRXJlLvmb3QFRDFiXrUWNHnDD
 Xpe2Wc39vPFKQ==
Received: from proxy188.sjtu.edu.cn (smtp188.sjtu.edu.cn [202.120.2.188])
 by smtp186.sjtu.edu.cn (Postfix) with ESMTPS id 2F9F02FF405;
 Thu,  9 Jul 2026 17:13:55 +0000 (UTC)
Received: from [10.0.1.62] (unknown [202.120.40.100])
 by proxy188.sjtu.edu.cn (Postfix) with ESMTPSA id 7C37F37C925;
 Fri, 10 Jul 2026 01:13:24 +0800 (CST)
Message-ID: <cd750bed-c681-4afa-abf6-ac659b8de10b@sjtu.edu.cn>
Date: Fri, 10 Jul 2026 01:13:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/2] docs/about/emulation: document the dlcall plugin
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260709170437.363560-1-functioner@sjtu.edu.cn>
 <20260709170437.363560-3-functioner@sjtu.edu.cn>
From: Ziyang Zhang <functioner@sjtu.edu.cn>
In-Reply-To: <20260709170437.363560-3-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.120.2.186;
 envelope-from=functioner@sjtu.edu.cn; helo=smtp186.sjtu.edu.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On Fri, 10 Jul 2026 01:04:37 +0800, Ziyang Zhang wrote:
> Document the dlcall plugin under Example Plugins: what it does, the trusted-
> guests and guest_base == 0 constraints, how to load it, and a pointer to
> Lorelei, one end-to-end userspace implementation, for the toolchain and a
> runnable example.
> Patch 2/2 walks through the hello example one step at a time. If you
would rather not run those steps by hand, the self-contained Makefile
below does the whole thing in one command: it downloads the devkit,
writes the sources, and builds the thunk tree from patch 2/2. After
that,

make QEMU=<your qemu-x86_64> PLUGIN=<contrib/plugins/libdlcall.so> run

runs the guest both ways and prints hello from guest then hello from
host.

It only needs wget or curl to fetch the devkit from the GitHub release,
plus a qemu-x86_64 built from this series for the run step. Drop it in
an empty directory and run make.


# ---- Makefile ----
# One-click Lorelei hello quickstart. From nothing, this Makefile 
downloads the
# devkit, writes the example sources, and builds the thunk tree from the
# walkthrough. Everything lands under this directory.
#
#   make            download the devkit if needed, then build the tree
#   make tree       print the resulting directory tree
#   make run        run baseline then thunked (set QEMU= and PLUGIN=)
#   make clean      remove the generated src/ build/ thunks/
#   make distclean  also remove the downloaded devkit and tarball
#
# Set DEVKIT= to reuse an already-unpacked devkit (then nothing is 
downloaded).
# Override VERSION= or ARCH= to pick a different release or host 
architecture.

VERSION ?= 1.0.5.0
ARCH    ?= $(shell uname -m)
DEVKIT  ?= lorelei-devkit-$(ARCH)
TARBALL := $(DEVKIT)-$(VERSION).tar.xz
URL     := 
https://github.com/rover2024/lorelei/releases/download/v$(VERSION)/$(TARBALL)

QEMU    ?=
PLUGIN  ?=

CLANG   = $(DEVKIT)/bin/x86_64-linux-gnu-clang
MKTHUNK = $(DEVKIT)/bin/LoreMakeThunk.py
GTL     = thunks/x86_64/lib/x86_64-LoreGTL

.PHONY: all tree run clean distclean

all: build/guest/main $(GTL)/libhello.so

# 0. the devkit, downloaded and unpacked only when $(MKTHUNK) is missing, so
# pointing DEVKIT= at an existing devkit skips the download.
$(MKTHUNK):
	@echo ">> downloading $(TARBALL)"
	@command -v wget >/dev/null 2>&1 && wget -O $(TARBALL) $(URL) \
	    || curl -fSL -o $(TARBALL) $(URL)
	tar -xf $(TARBALL)

# 1. the sources, written out so the whole tree comes from this one 
Makefile.
# The guest and host builds print "from guest" and "from host", so a run 
shows
# which one ran.
src/hello.h:
	@mkdir -p src
	@printf '%s\n' \
	    '#ifdef __cplusplus' 'extern "C" {' '#endif' \
	    'void hello(const char *name, int lucky);' \
	    '#ifdef __cplusplus' '}' '#endif' > $@

src/hello_guest.c: | src/hello.h
	@printf '%s\n' \
	    '#include "hello.h"' '#include <stdio.h>' '' \
	    'void hello(const char *name, int lucky)' '{' \
	    '    printf("hello from guest: %s, lucky %d\n", name, lucky);' \
	    '    fflush(stdout);' '}' > $@

src/hello_host.c: | src/hello.h
	@printf '%s\n' \
	    '#include "hello.h"' '#include <stdio.h>' '' \
	    'void hello(const char *name, int lucky)' '{' \
	    '    printf("hello from host: %s, lucky %d\n", name, lucky);' \
	    '    fflush(stdout);' '}' > $@

src/main.c: | src/hello.h
	@printf '%s\n' \
	    '#include "hello.h"' '' \
	    'int main(void)' '{' \
	    '    hello("world", 7);' '    return 0;' '}' > $@

# 2. the guest libhello.so (x86_64) and the guest program. main has no 
rpath,
# so which libhello.so it loads is decided by LD_LIBRARY_PATH at run time.
build/guest/main: src/hello_guest.c src/main.c src/hello.h | $(MKTHUNK)
	mkdir -p build/guest
	$(CLANG) -shared -fPIC src/hello_guest.c -o build/guest/libhello.so
	$(CLANG) src/main.c -Isrc -Lbuild/guest -lhello -o $@

# 3. the host libhello.so, native to this host, for the host thunk to use.
build/host/libhello.so: src/hello_host.c src/hello.h
	mkdir -p build/host
	cc -shared -fPIC src/hello_host.c -o $@

# 4. the thunk pack (host HTL + guest GTL) generated from the host library.
$(GTL)/libhello.so: build/host/libhello.so | $(MKTHUNK)
	$(MKTHUNK) --name hello --lib $< --header hello.h -o thunks -- -Isrc

# print the produced tree
tree: all
	@command -v tree >/dev/null 2>&1 && tree src build thunks \
	    || find src build thunks | sort

# run baseline (guest build) then thunked (host build) under qemu.
run: all
	@echo "== without the thunk =="
	$(QEMU) -E LD_LIBRARY_PATH=build/guest build/guest/main
	@echo "== with the thunk =="
	LORELEI_THUNK_PATH=thunks LD_LIBRARY_PATH=$(DEVKIT)/lib:build/host \
	  $(QEMU) -plugin $(PLUGIN) \
	  -E LD_LIBRARY_PATH=$(DEVKIT)/x86_64/lib:$(GTL) \
	  build/guest/main

clean:
	rm -rf src build thunks

distclean: clean
	rm -rf $(DEVKIT) $(TARBALL)


