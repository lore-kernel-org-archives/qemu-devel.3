Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F07C54E5C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjF-0005KG-Qe; Fri, 01 Mar 2024 23:12:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1R-0003kp-3f
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:35 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgC1O-0005ee-4Y
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 18:10:32 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6e4d48a5823so2408735b3a.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 15:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709334627; x=1709939427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2NxBdbDmPXvqTBcYichP7qzlXUZvSD7xiNQMCyXrUoI=;
 b=qs2Y+WFIzwetA+h6Yrssb791wKEbmV4a8K2QmdMcX+tsF0MnByiW3H0a3NkFijhrPj
 6LF3IlM3VzQRvAtnpwrdMnmALXHIBl57oV3rfsEpxNCqOH+dGX5QGfmjZ1boUWwBJkeK
 aAGws+PGWtyBkk3x70XLoTUnXSlsISD9YmpSr27peGYK0KaTE1tfU75D7+jfzs3RFIEc
 BQmf11UKmuFFYdM5JiJPnJuNm1D2YGRccBNoGRF3MRgb7czIAnWP0XSnGmORbBOUhqEv
 FBVeRU89t7t5Iz1JvltDPfXIFzHnVB6cYpNweRM38v0C0eVE7c8fzKeg8oq8FBI03q9I
 mw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709334627; x=1709939427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2NxBdbDmPXvqTBcYichP7qzlXUZvSD7xiNQMCyXrUoI=;
 b=sAAW5Sqewz/CcpPqM/LVu0iMVzjQ3hd2rkS7/+0MLk14xYg2Lntr4PqfDMTJjBKzdI
 8Wjyusg/onm77SdlJSqwNiOwCGdNALe+ljQd+SqGixwflMMjpYttbyc0NS2UAjlZ/gXb
 dmEcdnfsbDv8LlaXfYc/+ROgKGkZSePRCOGs+pIFJGacrVE5GqSJnimGyrejOwq0pP0k
 r9t6iWoo8pajtii+UukZEByLwMpJdmXTDj/I1lvH11xQPQvgu2pH2f88KyZ0j+t0xbgQ
 jWWc02oXE4chSpKVP+B4EVkOo33lLaeDTDkLuT0VtQHuwnwILWMtYEPqz/HSHDbTITKu
 DFkQ==
X-Gm-Message-State: AOJu0YzOhKwbsfC7f7uhCPkipwEGg8i6P1rkaywo0/QsbJKr3kkknz0U
 biwxcu6aXX3ESuZOreBvZNQBOiJc05SPjnhKELa1pY6g4Y10Hq/eCm9MKy7gZR0e3FMzvtdsc/6
 N
X-Google-Smtp-Source: AGHT+IEAmN2zFo7V+85qKysxgFcPc9pA035hiyx3atYJi4YG0flx6TSM61qZKCItOnaYQCBQa2NOgw==
X-Received: by 2002:a05:6a20:3404:b0:1a0:ed31:d5a6 with SMTP id
 i4-20020a056a20340400b001a0ed31d5a6mr2365281pzd.56.1709334627407; 
 Fri, 01 Mar 2024 15:10:27 -0800 (PST)
Received: from stoup.. (098-147-055-211.res.spectrum.com. [98.147.55.211])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a634e02000000b005e438fe702dsm3449407pgb.65.2024.03.01.15.10.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 15:10:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH 44/60] tests/tcg: Remove run-test-mmap-*
Date: Fri,  1 Mar 2024 13:06:03 -1000
Message-Id: <20240301230619.661008-45-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301230619.661008-1-richard.henderson@linaro.org>
References: <20240301230619.661008-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These tests are confused, because -p does not change
the guest page size, but the host page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20240102015808.132373-25-richard.henderson@linaro.org>
---
 tests/tcg/alpha/Makefile.target     |  3 ---
 tests/tcg/arm/Makefile.target       |  3 ---
 tests/tcg/hppa/Makefile.target      |  3 ---
 tests/tcg/i386/Makefile.target      |  3 ---
 tests/tcg/m68k/Makefile.target      |  3 ---
 tests/tcg/multiarch/Makefile.target |  9 ---------
 tests/tcg/ppc/Makefile.target       | 12 ------------
 tests/tcg/sh4/Makefile.target       |  3 ---
 tests/tcg/sparc64/Makefile.target   |  6 ------
 9 files changed, 45 deletions(-)
 delete mode 100644 tests/tcg/ppc/Makefile.target
 delete mode 100644 tests/tcg/sparc64/Makefile.target

diff --git a/tests/tcg/alpha/Makefile.target b/tests/tcg/alpha/Makefile.target
index b94500a7d9..fdd7ddf64e 100644
--- a/tests/tcg/alpha/Makefile.target
+++ b/tests/tcg/alpha/Makefile.target
@@ -13,6 +13,3 @@ test-cmov: test-cond.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
 run-test-cmov: test-cmov
-
-# On Alpha Linux only supports 8k pages
-EXTRA_RUNS+=run-test-mmap-8192
diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
index 3473f4619e..0a1965fce7 100644
--- a/tests/tcg/arm/Makefile.target
+++ b/tests/tcg/arm/Makefile.target
@@ -79,6 +79,3 @@ sha512-vector: sha512.c
 ARM_TESTS += sha512-vector
 
 TESTS += $(ARM_TESTS)
-
-# On ARM Linux only supports 4k pages
-EXTRA_RUNS+=run-test-mmap-4096
diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/Makefile.target
index cdd0d572a7..ea5ae2186d 100644
--- a/tests/tcg/hppa/Makefile.target
+++ b/tests/tcg/hppa/Makefile.target
@@ -2,9 +2,6 @@
 #
 # HPPA specific tweaks - specifically masking out broken tests
 
-# On parisc Linux supports 4K/16K/64K (but currently only 4k works)
-EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-16384 run-test-mmap-65536
-
 # This triggers failures for hppa-linux about 1% of the time
 # HPPA is the odd target that can't use the sigtramp page;
 # it requires the full vdso with dwarf2 unwind info.
diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index 9906f9e116..bbe2c44b2a 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -71,9 +71,6 @@ endif
 I386_TESTS:=$(filter-out $(SKIP_I386_TESTS), $(ALL_X86_TESTS))
 TESTS=$(MULTIARCH_TESTS) $(I386_TESTS)
 
-# On i386 and x86_64 Linux only supports 4k pages (large pages are a different hack)
-EXTRA_RUNS+=run-test-mmap-4096
-
 sha512-sse: CFLAGS=-msse4.1 -O3
 sha512-sse: sha512.c
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
diff --git a/tests/tcg/m68k/Makefile.target b/tests/tcg/m68k/Makefile.target
index 6ff214e60a..33f7b1b127 100644
--- a/tests/tcg/m68k/Makefile.target
+++ b/tests/tcg/m68k/Makefile.target
@@ -5,6 +5,3 @@
 
 VPATH += $(SRC_PATH)/tests/tcg/m68k
 TESTS += trap denormal
-
-# On m68k Linux supports 4k and 8k pages (but 8k is currently broken)
-EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192
diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index e10951a801..f11f3b084d 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -51,18 +51,9 @@ run-plugin-vma-pthread-with-%: vma-pthread
 	$(call skip-test, $<, "flaky on CI?")
 endif
 
-# We define the runner for test-mmap after the individual
-# architectures have defined their supported pages sizes. If no
-# additional page sizes are defined we only run the default test.
-
-# default case (host page size)
 run-test-mmap: test-mmap
 	$(call run-test, test-mmap, $(QEMU) $<, $< (default))
 
-# additional page sizes (defined by each architecture adding to EXTRA_RUNS)
-run-test-mmap-%: test-mmap
-	$(call run-test, test-mmap-$*, $(QEMU) -p $* $<, $< ($* byte pages))
-
 ifneq ($(GDB),)
 GDB_SCRIPT=$(SRC_PATH)/tests/guest-debug/run-test.py
 
diff --git a/tests/tcg/ppc/Makefile.target b/tests/tcg/ppc/Makefile.target
deleted file mode 100644
index f5e08c7376..0000000000
--- a/tests/tcg/ppc/Makefile.target
+++ /dev/null
@@ -1,12 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# PPC - included from tests/tcg/Makefile
-#
-
-ifneq (,$(findstring 64,$(TARGET_NAME)))
-# On PPC64 Linux can be configured with 4k (default) or 64k pages (currently broken)
-EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-65536
-else
-# On PPC32 Linux supports 4K/16K/64K/256K (but currently only 4k works)
-EXTRA_RUNS+=run-test-mmap-4096 #run-test-mmap-16384 run-test-mmap-65536 run-test-mmap-262144
-endif
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 47c39a44b6..16eaa850a8 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -3,9 +3,6 @@
 # SuperH specific tweaks
 #
 
-# On sh Linux supports 4k, 8k, 16k and 64k pages (but only 4k currently works)
-EXTRA_RUNS+=run-test-mmap-4096 # run-test-mmap-8192 run-test-mmap-16384 run-test-mmap-65536
-
 # This triggers failures for sh4-linux about 10% of the time.
 # Random SIGSEGV at unpredictable guest address, cause unknown.
 run-signals: signals
diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
deleted file mode 100644
index 408dace783..0000000000
--- a/tests/tcg/sparc64/Makefile.target
+++ /dev/null
@@ -1,6 +0,0 @@
-# -*- Mode: makefile -*-
-#
-# sparc specific tweaks
-
-# On Sparc64 Linux support 8k pages
-EXTRA_RUNS+=run-test-mmap-8192
-- 
2.34.1


