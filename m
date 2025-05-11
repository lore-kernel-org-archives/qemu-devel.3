Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85269C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6dS-0005rE-G3; Sun, 11 May 2025 09:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6dP-0005qC-5G
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:22:28 -0400
Received: from mailgate02.uberspace.is ([2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uE6dL-0008Hu-10
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:22:25 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate02.uberspace.is (Postfix) with ESMTPS id 30C2B17FFB7
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 15:22:21 +0200 (CEST)
Received: (qmail 2786 invoked by uid 990); 11 May 2025 13:22:21 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Sun, 11 May 2025 15:22:20 +0200
From: Julian Ganz <neither@nut.email>
To: qemu-devel@nongnu.org
Cc: Julian Ganz <neither@nut.email>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH v4 23/23] tests: add test with interrupted memory accesses on
 rv64
Date: Sun, 11 May 2025 15:22:05 +0200
Message-ID: <1e94b1c43e90ec21333dcf5ddcf5130090cabfe3.1746968215.git.neither@nut.email>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746968215.git.neither@nut.email>
References: <cover.1746968215.git.neither@nut.email>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Bar: -----
X-Rspamd-Report: REPLY(-4) BAYES_HAM(-2.748368) MID_CONTAINS_FROM(1)
 MIME_GOOD(-0.1) R_MISSING_CHARSET(0.5)
X-Rspamd-Score: -5.348368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=crKlx2dn2hURSJKHwDzuUtnFkIMix7m7bQ8r9DOkiP8=;
 b=FsVbiPPzG2tR8qR6PYEgl4U59camcUvv/8uz0W+HgbWIxeJlnjBHGHWKx8/X9LXvu1r1+XhJYD
 kpwvT/ZHZ0nF9ykLGxBkv3raiJrZTQbqBUaekF+YY3gLiMeFtbJX5t7dUDA/PnHo4JCeV6TJWIRx
 6DwVDbi/VamBi6SXrG4NjnqURopd7SF4fEaTft4hhjwtX6Bzu7FKNtEXTXEq0h+UWivWL8ndQcos
 3tbuPR+sdKpy+qqod/j8sMYmOhYp3sbUwxPEgIWc2jhGJcUhWytX70SnpNpWeFb6k1FuHu54gqY3
 XEH3t+Lth6P7KFvErdy/5DOBqjFVYoLrjrLj6Pdlxo21JXOBxMt3u7OXVTDat2AKXGaoV1jemhGz
 GxQjDvTq19ELxXEh4vEkbEkl+Y4++Fxi4cewzcHw2ak3RdWkqWM4aHbH58UF6LRelbeKW+u2r5/1
 Ku5bzMsMGJAScuTjS1GjAiqSSW1kMq79WxmkjWEuqnW+Dw5Me3heYMluX6yWKGPfx4Wjk6GXXyZd
 O3ByThtCk/nVnSalT98DNR7Kb/rKMhaGNV/qXz7x46gRKu29NXMTuRv/8JqioSn6aMwyKJmHNhaz
 HLzeQbmPmFsVYfYdosIeVRPFGfITr8nnQkGqp0M+GDpCs9YR9Lig8mWHS2OfUwcj/uACO7FydDIv
 w=
Received-SPF: pass client-ip=2a00:d0c0:200:0:1c7b:a6ff:fee0:8ea4;
 envelope-from=neither@nut.email; helo=mailgate02.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This test aims at catching API misbehaviour w.r.t. the interaction
between interrupts and memory accesses, such as the bug fixed in

    27f347e6a1d269c533633c812321cabb249eada8

Because the condition for triggering misbehaviour may not be
deterministic and the cross-section between memory accesses and
interrupt handlers may be small, we have to place our trust in large
numbers. Instead of guessing/trying an arbitrary, fixed loop-bound, we
decided to loop for a fixed amount of real-time. This avoids the test
running into a time-out on slower machines while enabling a high number
of possible interactions on faster machines.

Signed-off-by: Julian Ganz <neither@nut.email>
---
 tests/tcg/riscv64/Makefile.softmmu-target |  6 ++
 tests/tcg/riscv64/interruptedmemory.S     | 67 +++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tests/tcg/riscv64/interruptedmemory.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 5fba973e18..5d07755964 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -26,5 +26,11 @@ run-plugin-doubletrap: doubletrap
 	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
 	  $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-plugin-interruptedmemory
+run-plugin-interruptedmemory: interruptedmemory
+	$(call run-test, $<, \
+	  $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $*.pout \
+	  $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/interruptedmemory.S b/tests/tcg/riscv64/interruptedmemory.S
new file mode 100644
index 0000000000..a32d672849
--- /dev/null
+++ b/tests/tcg/riscv64/interruptedmemory.S
@@ -0,0 +1,67 @@
+	.option norvc
+
+	.text
+	.global _start
+_start:
+	# Set up trap vector
+	lla	t0, trap
+	csrw	mtvec, t0
+
+	# Set up timer
+	lui	t1, 0x02004
+	sd	zero, 0(t1) # MTIMECMP0
+
+	# Enable timer interrupts
+	li	t0, 0x80
+	csrrs	zero, mie, t0
+	csrrsi	zero, mstatus, 0x8
+
+	# Find out when to stop
+	call	rtc_get
+	li	t0, 60
+	slli	t0, t0, 30 # Approx. 10e9 ns
+	add	t0, t0, a0
+
+	# Loop with memory accesses
+	la	t1, semiargs
+0:
+	ld	t2, 0(t1)
+	sd	t2, 0(t1)
+	call	rtc_get
+	bltu	a0, t0, 0b
+
+	li	a0, 0
+	lla	a1, semiargs
+	li	t0, 0x20026	# ADP_Stopped_ApplicationExit
+	sd	t0, 0(a1)
+	sd	a0, 8(a1)
+	li	a0, 0x20	# TARGET_SYS_EXIT_EXTENDED
+
+	# Semihosting call sequence
+	.balign	16
+	slli	zero, zero, 0x1f
+	ebreak
+	srai	zero, zero, 0x7
+	j	.
+
+rtc_get:
+	# Get current time from the goldfish RTC
+	lui	t3, 0x0101
+	lw	a0, 0(t3)
+	lw	t3, 4(t3)
+	slli	t3, t3, 32
+	add	a0, a0, t3
+	ret
+
+trap:
+	lui	t5, 0x0200c
+	ld	t6, -0x8(t5) # MTIME
+	addi	t6, t6, 100
+	lui	t5, 0x02004
+	sd	t6, 0(t5) # MTIMECMP
+	mret
+
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.49.0


