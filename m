Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF74AC5DF9D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 05:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzSO9-0002o1-3m; Thu, 27 Aug 2026 01:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSO7-0002l3-Dp
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:10:55 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wzSO4-00047a-HO
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 01:10:55 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38dfe7eb825so1634133a91.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 22:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787807451; x=1788412251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=H3JPY4jlJyqqJXUD7/t3iwMSegC7rW8M+Jxwt7XCKQo=;
 b=Y2u1fXWp0uRUb0/n1Mcw6zxj9jxjP6ov8nvwEWgJaYrbFN7IO0CCd/aZk0CDCuvh+9
 3Qo1bi83BRO4gd03beP12+S2kqKjYJE72yuZGvzgbqNLtxGAExVE9FTetwfrOHcADl7o
 /qn9N19WEfp0RYLMpyypCY8VqeKnIiiwN2XJZ59HAGS0sE3h/xt9kpuWeUM20nYbL9Ig
 Rwy8LMtnVXseLtUZc3TxYiG9f/ZM/tHQCcybaYxesA4l5bLTIbR4mJXZlkzS21kTiSOh
 jx0udSUc5C/CBOvD8fpNOOEoYZKzQZXwFltofR6lm5U8ywrQMSRUFjSzTtuGjV34KUQ9
 rFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787807451; x=1788412251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H3JPY4jlJyqqJXUD7/t3iwMSegC7rW8M+Jxwt7XCKQo=;
 b=D+EHEZ1L0nbzoVP4nxjG24HAoiaho+1Vc31gyHQFzrcfiNT5iZNIZBR8R4nT8czEtf
 ddMf/QDKQPBomqqbnIjOlekQjj/3yZWJAJyKFEQ3hM7G2BfU1wg4QMzVUhMZeGR9Jsmj
 JAgfbTYnp1HXCfdlC9jRa60wCt/dIEzNkllLO24+jCzeGVHOTYfvjycFIYQ6kyVNcl0B
 tHlz/c/K5O7y0HVfle+4wgiAv/YJec3lOv7yrG9K9LQC391gM71t+09ySL+Dg7O60u5y
 tkZElLAymMGTinkkM5c1XiLq3LxcAaD9UbdGtEqyNPTlVd3rcj96opF1lcj7s2pV9SEL
 H2PA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKcqmBIDgAogqpoe1asDLfF/SyyjDDF02teLWKlT0sxDKHhOIVZRfzdJECf6DEDz20KMJ/wB6m2FB/@nongnu.org
X-Gm-Message-State: AFuF++k/awJm9Y1ryNas5hk0Pjzpt/Ix2V7CTJugzR4zAKDOoJLdbVuC
 48VSgwqvJMKII4TVC1bpHuGK8zafyDTceaah2Hn/yMV2t2ez/n2n0slg
X-Gm-Gg: AR+sD12IIgI9hsr6peKTs1Apo8RtMcatoS+jdX5UCMKrZl03fsrENm+R5SHsR1Pga0r
 87QlNXumn0tsjJmsfYg9hsr5cr52PUpgqI0b5EIPxCQ+TLRE6L2mN9KrGb2rGcovISwLsoio+wq
 UlejyvHTAsuU9VT1yH3xtg4Sd/j3dn/CqdPVlOqDpMUJunG7aq1uFBJE7gO1Kumv4e8dsWQsUPC
 83eFgAFuvO+hqvEKwit48s6eeEXZoznCUIjEqD4A9Lqp9e24I3Bfc90+wEfEPTDgU6a4+VjAHty
 f7ba+/rl1M/pxNhyuN5F5XYIqQ1VhQxHTxuYLbImlhwX2jNXN6MdF61if/0CuqY9WlbPKJYjBFs
 8pjiidV7FomYtwqOY45vRgmNLR2TCMLWVTbCbp55FzG15PYQeESNBmLP6VWNTniy1Y3Cdbagfdp
 FbHdKk7+g7+WkWx7RetPWozEvB1GwOLoEOD2eXgil8fpPyv5DZGlXWUyhtxa1NVjx2qnPUCmPT5
 zfxuTcZ9foKZpWz5tbSAQnWw3YXNQeKCV0abCyGE+bkfZ8uEG5uzwnP51mOLnE4AchN2VR5j8WI
 DFtg5Q0OTHjx3uFJXrWw
X-Received: by 2002:a17:90b:2604:b0:38e:ad9d:1151 with SMTP id
 98e67ed59e1d1-3966d18ec9dmr25886586a91.4.1787807450883; 
 Wed, 26 Aug 2026 22:10:50 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39670599275sm2210473a91.0.2026.08.26.22.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 22:10:50 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 06/12] tests/tcg/riscv64: Enable multiarch system tests
Date: Thu, 27 Aug 2026 14:39:45 +0930
Message-ID: <20260827050953.67184-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827050953.67184-1-joel@jms.id.au>
References: <20260827050953.67184-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add the boot code and semihosting helpers needed to run the multiarch
system tests on riscv64, and add riscv64 to MULTIARCH_SOFTMMU_TARGETS.
The aarch64 makefile was used as a guide for the make rules.

boot.S does not clear bss as the libmem plugin test would count the
stores and fail with a mismatch. Instead the BSS is described as
PT_LOAD, so the QEMU ELF loader fills the region with zero, the same as
aarch64 and loongarch64.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 tests/tcg/riscv64/system.c                | 30 +++++++++++++++++
 tests/tcg/Makefile.target                 |  2 +-
 tests/tcg/riscv64/Makefile.softmmu-target | 40 ++++++++++++-----------
 tests/tcg/riscv64/boot.S                  | 23 +++++++++++++
 4 files changed, 75 insertions(+), 20 deletions(-)
 create mode 100644 tests/tcg/riscv64/system.c
 create mode 100644 tests/tcg/riscv64/boot.S

diff --git a/tests/tcg/riscv64/system.c b/tests/tcg/riscv64/system.c
new file mode 100644
index 000000000000..08196a540f96
--- /dev/null
+++ b/tests/tcg/riscv64/system.c
@@ -0,0 +1,30 @@
+/*
+ * RISC-V semihosting support for multiarch test suite
+ *
+ * Copyright 2026 Tenstorrent USA Inc
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "semicall.h"
+
+#define SYS_WRITEC      0x3
+#define SYS_EXIT        0x18
+
+#define ADP_Stopped_ApplicationExit 0x20026
+
+void __sys_outc(char c)
+{
+    __semi_call(SYS_WRITEC, (uintptr_t)&c);
+}
+
+void _exit(int code)
+{
+    const uintptr_t args[2] = { ADP_Stopped_ApplicationExit, (uintptr_t)code };
+
+    __semi_call(SYS_EXIT, (uintptr_t)args);
+
+    /* Hang if QEMU fails to exit */
+    while (1) {
+        asm volatile("wfi");
+    }
+}
diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
index 1b83824ff4e7..d4dd0fec650d 100644
--- a/tests/tcg/Makefile.target
+++ b/tests/tcg/Makefile.target
@@ -129,7 +129,7 @@ else
 EXTRA_CFLAGS += -ffreestanding -fno-stack-protector
 
 # We skip the multiarch tests if the target hasn't provided a boot.S
-MULTIARCH_SOFTMMU_TARGETS = i386 alpha aarch64 arm loongarch64 s390x x86_64
+MULTIARCH_SOFTMMU_TARGETS = i386 alpha aarch64 arm loongarch64 s390x x86_64 riscv64
 
 ifneq ($(filter $(TARGET_NAME),$(MULTIARCH_SOFTMMU_TARGETS)),)
 -include $(SRC_PATH)/tests/tcg/minilib/Makefile.target
diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index f2850a194084..82e8fe2664b0 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -5,9 +5,11 @@
 TEST_SRC = $(SRC_PATH)/tests/tcg/riscv64
 VPATH += $(TEST_SRC)
 
+CRT_OBJS = boot.o system.o
+
 LINK_SCRIPT = $(TEST_SRC)/semihost.ld
-LDFLAGS = -T $(LINK_SCRIPT)
-CFLAGS += -g -Og
+LDFLAGS = -Wl,-T$(LINK_SCRIPT) -static -nostdlib $(MINILIB_OBJS) -lgcc
+CFLAGS += -g -Og $(MINILIB_INC)
 
 # Used by riscv64 tcg tests and shared 'multiarch' tests
 QEMU_CPU = rv64
@@ -53,23 +55,23 @@ test-zicclsm-off.o: test-zicclsm.S
 	$(call quiet-command, \
 	  $(CC) $(CFLAGS) $< -Wa$(COMMA)--noexecstack -c -o $@, CC, $@)
 
-EXTRA_RUNS += run-plugin-doubletrap
-run-plugin-doubletrap: doubletrap
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-		  $(QEMU_OPTS) $<)
-
-EXTRA_RUNS += run-plugin-interruptedmemory
-run-plugin-interruptedmemory: interruptedmemory
-	$(call run-test, $<, \
-	  $(QEMU) -monitor none -display none \
-		  -chardev file$(COMMA)path=$<.out$(COMMA)id=output \
-		  -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
-		  $(QEMU_OPTS) $<)
+ifeq ($(CONFIG_PLUGIN),y)
+EXTRA_RUNS_WITH_PLUGIN += run-plugin-doubletrap-with-libdiscons.so \
+	run-plugin-interruptedmemory-with-libdiscons.so
+endif
 
 CLEANFILES += interruptedmemory doubletrap
 
-# We don't currently support the multiarch system tests
-undefine MULTIARCH_TESTS
+# Multiarch tests
+TESTS += $(MULTIARCH_TESTS)
+EXTRA_RUNS += $(MULTIARCH_RUNS)
+
+.PRECIOUS: $(CRT_OBJS)
+
+# Build and link the multiarch tests
+%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
+	$(call quiet-command, \
+	 $(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS) $(CRT_OBJS), CC, $@)
+
+# Default is zicclsm=true, so misaligned accesses must work
+memory: private CFLAGS += -DCHECK_UNALIGNED=1
diff --git a/tests/tcg/riscv64/boot.S b/tests/tcg/riscv64/boot.S
new file mode 100644
index 000000000000..b403549345a1
--- /dev/null
+++ b/tests/tcg/riscv64/boot.S
@@ -0,0 +1,23 @@
+/*
+ * RISC-V boot code for multiarch test suite
+ *
+ * Copyright 2026 Tenstorrent USA Inc
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#define MSTATUS_VS          0x00000600
+#define MSTATUS_FS          0x00006000
+
+.section .text._start
+        .global _start
+        .type _start, @function
+_start:
+        /* Enable FPU and vector unit */
+        li      t0, (MSTATUS_FS | MSTATUS_VS)
+        csrs    mstatus, t0
+        la      sp, __stack_top
+        call    main
+
+exit:
+        /* exit with main()'s return code */
+        call    _exit
-- 
2.47.3


