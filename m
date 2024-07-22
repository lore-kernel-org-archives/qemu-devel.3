Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE71C49EA1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 16:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVvZq-0004zZ-Cw; Mon, 22 Jul 2024 12:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZd-0004ml-Eu
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:42 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sVvZZ-0007ee-So
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 12:07:41 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc49c1f3e5so33143715ad.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721664456; x=1722269256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=luG5nJ5Z9qAGh6mHW5n5nNQarFbYtOH+t4hNgATSngY=;
 b=GqZTG2tKaeqE98FKWh0VZUCv+z2SY9pgkADfV8BY82pB98Giq5vwDg9reg5ZIshmUd
 F/Rdkt9qvuNDuaUrXn4JZuFJZo0LfEnJ+ETOpJqsj5KknwffPVJhuyOARjx2wG7lR37p
 845Hb3YCCNn+qPN2lmF7LSDiUHn9Q5cCc2RlkaaBbzAAOs42y3cDo+RoZuzPYDEvBZdb
 qlKNfrEMYRI+kG0leVuyfcMvThPOPYIQHhdcPcalfES/WdnwsnpUYY4Vb5Mbqrf6wihA
 kGmCgpghikPeHgbM4cVbxQLxJQYtddeINEhJLy2VepFS4c5E5d4GpypRk6Legv7DLa/t
 YZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721664456; x=1722269256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luG5nJ5Z9qAGh6mHW5n5nNQarFbYtOH+t4hNgATSngY=;
 b=Tc3ZzQ7KnnvfzlM+kAZGe8WgVZ++zEg8xbMCfV1vn6oBgiQCxLa3mj5vGh+aYdIcx1
 vKPxnjT6v5ICwOkF6yM8wBcoVAUlH49ZhgdAVF0r/gJHbSDGYFk60QWLoGm9KdbxfjkG
 GxGvJnjIDi/ZqzPL567sVwZMD2TPDW1GGw5Sw/Tg3lp9dcpMbPtKUmoka3POMbCljy9B
 x6wzEuiDThxK4kmJQaKJXsIJ1w1m4Z9IFQG76HV0HRawKwVuJa5wj281I8Tn778An42l
 Anqq46QIZCMnevFpUHexXkFkKg/Qvs3qeF+rUY5kldF5KzroQ0ZTzHN5OJHAFsm1k7Ib
 2aUg==
X-Gm-Message-State: AOJu0YyTGMSTnrI381F16b7PXmbXrxu0+6RD5t4zEr8LqgELYVk7qfZs
 qIkDr20yw659NtzYhNCwlhK5NOS5nSRCWnuUr8U1sUaurLfl/8nAF3jvbxSGThVFBvO4wR080K6
 i
X-Google-Smtp-Source: AGHT+IFlwMr/tlJhPCGwBLCaOZQrC5cb4ZhWPkeQXVvSzQfbYT4FY+A/AfB7dxPyk6Hd3kVpfxoHqA==
X-Received: by 2002:a17:902:f688:b0:1fd:8f2c:5dae with SMTP id
 d9443c01a7336-1fd8f2c602fmr20550355ad.24.1721664455607; 
 Mon, 22 Jul 2024 09:07:35 -0700 (PDT)
Received: from amd.. ([2804:7f0:b402:9243:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f2ac8eesm56533165ad.118.2024.07.22.09.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 09:07:35 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 richard.henderson@linaro.org
Cc: peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH 4/4] tests/tcg/aarch64: Extend MTE gdbstub tests to system mode
Date: Mon, 22 Jul 2024 16:07:09 +0000
Message-Id: <20240722160709.1677430-5-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240722160709.1677430-1-gustavo.romero@linaro.org>
References: <20240722160709.1677430-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Extend MTE gdbstub tests to also run in system mode (share tests
between user mode and system mode). The tests will only run if a version
of GDB that supports MTE is available in the test environment and if
available compiler supports the 'memtag' flag (-march=armv8.5-a+memtag).

For the tests running in system mode, a page that supports MTE
operations is necessary. Therefore, an MTE-enabled page is made
available (mapped) in the third 2 MB chunk of the second 1 GB space in
the flat mapping set in boot.S. A new binary is also introduced (mte.c)
for the test. It's linked against boot.S and run by QEMU in system mode.

Also, in boot.S bits ATA[43] and TCF[40] are set in SCTLR_EL1 to enable
access to allocation tags at EL1 and enable MTE_SYNC exceptions in case
of Tag Check Faults, and bit TBI0[37] is set in TCR_EL1 so the top byte
of the addresses are ignored in the translation and used for tagged
addresses.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/tcg/aarch64/Makefile.softmmu-target | 36 +++++++++++++++++--
 tests/tcg/aarch64/Makefile.target         |  3 +-
 tests/tcg/aarch64/gdbstub/test-mte.py     | 44 +++++++++++++++--------
 tests/tcg/aarch64/system/boot.S           | 26 ++++++++++++--
 tests/tcg/aarch64/system/kernel.ld        |  5 +++
 tests/tcg/aarch64/system/mte.c            | 40 +++++++++++++++++++++
 6 files changed, 133 insertions(+), 21 deletions(-)
 create mode 100644 tests/tcg/aarch64/system/mte.c

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index dd6d595830..225a073e79 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -2,7 +2,9 @@
 # Aarch64 system tests
 #
 
-AARCH64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/aarch64/system
+AARCH64_SRC=$(SRC_PATH)/tests/tcg/aarch64
+AARCH64_SYSTEM_SRC=$(AARCH64_SRC)/system
+
 VPATH+=$(AARCH64_SYSTEM_SRC)
 
 # These objects provide the basic boot code and helper functions for all tests
@@ -21,7 +23,8 @@ LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
 
 config-cc.mak: Makefile
 	$(quiet-@)( \
-	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3)) 3> config-cc.mak
+	    $(call cc-option,-march=armv8.3-a, CROSS_CC_HAS_ARMV8_3); \
+	    $(call cc-option,-march=armv8.5-a+memtag, CROSS_CC_HAS_ARMV8_MTE)) 3> config-cc.mak
 -include config-cc.mak
 
 # building head blobs
@@ -88,3 +91,32 @@ pauth-3:
 run-pauth-3:
 	$(call skip-test, "RUN of pauth-3", "not built")
 endif
+
+ifneq ($(CROSS_CC_HAS_ARMV8_MTE),)
+QEMU_MTE_ENABLED_MACHINE=-M virt,mte=on -cpu max -display none
+QEMU_OPTS_WITH_MTE_ON = $(QEMU_MTE_ENABLED_MACHINE) $(QEMU_BASE_ARGS) -kernel
+mte: CFLAGS+=-march=armv8.5-a+memtag
+
+run-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
+run-mte: mte
+
+ifeq ($(GDB_HAS_MTE),y)
+run-gdbstub-mte: QEMU_OPTS=$(QEMU_OPTS_WITH_MTE_ON)
+run-gdbstub-mte: mte
+	$(call run-test, $@, $(GDB_SCRIPT) \
+		--gdb $(GDB) \
+		--qemu $(QEMU) --qargs "-chardev file$(COMMA)path=$<.out$(COMMA)id=output $(QEMU_OPTS)" \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py --test-args mode=\"system\", \
+	gdbstub MTE support)
+
+EXTRA_RUNS += run-gdbstub-mte
+else # !GDB_HAS_MTE
+run-gdbstub-mte:
+	$(call skip-test "RUN of gdbstub-mte", "GDB without MTE support")
+endif
+else # !CROSS_CC_HAS_ARMV8_MTE
+mte:
+	$(call skip-test, "BUILD of $@", "missing compiler support")
+run-mte:
+	$(call skip-test, "RUN of mte", "not build")
+endif
diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
index 8cc62eb456..2504517176 100644
--- a/tests/tcg/aarch64/Makefile.target
+++ b/tests/tcg/aarch64/Makefile.target
@@ -138,7 +138,8 @@ run-gdbstub-mte: mte-8
 	$(call run-test, $@, $(GDB_SCRIPT) \
 		--gdb $(GDB) \
 		--qemu $(QEMU) --qargs "$(QEMU_OPTS)" \
-		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py, \
+		--bin $< --test $(AARCH64_SRC)/gdbstub/test-mte.py \
+		--test-args mode=\"user\", \
 	gdbstub MTE support)
 
 EXTRA_RUNS += run-gdbstub-mte
diff --git a/tests/tcg/aarch64/gdbstub/test-mte.py b/tests/tcg/aarch64/gdbstub/test-mte.py
index 2db0663c1a..727999f277 100644
--- a/tests/tcg/aarch64/gdbstub/test-mte.py
+++ b/tests/tcg/aarch64/gdbstub/test-mte.py
@@ -1,13 +1,13 @@
 from __future__ import print_function
 #
 # Test GDB memory-tag commands that exercise the stubs for the qIsAddressTagged,
-# qMemTag, and QMemTag packets. Logical tag-only commands rely on local
-# operations, hence don't exercise any stub.
+# qMemTag, and QMemTag packets, which are used for manipulating allocation tags.
+# Logical tags-related commands rely on local operations, hence don't exercise
+# any stub and so are not used in this test.
 #
-# The test consists in breaking just after a atag() call (which sets the
-# allocation tag -- see mte-8.c for details) and setting/getting tags in
-# different memory locations and ranges starting at the address of the array
-# 'a'.
+# The test consists in breaking just after a tag is set in a specific memory
+# chunk, and then using the GDB 'memory-tagging' subcommands to set/get tags in
+# different memory locations and ranges in the MTE-enabled memory chunk.
 #
 # This is launched via tests/guest-debug/run-test.py
 #
@@ -23,12 +23,26 @@
 
 
 def run_test():
-    gdb.execute("break 95", False, True)
+    if mode == "system":
+        # Break address: where to break before performing the tests
+        # Addresss is the last insn. before 'main' returns. See mte.c
+        ba = "*main+52"
+        # Tagged address: the start of the MTE-enabled memory chunk to be tested
+        # Address is in the x0 register
+        ta = "$x0"
+    else: # mode="user"
+        # Line 95 in mte-8.c
+        ba = "95"
+        # 'a' is an array defined in C code. See mte-8.c
+        ta = "a"
+
+    gdb.execute(f"break {ba}", False, True)
     gdb.execute("continue", False, True)
+
     try:
         # Test if we can check correctly that the allocation tag for
         # array 'a' matches the logical tag after atag() is called.
-        co = gdb.execute("memory-tag check a", False, True)
+        co = gdb.execute(f"memory-tag check {ta}", False, True)
         tags_match = re.findall(PATTERN_0, co, re.MULTILINE)
         if tags_match:
             report(True, f"{tags_match[0]}")
@@ -40,19 +54,19 @@ def run_test():
 
         # Set the allocation tag for the first granule (16 bytes) of
         # address starting at 'a' address to a known value, i.e. 0x04.
-        gdb.execute("memory-tag set-allocation-tag a 1 04", False, True)
+        gdb.execute(f"memory-tag set-allocation-tag {ta} 1 04", False, True)
 
         # Then set the allocation tag for the second granule to a known
         # value, i.e. 0x06. This tests that contiguous tag granules are
         # set correct and don't run over each other.
-        gdb.execute("memory-tag set-allocation-tag a+16 1 06", False, True)
+        gdb.execute(f"memory-tag set-allocation-tag {ta}+16 1 06", False, True)
 
         # Read the known values back and check if they remain the same.
 
-        co = gdb.execute("memory-tag print-allocation-tag a", False, True)
+        co = gdb.execute(f"memory-tag print-allocation-tag {ta}", False, True)
         first_tag = re.match(PATTERN_1, co)[1]
 
-        co = gdb.execute("memory-tag print-allocation-tag a+16", False, True)
+        co = gdb.execute(f"memory-tag print-allocation-tag {ta}+16", False, True)
         second_tag = re.match(PATTERN_1, co)[1]
 
         if first_tag == "0x4" and second_tag == "0x6":
@@ -61,15 +75,15 @@ def run_test():
             report(False, "Can't set/print allocation tags!")
 
         # Now test fill pattern by setting a whole page with a pattern.
-        gdb.execute("memory-tag set-allocation-tag a 4096 0a0b", False, True)
+        gdb.execute(f"memory-tag set-allocation-tag {ta} 4096 0a0b", False, True)
 
         # And read back the tags of the last two granules in page so
         # we also test if the pattern is set correctly up to the end of
         # the page.
-        co = gdb.execute("memory-tag print-allocation-tag a+4096-32", False, True)
+        co = gdb.execute(f"memory-tag print-allocation-tag {ta}+4096-32", False, True)
         tag = re.match(PATTERN_1, co)[1]
 
-        co = gdb.execute("memory-tag print-allocation-tag a+4096-16", False, True)
+        co = gdb.execute(f"memory-tag print-allocation-tag {ta}+4096-16", False, True)
         last_tag = re.match(PATTERN_1, co)[1]
 
         if tag == "0xa" and last_tag == "0xb":
diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 501685d0ec..a12393d00b 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -135,11 +135,22 @@ __start:
 	orr	x1, x1, x3
 	str	x1, [x2]			/* 2nd 2mb (.data & .bss)*/
 
+        /* Third block: .mte_page */
+	adrp	x1, .mte_page
+	add	x1, x1, :lo12:.mte_page
+	bic	x1, x1, #(1 << 21) - 1
+	and 	x4, x1, x5
+	add	x2, x0, x4, lsr #(21 - 3)
+	ldr	x3, =(3 << 53) | 0x401 | 1 << 2	/* attr(AF, NX, block, AttrIndx=Attr1) */
+	orr	x1, x1, x3
+	str	x1, [x2]
+
 	/* Setup/enable the MMU.  */
 
 	/*
 	 * TCR_EL1 - Translation Control Registers
 	 *
+	 * TBI0[37] = 0b1 => Top Byte ignored and used for tagged addresses
 	 * IPS[34:32] = 40-bit PA, 1TB
 	 * TG0[14:15] = b00 => 4kb granuale
 	 * ORGN0[11:10] = Outer: Normal, WB Read-Alloc No Write-Alloc Cacheable
@@ -152,16 +163,22 @@ __start:
 	 * with at least 1gb range to see RAM. So we start with a
 	 * level 1 lookup.
 	 */
-	ldr	x0, = (2 << 32) | 25 | (3 << 10) | (3 << 8)
+	ldr	x0, = (1 << 37) | (2 << 32) | 25 | (3 << 10) | (3 << 8)
 	msr	tcr_el1, x0
 
-	mov	x0, #0xee			/* Inner/outer cacheable WB */
+	/*
+	 * Attr0: Normal, Inner/outer cacheable WB
+	 * Attr1: Tagged Normal (MTE)
+	 */
+	mov	x0, #0xf0ee
 	msr	mair_el1, x0
 	isb
 
 	/*
 	 * SCTLR_EL1 - System Control Register
 	 *
+	 * ATA[43] = 1 = enable access to allocation tags at EL1
+	 * TCF[40] = 1 = Tag Check Faults cause a synchronous exception
 	 * WXN[19] = 0 = no effect, Write does not imply XN (execute never)
 	 * I[12] = Instruction cachability control
 	 * SA[3] = SP alignment check
@@ -169,7 +186,8 @@ __start:
 	 * M[0] = 1, enable stage 1 address translation for EL0/1
 	 */
 	mrs	x0, sctlr_el1
-	ldr	x1, =0x100d			/* bits I(12) SA(3) C(2) M(0) */
+	/* Bits set: ATA(43) TCF(40) I(12) SA(3) C(2) M(0) */
+	ldr	x1, =(0x100d | 1 << 43 | 1 << 40)
 	bic	x0, x0, #(1 << 1)		/* clear bit A(1) */
 	bic	x0, x0, #(1 << 19)		/* clear WXN */
 	orr	x0, x0, x1			/* set bits */
@@ -239,3 +257,5 @@ ttb_stage2:
 stack:
 	.space 65536, 0
 stack_end:
+
+	.section .mte_page
diff --git a/tests/tcg/aarch64/system/kernel.ld b/tests/tcg/aarch64/system/kernel.ld
index 7b3a76dcbf..7c00c1c378 100644
--- a/tests/tcg/aarch64/system/kernel.ld
+++ b/tests/tcg/aarch64/system/kernel.ld
@@ -18,6 +18,11 @@ SECTIONS
     .bss : {
         *(.bss)
     }
+    /* align MTE section to next (third) 2mb */
+    . = ALIGN(1 << 22);
+    .mte : {
+        *(.mte_page)
+    }
     /DISCARD/ : {
         *(.ARM.attributes)
     }
diff --git a/tests/tcg/aarch64/system/mte.c b/tests/tcg/aarch64/system/mte.c
new file mode 100644
index 0000000000..58a5ac31ff
--- /dev/null
+++ b/tests/tcg/aarch64/system/mte.c
@@ -0,0 +1,40 @@
+#include <inttypes.h>
+
+int main(void)
+{
+    uint8_t *addr;
+
+    /*
+     * Third 2MB chunk in the second 1GB block.
+     * See .mte_page section in kernel.ld.
+     */
+    addr = (void *)((1UL << 30) | (1UL << 22));
+
+    asm (
+        /*
+         * Set GCR for randon tag generation. 0xA5 is just a random value to set
+         * GCR != 0 so the tag generated by 'irg' is not zero.
+         */
+        "ldr x1, =0xA5;"
+        "msr gcr_el1, x1;"
+
+         /* Generate a logical tag and put it in 'addr' pointer. */
+         "irg %[addr], %[addr];"
+
+         /*
+          * Store the generated tag to memory region pointed to by 'addr', i.e.
+          * set the allocation tag for the memory region.
+          */
+         "stg %[addr], [%[addr]];"
+
+         /*
+          * Store a random value (0xdeadbeef) to *addr. This must not cause any
+          * Tag Check Fault since logical and allocation tags are set the same.
+          */
+	 "ldr x1, =0xdeadbeef;"
+	 "str x1, [x0];"
+         : [addr] "+r" (addr)
+         :
+         :
+    );
+}
-- 
2.34.1


