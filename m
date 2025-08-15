Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5DDCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 19:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un0Fu-0002Ni-6h; Fri, 15 Aug 2025 15:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1un0Fs-0002Lj-CA; Fri, 15 Aug 2025 15:38:24 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>)
 id 1un0Fo-0005xy-BA; Fri, 15 Aug 2025 15:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=PN
 g+wTrmTTLoLgU6tKSOWk/nt3Gsu/A6S6G6VoF0+Lw=; b=ht2yBPHvshOBFbcwKl
 vI8R9XzRvEz1ELGzaqnH++EuOlVcBP3uHhAjYqDIT+19i+3f6558ZWyyS4ntG4Fa
 Rfzq7Lc/WFE1wZCMw7xoBusddiSXtTm+Z9uphCM6BuGUKopAhgar9AKG4fvK2MCZ
 KZQp69fdqQfsjwlawNbVWM6Eg=
Received: from ZEVORN-PC (unknown [])
 by gzsmtp2 (Coremail) with SMTP id Ms8vCgBHf_eFjJ9oXmS4Ag--.35272S4;
 Sat, 16 Aug 2025 03:37:43 +0800 (CST)
From: Chao Liu <chao.liu@yeah.net>
To: paolo.savini@embecosm.com, dbarboza@ventanamicro.com, ebiggers@kernel.org,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Chao Liu <chao.liu@yeah.net>
Subject: [PATCH v1 2/2] tests/tcg/riscv64: Add test for vlsseg8e32 instruction
Date: Sat, 16 Aug 2025 03:37:35 +0800
Message-ID: <9f9171bf03fb15c4caa9196dd7d3b240d9d76785.1755286233.git.chao.liu@yeah.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755286233.git.chao.liu@yeah.net>
References: <cover.1755286233.git.chao.liu@yeah.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ms8vCgBHf_eFjJ9oXmS4Ag--.35272S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr4DXr1UXr1xWF1UCr4rXwb_yoW5urW3pr
 15Gw4qkr4vq343Ka43GF1UuFyrWr4F9F1UXFy8K3W09rW8ZFZruF4ktFWUtFyrAw4UCr13
 uFnYqF1rKanxA3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf9NsUUUUU=
X-Originating-IP: [240e:b8f:29d6:3800:f820:962e:d888:73d]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiBAyqKGifE7XlUgAAss
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

This case, it copied 64 bytes from a0 to a1 with vlsseg8e32.

Signed-off-by: Chao Liu <chao.liu@yeah.net>
---
 tests/tcg/riscv64/Makefile.softmmu-target |   8 +-
 tests/tcg/riscv64/test-vlsseg8e32.S       | 108 ++++++++++++++++++++++
 2 files changed, 114 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/riscv64/test-vlsseg8e32.S

diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
index 7c1d44d3f4..c3c5b66713 100644
--- a/tests/tcg/riscv64/Makefile.softmmu-target
+++ b/tests/tcg/riscv64/Makefile.softmmu-target
@@ -7,18 +7,22 @@ VPATH += $(TEST_SRC)
 
 LINK_SCRIPT = $(TEST_SRC)/semihost.ld
 LDFLAGS = -T $(LINK_SCRIPT)
-CFLAGS += -g -Og
+CFLAGS += -march=rv64gcv -mabi=lp64d -g -Og
 
 %.o: %.S
 	$(CC) $(CFLAGS) $< -Wa,--noexecstack -c -o $@
 %: %.o $(LINK_SCRIPT)
 	$(LD) $(LDFLAGS) $< -o $@
 
-QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
+QEMU_OPTS += -M virt -cpu rv64,v=true -display none -semihosting -device loader,file=
 
 EXTRA_RUNS += run-issue1060
 run-issue1060: issue1060
 	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
 
+EXTRA_RUNS += run-vlsseg8e32
+run-vlsseg8e32: test-vlsseg8e32
+	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
+
 # We don't currently support the multiarch system tests
 undefine MULTIARCH_TESTS
diff --git a/tests/tcg/riscv64/test-vlsseg8e32.S b/tests/tcg/riscv64/test-vlsseg8e32.S
new file mode 100644
index 0000000000..2861ff3702
--- /dev/null
+++ b/tests/tcg/riscv64/test-vlsseg8e32.S
@@ -0,0 +1,108 @@
+#
+# QEMU RISC-V Vector Strided Load Instruction testcase
+#
+# Copyright (c) 2025 Chao Liu chao.liu@yeah.net
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+	.option	norvc
+
+	.section .data
+	.align 4
+source_data:
+	.asciz "Test the vlsseg8e32 insn by copy 64b and verifying correctness."
+	.equ source_len, 64
+
+	.text
+	.global _start
+_start:
+	lla	t0, trap
+	csrw	mtvec, t0
+
+enable_rvv:
+
+	li	x15, 0x800000000024112d
+	csrw	0x301, x15
+	li	x1, 0x2200
+	csrr	x2, mstatus
+	or	x2, x2, x1
+	csrw	mstatus, x2
+
+rvv_test_func:
+	la	a0, source_data
+	li	a1, 0x80020000
+	vsetivli	zero, 1, e32, m1, ta, ma
+	li	t0, 64
+
+	vlsseg8e32.v	v0, (a0), t0
+	addi	a0, a0, 32
+	vlsseg8e32.v	v8, (a0), t0
+
+	vssseg8e32.v	v0, (a1), t0
+	addi	a1, a1, 32
+	vssseg8e32.v	v8, (a1), t0
+
+compare_start:
+	la	a0, source_data
+	li	a1, 0x80020000
+	li	t0, 0
+	li	t1, source_len
+
+compare_loop:
+	# when t0 >= len, compare end
+	bge	 t0, t1, compare_done
+
+	lb	t2, 0(a0)
+	lb	t3, 0(a1)
+	bne	t2, t3, compare_fail
+
+	addi	a0, a0, 1
+	addi	a1, a1, 1
+	addi	t0, t0, 1
+	j	compare_loop
+
+compare_done:
+	# compare ok, return 0
+	li	a0, 0
+	j	_exit
+
+compare_fail:
+	# compare failed, return 2
+	li	a0, 2
+	j	_exit
+
+trap:
+	# When an instruction traps, compare it to the insn in memory.
+	csrr	t0, mepc
+	csrr	t1, mtval
+	lwu	t2, 0(t0)
+	bne	t1, t2, fail
+
+	# Skip the insn and continue.
+	addi	t0, t0, 4
+	csrw	mepc, t0
+	mret
+
+fail:
+	li	a0, 1
+
+# Exit code in a0
+_exit:
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
+	.data
+	.balign	16
+semiargs:
+	.space	16
-- 
2.50.1


