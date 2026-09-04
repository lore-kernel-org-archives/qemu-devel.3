Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA95C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:23:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLv-0006Cn-GK; Fri, 04 Sep 2026 01:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLt-00067l-RC
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:37 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLr-0001Hf-MI
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:37 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so564546a12.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499234; x=1789104034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ehIh4pinmiBTyoPz8R7TxyQyDYtySc0Gu8CUVjOFOh8=;
 b=Nwv8LDNNEz1I3m0RXv2KMfH0zpoWarxibf12O3nip0FpIBvAJ6JmFTWqXCgZJRcT1o
 a4c0ewg4lztk7tRyb0SV6kdnwXYfaH/XuS9JUSpG+FnR0ADE93Yt4USapYTUZRDV48eA
 /2oK9eYqwJyRNJeXOx1uRx8ODTudUgtWOeVLr+avawvaORebgmq4inBmvSspxQ3JA/wu
 ExJFfT9oaKiA6fP9SZsxr7QwrATgmSvCiWPGjW6NpHCrYeUKOx60GiRl0mEAWrseNboM
 QJl5EKOPJZwpjvKyGq71BkPjRJgyVBLAVB0dxm1zSYEgHj9MXWh0JQcJAd281parrY3l
 bqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499234; x=1789104034;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ehIh4pinmiBTyoPz8R7TxyQyDYtySc0Gu8CUVjOFOh8=;
 b=nESTYG+qmJAfxsUJ71fy/uFBzHNp47cz5uk5l2mAPFx+KqCpwtgEhv9kRgvMM+Dawv
 Kj9LvyWFkQFVOE9XqbsgsPgtRjo5+iWxG1VdPpeb7HMsucJY0OOnAsnbV9KEF7clE52C
 v6sFVvOCxZpo/9DfXq9RWN73EAVEpyioI7LHgCJukliJyvyzuUio2p/vS7eNp2GaIPSW
 cFugdiHACtTDBnjewptDynztGA1+ZltbLLGuospWBv6ao6C6ehSoZfGYYQUDdeZSfrXF
 hhcE7yrHceTUOLDMDOi+WtFbIvnFlGNHvls+ZwgvLPdR43Cc309rIFz/pxGb2owWfiPX
 2XEw==
X-Gm-Message-State: AFuF++m+3aSjAkRWlh7joVNugVDh1SM0GJdC8RGKmXQO6Qj+r1Z2TR5c
 R7yJVS/CjZLlh7+eZhMep5lv82IG5XCEv/uWQ78WCI4M3e+pI1jy7WT67FlmKQ==
X-Gm-Gg: AYBFou0HHaj7u5SLXEBJkekVKp/3WSthILv1eqSnTKtEN7hp76Ripejv5UOb6WffZRA
 3WqN9cz02m5zgjlrM69E6F8ZicZR5aECAmPB8G1MiOWc9DAeU439sLIvTX69r8WtsGteV75/5Al
 zXlGhb7eG8k5HE2duF8fxF8/DQVYrLVHfywPXRLMTIZ4CVZ1IW9qiSoAAMtDfqbfqa7pJWKcsIM
 iCLCbnw9/jxiD0L0uI8eaD3uCT7IRLV07Uq2tGF48RpyLjuh6T0S5MeBysZVS3ijBUjGdX4GV4G
 fQcW1tdPpwsy2o/6ro6xeonN5FxsTbZRpSbfTr5bzZB/vESANGVothrSi8yQKTbbePc682HR+w8
 34hxY5IvkktIsrhnuRVS568ONFwYSVbAqsUKXIOaPiZg9VAdxnOCG0iYbhKp3zORwZStvcM7RaR
 jIXk939lt//r4KbrrDup5+o861DV+Rc/yg+7EBqxi4mciofhgjSB1CSKIDEziHbkvOHA3srJO0O
 RsSXQ==
X-Received: by 2002:a05:6a21:3a4a:b0:3d3:ad3c:49a7 with SMTP id
 adf61e73a8af0-3da3a1ae36fmr5932625637.21.1788499234263; 
 Thu, 03 Sep 2026 22:20:34 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:33 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 13/47] tests/tcg/riscv64: Add tests for rv128 [ms]status
Date: Fri,  4 Sep 2026 15:19:09 +1000
Message-ID: <20260904051943.799041-14-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Adding asm tests to check that mstatus and sstatus are updated as
expected in an rv128 cpu.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260824174246.202150-1-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   9 ++
 tests/tcg/riscv64/test-rv128-mstatus.S    |  67 ++++++++++++++
 tests/tcg/riscv64/test-rv128-sstatus.S    | 108 ++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 tests/tcg/riscv64/test-rv128-mstatus.S
 create mode 100644 tests/tcg/riscv64/test-rv128-sstatus.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 6a219c306c..575571de90 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -71,5 +71,14 @@ EXTRA_RUNS += run-test-misa-w
 run-test-misa-w: test-misa-w
 	$(call run-test, $<, $(QEMU) -cpu rv64$(comma)x-misa-w=true$(comma)c=true$(comma)v=true $(QEMU_OPTS)$<)
 
+# Test for rv128
+EXTRA_RUNS += run-test-rv128-mstatus
+run-test-rv128-mstatus: test-rv128-mstatus
+	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
+
+EXTRA_RUNS += run-test-rv128-sstatus
+run-test-rv128-sstatus: test-rv128-sstatus
+	$(call run-test, $<, $(QEMU) -cpu x-rv128 $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-rv128-mstatus.S b/tests/tcg/riscv64/test-rv128-mstatus.S
new file mode 100644
index 0000000000..323f65ef90
--- /dev/null
+++ b/tests/tcg/riscv64/test-rv128-mstatus.S
@@ -0,0 +1,67 @@
+/*
+ * Test rv128 mstatus update and access
+ * Author: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define srli(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
+
+    .option norvc
+
+    .text
+    .globl _start
+_start:
+    csrr    s0, misa
+    srli    (s1, s0, 126)
+    li      s0, 3
+    bne     s1, s0, fail
+
+    # Check UXL and SXL are set to RV128 too
+    csrr    s0, mstatus
+    srli    (s1, s0, 32)
+    andi    s1, s1, 0xf
+    li      s0, 0xf
+    bne     s1, s0, fail
+
+    # Mark FPU dirty to check for SD
+    .equiv  MSTATUS_FS, 0x00006000
+    li      s0, MSTATUS_FS
+    csrs    mstatus, s0
+    # Do some useless computation
+    fmadd.s f3, f2, f1, f0
+    fmax.s  f0, f1, f2
+    # Check SD has changed where expected
+    csrr    s0, mstatus
+    srli    (s1, s0, 127)
+    li      s0, 1
+    bne     s1, s0, fail
+    # Mark FPU clean (2 in FS place)
+    li      s0, ~0x00004000
+    csrc    mstatus, s0
+    csrr    s0, mstatus
+    srli    (s1, s0, 13)
+    andi    s1, s1, 3
+    li      s0, 2
+    bne     s1, s0, fail
+    li      a0, 0
+    j       _exit
+fail:
+    li      a0, 1
+_exit:
+    lla     a1, semiargs
+    li      t0, 0x20026 # ADP_Stopped_ApplicationExit
+    sd      t0, 0(a1)
+    sd      a0, 8(a1)
+    li      a0, 0x20    # TARGET_SYS_EXIT_EXTENDED
+
+    # Semihosting call sequence
+    .balign 16
+    slli   zero, zero, 0x1f
+    ebreak
+    srai   zero, zero, 0x7
+    j      .
+
+    .data
+    .balign 16
+semiargs:
+    .space  16
diff --git a/tests/tcg/riscv64/test-rv128-sstatus.S b/tests/tcg/riscv64/test-rv128-sstatus.S
new file mode 100644
index 0000000000..af118e355a
--- /dev/null
+++ b/tests/tcg/riscv64/test-rv128-sstatus.S
@@ -0,0 +1,108 @@
+/*
+ * Test rv128 sstatus update and access
+ * Author: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#define srli(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
+
+    .option norvc
+
+    .text
+    .globl _start
+_start:
+    // Check RV128 is running
+    csrr     s0, misa
+    srli     (s1, s0, 126)
+    li       s0, 3
+    bne      s1, s0, fail
+
+    // Minimal pmp settings
+#define PMP_NAPOT 0x18
+#define PMP_R     0x01
+#define PMP_W     0x02
+#define PMP_X     0x04
+
+    li       s0, -1
+    csrw     pmpaddr0, s0
+    li       s0, PMP_NAPOT | PMP_R | PMP_W | PMP_X
+    csrw     pmpcfg0, s0
+
+    la       s0, backm
+    csrw     mtvec, s0
+
+    // Set MPP to supervisor
+    csrr     s0, mstatus
+    li       s1, ~0x1800 // mask
+    and      s1, s1, s0
+    li       s0, 0x0800  // supervisor
+    or       s1, s1, s0
+    csrw     mstatus, s1
+    // Change to supervisor mode
+    la       s0, 1f
+    csrw     mepc, s0
+    mret
+1:
+    // Check UXL is set to RV128
+    csrr     s0, sstatus
+    srli     (s1, s0, 32)
+    andi     s1, s1, 0x3
+    li       s0, 3
+    bne      s1, s0, fail
+    // Check SPP if is set to 1, since we
+    // come from machine mode
+    srli     (s1, s0, 8)
+    andi     s1, s1, 0x1
+    // Actually this check fails, so test 0
+    li       s0, 0
+    bne      s1, s0, fail
+
+    // Mark FPU dirty to check for SD
+    .equiv   MSTATUS_FS, 0x00006000
+    li       s0,  MSTATUS_FS
+    csrs     sstatus, s0
+    // Do some fun useless computation
+    fmadd.s  f3, f2, f1, f0
+    fmax.s   f0, f1, f2
+    // Check SD has changed where expected
+    csrr     s0, sstatus
+    srli     (s1, s0, 127)
+    li       s0, 1
+    bne      s1, s0, fail
+    // Mark FPU clean (2 in FS place)
+    li       s0, ~0x00004000
+    csrc     sstatus, s0
+    csrr     s0, sstatus
+    srli     (s1, s0, 127)
+    li       s0, 0
+    bne      s1, s0, fail
+
+    // Let's go back to machine mode to exit
+    ecall
+
+    // mtvec bit 1:0 indicate mode, 00 is Direct, what
+    // we want in this simple test
+    .align 4
+backm:
+    li      a0, 0
+    j       _exit
+fail:
+    li      a0, 1
+_exit:
+    lla     a1, semiargs
+    li      t0, 0x20026 # ADP_Stopped_ApplicationExit
+    sd      t0, 0(a1)
+    sd      a0, 8(a1)
+    li      a0, 0x20    # TARGET_SYS_EXIT_EXTENDED
+
+    # Semihosting call sequence
+    .balign 16
+    slli   zero, zero, 0x1f
+    ebreak
+    srai   zero, zero, 0x7
+    j      .
+
+    .data
+    .balign 16
+semiargs:
+    .space  16
-- 
2.55.0


